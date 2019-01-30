#!/usr/bin/env bash

docker tag xqa-query-ui localhost:32000/xqa-query-ui
docker tag xqa-db localhost:32000/xqa-db
docker tag xqa-db-amqp localhost:32000/xqa-db-amqp
docker tag xqa-message-broker localhost:32000/xqa-message-broker
docker tag xqa-shard localhost:32000/xqa-shard
docker tag xqa-ingest localhost:32000/xqa-ingest
docker tag xqa-ingest-balancer localhost:32000/xqa-ingest-balancer
docker tag xqa-query-balancer localhost:32000/xqa-query-balancer

docker images
