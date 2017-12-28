source common.sh

set -o xtrace

rm_existing_containers_and_volumes

docker volume create xqa-message-broker
docker run -d --net="host" --name="xqa-message-broker" -p 127.0.0.1:1099:1099 -p 127.0.0.1:5672:5672 -p 127.0.0.1:8161:8161 -p 127.0.0.1:61616:61616 jameshnsears/xqa-message-broker
sleep 10

docker run -d --net="host" --name="xqa-ingest-balancer" jameshnsears/xqa-ingest-balancer

#docker run -d --net="host" --name="xqa-shard-1" jameshnsears/xqa-shard
sleep 5

docker ps -a

python --version

export LOGFOLDER=$HOME/tmp
export PYTHONPATH=$HOME/GIT_REPOS/xqa-ingest/src:$PYTHONPATH
export INGESTER=$HOME/GIT_REPOS/xqa-ingest/src/xqa/ingester.py
export TESTDATA=$HOME/GIT_REPOS/xqa-test-data

python $INGESTER -p $TESTDATA > $LOGFOLDER/ingester.log
sleep 90

docker logs xqa-ingest-balancer > $LOGFOLDER/qxa-ingest-balancer.log
docker logs xqa-shard-1 > $LOGFOLDER/xqa-shard-1.log

exit $?
