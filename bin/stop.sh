source common.sh

rm_existing_containers_and_volumes
docker ps -a
docker volume ls

exit $?
