source perf.sh

export LOGFOLDER=$HOME/tmp
SHARDINSTANCES=1

rm_existing_containers_and_volumes

start_group_static
start_group_dynamic $SHARDINSTANCES

docker ps -a

start_ingest

capture_group_logs $SHARDINSTANCES

pytest

exit $?
