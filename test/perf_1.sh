source perf.sh

LOGFOLDER=$HOME/tmp
SHARDINSTANCES=1

rm_existing_containers_and_volumes
start_static_group
start_dynamic_group $SHARDINSTANCES
docker ps -a

start_ingest

capture_group_logs $SHARDINSTANCES

pytest

exit $?
