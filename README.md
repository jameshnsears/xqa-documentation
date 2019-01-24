# XQA - XML Quality Assurance [![CircleCI](https://circleci.com/gh/jameshnsears/xqa-documentation.svg?style=svg)](https://circleci.com/gh/jameshnsears/xqa-documentation)
## 1. Introduction
* XQA is a suite of Docker based microservices that improves the scalability of [BaseX](http://basex.org/) - an XML database engine.
* Instead of loading each XML file into a single BaseX engine, XQA distributes them - via an AMQP message broker - across multiple BaseX engines.
* XQA ships with a simple UI that lets you easily run XQuery against the distributed data.

## 2. High Level Design
![High Level Design](uml/high-level-design.jpg)

## 3. Key Features
* Easy to deploy / extend:
    * each microservice runs in its own container.
    * add extra BaseX engines easily - they self register against the AMQP message broker.
* Proven scalability & performance improvements - graphs in [xqa-perf](https://github.com/jameshnsears/xqa-perf) show:
    * ingest timing statistics.
    * XML file distribution.
* [Continuous Integration; extensive static analysis & high test coverage](QUALITY-RADIATOR.md).
* Transparency:
    * container console logging.
    * JSON instrumentation sent to a central PstgreSQL instance.

## 4. Open Source Technologies
* ActiveMQ
* Angular
* Docker - containers can be built from GitHub or pull'd from [hub.docker.com](https://hub.docker.com/).
* Java 10
* PostgreSQL 11
* Python 3.6
* Ubuntu 18.04

## 5. Microservices
![microservices](uml/microservices.jpg)

| travis-ci | GitHub repo. | Description |
| ------------- | ------------- | ------------- |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-commons-qpid-jms.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-commons-qpid-jms) | [xqa-commons-qpid-jms](https://github.com/jameshnsears/xqa-commons-qpid-jms) | a Maven Central shared library. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-db.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-db) | [xqa-db](https://github.com/jameshnsears/xqa-db) | PostgreSQL. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-db-amqp.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-db-amqp) | [xqa-db-amqp](https://github.com/jameshnsears/xqa-db-amqp) | AMQP interface to PostgresSQL. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-ingest.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-ingest) | [xqa-ingest](https://github.com/jameshnsears/xqa-ingest) | XML file loader. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-ingest-balancer.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-ingest-balancer) | [xqa-ingest-balancer](https://github.com/jameshnsears/xqa-ingest-balancer) | distributes XML across XQA BaseX engine(s). |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-message-broker.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-message-broker) | [xqa-message-broker](https://github.com/jameshnsears/xqa-message-broker) | ActiveMQ. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-perf.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-perf) | [xqa-perf](https://github.com/jameshnsears/xqa-perf) | end to end integration tests, with Matplotlib graphs. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-query-balancer.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-query-balancer) | [xqa-query-balancer](https://github.com/jameshnsears/xqa-query-balancer) | XQA REST API. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-query-ui.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-query-ui) | [xqa-query-ui](https://github.com/jameshnsears/xqa-query-ui) | UI for querying XQA. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-shard.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-shard) | [xqa-shard](https://github.com/jameshnsears/xqa-shard) | BaseX engine with AMQP interface. |
| | [xqa-test-data](https://github.com/jameshnsears/xqa-test-data) | a collection of XML files used by XQA. |

## 5. Limitatons
XQA is a proof of concept project. It [scratched an itch](https://en.wikipedia.org/wiki/The_Cathedral_and_the_Bazaar) and achieved what it set out to prove, but should not be considered ready for production. Reasons for this include:
* lack of "bullet proofing" - i.e. what happens if xqa-message-broker disappears?
* optimising the responses of the xqa-query-balancer for xquery searches, so that data from all shards is always returned but as fast as possible.
* there is minimal security between services.

## 6. Current Status
* Refer to the GitHub [issue board](https://github.com/jameshnsears/xqa-documentation/projects/1).
