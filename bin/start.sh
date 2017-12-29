source common.sh

function start() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    NOW=`date --rfc-3339='ns'`
	echo ">>> $NOW $1"
    clone_git_repo $1
    cd $BLD_DIR/$1
    docker-compose -p $DOCKER_ENV up -d
    cd $HOME_DIR 
}

function cadvisor() {
    NOW=`date --rfc-3339='ns'`
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>> $NOW cadvisor"
    docker run --net="host" --volume=/:/rootfs:ro --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --volume=/dev/disk/:/dev/disk:ro --publish=8080:8080 --detach=true --name=cadvisor google/cadvisor:latest
}

rm_existing_containers_and_volumes
cadvisor

# sudo sysctl -w vm.max_map_count=262144
# start xqa-elk

start xqa-message-broker
sleep 10
start xqa-ingest-balancer
start xqa-shard

docker ps -a
docker volume ls

exit $?
