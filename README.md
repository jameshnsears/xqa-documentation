# XQA - XML Quality Assurance [![CircleCI](https://circleci.com/gh/jameshnsears/xqa-documentation.svg?style=svg)](https://circleci.com/gh/jameshnsears/xqa-documentation)
## 1. Introduction
* XQA is a suite of Docker based Microservices that improves the scalability of [BaseX](http://basex.org/) - an XML database engine.
* Instead of loading XML files into a single BaseX engine, XQA distributes them - via an AMQP message broker - across multiple BaseX engines.
* XQA ships with a simple web based UI that allows XQuery and Audit queries.

## 2. High Level Design
![High Level Design](uml/xqa-documentation/high-level-design.jpg)

## 3. Key Features
* easy to deploy:
    * each Microservice runs in a Docker container.
    * end to end integration tests for [Travis](https://github.com/jameshnsears/xqa-perf/blob/master/.travis.yml) and [Circle CI](https://github.com/jameshnsears/xqa-documentation/blob/master/.circleci/config.yml) are included.
* transparency:
    * container console logging.
    * JSON instrumentation sent to a PostgreSQL instance.
    * Matplotlib performance graphs.
* high unit test code coverage.
* completely open-source.

## 4. Technologies Used
* AMQP 1.0 compatible message broker:
    * [ActiveMQ 5.15.7](http://activemq.apache.org/)
* [Angular](https://angular.io/)
* Docker CE & Docker Compose
	* 
* Java 11:
    * [Dropwizard](http://www.dropwizard.io/)
    * Maven.
    * [Qpid JMS](https://qpid.apache.org/components/jms/index.html)
* PostgreSQL
* Python 3.6:
    * [lxml](https://lxml.de/)
    * [Matplotlib](https://matplotlib.org/)
    * [pytest](https://docs.pytest.org/en/latest/)
    * [Qpid Proton](https://qpid.apache.org/proton/)
* Ubuntu 18.04

## 5. The Microservices
Each Microservice:
* lives in a separate GitHub repository.
* contains build instructions in a README file.
* has a .travis.yml file - demonstrating usage / deployment / coverage.

![microservices](uml/xqa-documentation/microservices.jpg)

## 5.1 GitHub repositories
* [![Build Status](https://travis-ci.org/jameshnsears/xqa-commons-qpid-jms.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-commons-qpid-jms) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-commons-qpid-jms/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-commons-qpid-jms?branch=master) [xqa-commons-qpid-jms](https://github.com/jameshnsears/xqa-commons-qpid-jms) - maven central hosted common qpid-jms code.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-db.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-db) [xqa-db](https://github.com/jameshnsears/xqa-db) - PostgreSQL.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-db-amqp.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-db-amqp) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-db-amqp/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-db-amqp?branch=master) [xqa-db-amqp](https://github.com/jameshnsears/xqa-db-amqp) - AMQP PostgresSQL interface.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-ingest.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-ingest) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-ingest/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-ingest?branch=master) [xqa-ingest](https://github.com/jameshnsears/xqa-ingest) - loads XML files into XQA.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-ingest-balancer.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-ingest-balancer) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-ingest-balancer/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-ingest-balancer?branch=master) [xqa-ingest-balancer](https://github.com/jameshnsears/xqa-ingest-balancer) - "evenly" distributes XML / XQuery across XQA.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-message-broker.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-message-broker) [xqa-message-broker](https://github.com/jameshnsears/xqa-message-broker) - AMQP message broker - ActiveMQ.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-shard.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-shard) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-shard/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-shard?branch=master) [xqa-shard](https://github.com/jameshnsears/xqa-shard) - BaseX instance with a AMQP interface.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-query-balancer.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-query-balancer) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-query-balancer/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-query-balancer?branch=master) [xqa-query-balancer](https://github.com/jameshnsears/xqa-query-balancer) - REST API to execute SQL/JSON queries.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-query-ui.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-query-ui) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-query-ui/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-query-ui?branch=master) [xqa-query-ui](https://github.com/jameshnsears/xqa-query-ui) - UI for querying XQA.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-perf.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-perf) [xqa-perf](https://github.com/jameshnsears/xqa-perf) - end to end integration tests.

* [xqa-test-data](https://github.com/jameshnsears/xqa-test-data) - test data - XML files - used by tests.

## 6. Limitations
* BaseX instances are configured to store data in RAM.

## 7. Current Status
* For current status refer to the [issue board](https://github.com/jameshnsears/xqa-documentation/projects/1) in GitHub.
