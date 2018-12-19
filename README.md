# XQA - XML Quality Assurance [![CircleCI](https://circleci.com/gh/jameshnsears/xqa-documentation.svg?style=svg)](https://circleci.com/gh/jameshnsears/xqa-documentation)
## 1. Introduction
* XQA is a suite of Docker based microservices that improves the scalability of [BaseX](http://basex.org/) - an XML database engine.
* Instead of loading XML files into a single BaseX engine, XQA distributes them - via an AMQP message broker - across multiple BaseX engines (one XML file per engine).
* XQA ships with a simple UI, and REST API, that lets you eaily run XQuery against the distributed data.

## 2. High Level Design
![High Level Design](uml/xqa-documentation/high-level-design.jpg)

## 3. Key Features
* Easy to deploy / extend:
    * each microservice runs in its own container.
    * end to end integration tests for [TravisCI](https://github.com/jameshnsears/xqa-perf/blob/master/.travis.yml) and [CircleCI](https://github.com/jameshnsears/xqa-documentation/blob/master/.circleci/config.yml) included.
    * add extra BaseX engines easily - they self register against the AMQP message broker.
* Proven scalability & performance improvements - graphs in [xqa-perf](https://github.com/jameshnsears/xqa-perf) show:
    * timing statistics.
    * XML file distribution.
* Transparency:
    * container console logging.
    * JSON instrumentation sent to a central PostgreSQL instance.
* High static analysis / test coverage:
    * [Coveralls](https://coveralls.io/github/jameshnsears/)
    * [Sonarcloud](https://sonarcloud.io/organizations/jameshnsears-github/projects)
    * [Codacy](https://app.codacy.com/)

## 4. Open Source Technologies
* [ActiveMQ 5.15.7](http://activemq.apache.org/)
* [Angular](https://angular.io/)
* Docker CE & Docker Compose:
    * containers can be build from GitHub or pull'd from [hub.docker.com](https://hub.docker.com/)
* Java 10:
    * [OkHttp](http://square.github.io/okhttp/)
    * [Dropwizard](http://www.dropwizard.io/)
    * [Qpid JMS](https://qpid.apache.org/components/jms/index.html)
* PostgreSQL 11
* Python 3.6:
    * [pytest](https://docs.pytest.org/en/latest/)
    * [lxml](https://lxml.de/)
    * [Matplotlib](https://matplotlib.org/)
    * [Qpid Proton](https://qpid.apache.org/proton/)
* Ubuntu 18.04

## 5. Microservices
![microservices](uml/xqa-documentation/microservices.jpg)

| travis-ci.org | GitHub repo. | Lang. | Description |
| ------------- | ------------- | ------------- | ------------- |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-commons-qpid-jms.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-commons-qpid-jms) | [xqa-commons-qpid-jms](https://github.com/jameshnsears/xqa-commons-qpid-jms) | Java | a Maven Central shared library. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-db.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-db) | [xqa-db](https://github.com/jameshnsears/xqa-db) | | PostgreSQL. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-db-amqp.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-db-amqp) | [xqa-db-amqp](https://github.com/jameshnsears/xqa-db-amqp) | Python | AMQP interface to PostgresSQL. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-ingest.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-ingest) | [xqa-ingest](https://github.com/jameshnsears/xqa-ingest) | Java | XML file loader. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-ingest-balancer.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-ingest-balancer) | [xqa-ingest-balancer](https://github.com/jameshnsears/xqa-ingest-balancer) | Java | distributes XML across XQA BaseX engine(s). |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-message-broker.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-message-broker) | [xqa-message-broker](https://github.com/jameshnsears/xqa-message-broker) |  | ActiveMQ. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-shard.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-shard) | [xqa-shard](https://github.com/jameshnsears/xqa-shard) | Python | BaseX engine with AMQP interface. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-query-balancer.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-query-balancer) | [xqa-query-balancer](https://github.com/jameshnsears/xqa-query-balancer) | Java | REST API interface. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-query-ui.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-query-ui) | [xqa-query-ui](https://github.com/jameshnsears/xqa-query-ui) | Angular | UI for querying XQA. |
| [![Build Status](https://travis-ci.org/jameshnsears/xqa-perf.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-perf) | [xqa-perf](https://github.com/jameshnsears/xqa-perf) | Python | end to end integration tests, with Matplotlib graphs. |
|  | [xqa-test-data](https://github.com/jameshnsears/xqa-test-data) |  | a collection of XML files used by XQA. |

## 5. Limitatons
XQA is a proof of concept project. It achieves what it set out to prove, but should not be considered ready for production. Reasons for this include:
* BaseX instances are configured to store data in RAM.
* there is minimal security between services. 

## 6. Current Status
* Refer to the GitHub [issue board](https://github.com/jameshnsears/xqa-documentation/projects/1).
