source common.sh

function rm_all_containers_volumes_and_images() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    export NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW rm_all_containers_volumes_and_images"
    docker stop $(docker ps -a -q) > /dev/null 2>&1
    docker rm $(docker ps -a -q) > /dev/null 2>&1
    docker volume prune -f > /dev/null 2>&1
    docker images -q | xargs docker rmi -f . > /dev/null 2>&1
}

function docker_compose_build() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    export NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW docker_compose_build $1"
    clone_git_repo $1
    cd $BLD_DIR/$1
    docker-compose -p $DOCKER_ENV build
    cd $HOME_DIR
}

function mvn_docker_compose_build() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    export NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW mvn_docker_compose_build $1"
    clone_git_repo $1
    cd $BLD_DIR/$1
    mvn clean compile package -DskipTests
    docker-compose -p $DOCKER_ENV build
    cd $HOME_DIR
}

function cadvisor() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    export NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW cadvisor"
    docker pull google/cadvisor:latest
}

rm_all_containers_volumes_and_images
cadvisor
docker_compose_build xqa-elk
docker_compose_build xqa-message-broker
mvn_docker_compose_build xqa-ingest-balancer
docker_compose_build xqa-shard

exit $?
