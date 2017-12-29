export BLD_DIR=/tmp/xqa
export HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DOCKER_ENV="dev"

function create_build_dir() {
    if [ -d "$BLD_DIR" ]; then
        rm -rf $BLD_DIR
    fi
    mkdir $BLD_DIR
}

function clone_git_repo() {
    create_build_dir
    NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW clone_git_repo"
    git clone https://github.com/jameshnsears/$1 $BLD_DIR/$1
}

function rm_existing_containers_and_volumes() {
    NOW=`date --rfc-3339='ns'`
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    echo ">>> $NOW rm_existing_containers_and_volumes"
    docker stop $(docker ps -a -q) > /dev/null 2>&1
    docker rm $(docker ps -a -q) > /dev/null 2>&1
    docker volume prune -f > /dev/null 2>&1
}
