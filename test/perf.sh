source ../bin/common.sh

function start_static_group() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW start_static_group $1"
    docker volume create xqa-message-broker
    docker run -d --net="host" --name="xqa-message-broker" -p 127.0.0.1:1099:1099 -p 127.0.0.1:5672:5672 -p 127.0.0.1:8161:8161 -p 127.0.0.1:61616:61616 jameshnsears/xqa-message-broker
    sleep 10

    docker run -d --net="host" --name="xqa-ingest-balancer" jameshnsears/xqa-ingest-balancer
}

function start_dynamic_group() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW start_dynamic_group $1"

    for ((i=1; i<=$1; i++))
    do
        docker run -d --net="host" --name="xqa-shard-${i}" jameshnsears/xqa-shard
    done

    sleep 5
}

function start_ingest() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW start_ingest $1"
    SRCROOT=$HOME/GIT_REPOS
    export PYTHONPATH=$SRCROOT/xqa-ingest/src:$PYTHONPATH
    INGESTER=$SRCROOT/xqa-ingest/src/xqa/ingester.py
    python $INGESTER -p $SRCROOT/xqa-test-data > $LOGFOLDER/ingester.log
    sleep 90
}

function capture_group_logs() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    export NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW capture_group_logs $1"
    docker logs xqa-ingest-balancer > $LOGFOLDER/xqa-ingest-balancer.log

    for ((i=1; i<=$1; i++))
    do
        docker logs xqa-shard-${i} > $LOGFOLDER/xqa-shard-${i}.log
    done
}
