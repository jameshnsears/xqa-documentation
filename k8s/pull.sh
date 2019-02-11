#!/usr/bin/env bash

source common.sh

reset_docker_env

docker pull jameshnsears/xqa-db
docker pull jameshnsears/xqa-db-amqp
docker pull jameshnsears/xqa-ingest
docker pull jameshnsears/xqa-ingest-balancer
docker pull jameshnsears/xqa-message-broker
docker pull jameshnsears/xqa-query-balancer
docker pull jameshnsears/xqa-query-ui
docker pull jameshnsears/xqa-shard

docker images
