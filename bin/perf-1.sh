source common.sh

LOGFOLDER=$HOME/tmp

function start_static_group() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    export NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW start_static_group $1"
    docker volume create xqa-message-broker
    docker run -d --net="host" --name="xqa-message-broker" -p 127.0.0.1:1099:1099 -p 127.0.0.1:5672:5672 -p 127.0.0.1:8161:8161 -p 127.0.0.1:61616:61616 jameshnsears/xqa-message-broker
    sleep 10

    docker run -d --net="host" --name="xqa-ingest-balancer" jameshnsears/xqa-ingest-balancer
    docker ps -a
}

function start_dynamic_group() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    export NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW start_dynamic_group $1"
    docker run -d --net="host" --name="xqa-shard-1" jameshnsears/xqa-shard
    sleep 5
    docker ps -a
}

function start_ingest() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    export NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW start_ingest $1"
    SRCROOT=$HOME/GIT_REPOS
    PYTHONPATH=$SRCROOT/xqa-ingest/src:$PYTHONPATH
    INGESTER=$SRCROOT/xqa-ingest/src/xqa/ingester.py
    python --version
    python $INGESTER -p $SRCROOT/xqa-test-data > $LOGFOLDER/ingester.log
    sleep 90
}

function capture_group_logs() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    export NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW capture_group_logs $1"
    docker logs xqa-ingest-balancer > $LOGFOLDER/qxa-ingest-balancer.log
    docker logs xqa-shard-1 > $LOGFOLDER/xqa-shard-1.log
}

rm_existing_containers_and_volumes
start_static_group

shard_counter=1
for container_name in `docker ps -a --format '{{.Names}}'`
do
    echo $shard_counter $container_name 
    shard_counter=$[$shard_counter +1]
done

# start_dynamic_group
# start_ingest
# capture_group_logs

exit $?
