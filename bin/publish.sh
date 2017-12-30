function publish_to_docker_hub() {
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    NOW=`date --rfc-3339='ns'`
    echo ">>> $NOW publish_to_docker_hub $1"
    docker tag $1 jameshnsears/$1
    docker login -u jameshnsears
    docker push jameshnsears/$1:latest
    docker rmi jameshnsears/$1:latest
}

# publish_to_docker_hub xqa-elk-elasticsearch
# publish_to_docker_hub xqa-elk-kibana
# publish_to_docker_hub xqa-elk-logstash
# publish_to_docker_hub xqa-message-broker-filebeat
publish_to_docker_hub xqa-message-broker
publish_to_docker_hub xqa-ingest-balancer
publish_to_docker_hub xqa-shard

docker search jameshnsears

exit $?
