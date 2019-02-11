#!/usr/bin/env bash

docker push localhost:32000/xqa-query-ui 
docker push localhost:32000/xqa-db
docker push localhost:32000/xqa-db-amqp
docker push localhost:32000/xqa-message-broker
docker push localhost:32000/xqa-shard
docker push localhost:32000/xqa-ingest
docker push localhost:32000/xqa-ingest-balancer
docker push localhost:32000/xqa-query-balancer

curl http://127.0.0.1:32000/v2/_catalog
# curl -X GET http://127.0.0.1:32000/v2/v2/xqa-db/tags/list