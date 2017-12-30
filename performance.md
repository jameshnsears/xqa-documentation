# Performance
This section compares the performance of BaseX (file system) v. BaseX (in-memory) v. XQA (n shards, in-memory).

The test involves running /test/perf_test.sh with an appropriate SHARDINSTANCES value.

Each test run includes:
* a tear down of the containers - creating a clean environemnt.
* a test, based on sha256 + correlecton_id values, to ensure all data has passed end to end (ingest to shard).

The test includes a check

## 1. Environment
* CentOS 7 VM, running on a SSD with 8GB of RAM.
* using xqa-test-data

## 2. Results

## 2.1. One shard
* SHARDINSTANCES=1

## 2.2. Two shards
* SHARDINSTANCES=2

## 2.3. Four shard
* SHARDINSTANCES=4
