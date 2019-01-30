#!/usr/bin/env bash

docker push localhost:32000/xqa-query-ui 
docker push localhost:32000/xqa-db
docker push localhost:32000/xqa-db-amqp
docker push localhost:32000/xqa-message-broker
docker push localhost:32000/xqa-shard
docker push localhost:32000/xqa-ingest
docker push-balancer localhost:32000/xqa-ingest-balancer
docker push localhost:32000/xqa-query-balancer

docker images localhost:32000
