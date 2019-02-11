#!/usr/bin/env bash

function reset_docker_env() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    echo ">>> $(date --rfc-3339='ns') reset_docker_env"
    docker stop $(docker ps -a -q) > /dev/null 2>&1
    docker rm $(docker ps -a -q) > /dev/null 2>&1
    docker rmi -f $(docker images -q) > /dev/null 2>&1
    docker volume prune -f > /dev/null 2>&1
    docker network prune -f > /dev/null 2>&1
}
