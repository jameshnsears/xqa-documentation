#!/usr/bin/env bash

docker tag jameshnsears/xqa-query-ui localhost:32000/xqa-query-ui
docker tag jameshnsears/xqa-db localhost:32000/xqa-db
docker tag jameshnsears/xqa-db-amqp localhost:32000/xqa-db-amqp
docker tag jameshnsears/xqa-message-broker localhost:32000/xqa-message-broker
docker tag jameshnsears/xqa-shard localhost:32000/xqa-shard
docker tag jameshnsears/xqa-ingest localhost:32000/xqa-ingest
docker tag jameshnsears/xqa-ingest-balancer localhost:32000/xqa-ingest-balancer
docker tag jameshnsears/xqa-query-balancer localhost:32000/xqa-query-balancer

docker images
