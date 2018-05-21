# XQA - XML Quality Assurance [![CircleCI](https://circleci.com/gh/jameshnsears/xqa-documentation.svg?style=svg)](https://circleci.com/gh/jameshnsears/xqa-documentation)
## 1. Introduction
XQA is a **work in progress** project that improves the scalability of [BaseX](http://basex.org/) - an XML Database.

Visit [xqa-perf](https://github.com/jameshnsears/xqa-perf) to read about measured scalability improvements achieved (so far).

Installation apt / yum dependencies are listed in [Build Prerequisites](https://github.com/jameshnsears/xqa-documentation/blob/master/BUILD-PREREQUISITES.md).

### 1.1. Key Features
* easy to deploy, see:
    * [.travis.yml](https://github.com/jameshnsears/xqa-perf/blob/master/.travis.yml) for a simple end to end integration example.
    * [.circleci/config.yml](https://github.com/jameshnsears/xqa-documentation/blob/master/.circleci/config.yml) for a more complete end to end integration test.
* extensive instrumentation / auditing - JSON messages stored in a relational database & console logging in containers.
* "even" distribution of data against self-registering shards via AMQP destinations.
* proven coverage & end to end testing of codebase.
* simple UI / REST API - to execute XQuery across shard(s) / interrogate instrumentation.
* completely open-source.

## 2. High Level Design
At the heart of the design are Docker containers and an AMQP message broker. Container based microservices leverage the broker to ingest and evenly distribute XML across BaseX instances (at the moment data is stored in RAM, not volume).

A centralised PostgreSQL persists JSON instrumentation that can be used for ad-hoc auditing queries.

![High Level Design](uml/high-level-design-sequence-diagram.jpg)

## 3. Microservices
XQA is composed of distinct, container based, microservices, each:
* lives in a separate GitHub repo.
* contains build instructions in a README file.
* has a .travis.yml file - demonstrating usage / deployment / coverage.

![microservices](uml/demo-environment-without-elk.jpg)

To speed some travis builds, each service is also packaged in a seperate container available from [hub.docker.com](https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=jameshnsears&starCount=0).

### 3.1. Core Services
* [![Build Status](https://travis-ci.org/jameshnsears/xqa-commons-qpid-jms.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-commons-qpid-jms) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-commons-qpid-jms/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-commons-qpid-jms?branch=master) [xqa-commons-qpid-jms](https://github.com/jameshnsears/xqa-commons-qpid-jms) - maven central hosted, common qpid-jms functionality used by various xqa projects.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-db.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-db) [xqa-db](https://github.com/jameshnsears/xqa-db) - a PostgreSQL instance, used to aggregate logging.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-db-amqp.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-db-amqp) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-db-amqp/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-db-amqp?branch=master) [xqa-db-amqp](https://github.com/jameshnsears/xqa-db-amqp) - a AMQP to PostgresSQL interface.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-ingest.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-ingest) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-ingest/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-ingest?branch=master) [xqa-ingest](https://github.com/jameshnsears/xqa-ingest) - loads the contents of XML files, from the file system, into an AMQP queue.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-ingest-balancer.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-ingest-balancer) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-ingest-balancer/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-ingest-balancer?branch=master) [xqa-ingest-balancer](https://github.com/jameshnsears/xqa-ingest-balancer) - evenly distributes the ingested XML across one or more shards.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-message-broker.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-message-broker) [xqa-message-broker](https://github.com/jameshnsears/xqa-message-broker) - an ActiveMQ instance that provides AMQP and HTTP interfaces.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-shard.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-shard) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-shard/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-shard?branch=master) [xqa-shard](https://github.com/jameshnsears/xqa-shard) - an embedded in-memory BaseX instance with a AMQP interface.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-query-balancer.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-query-balancer) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-query-balancer/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-query-balancer?branch=master) [xqa-query-balancer](https://github.com/jameshnsears/xqa-query-balancer) - provides a REST API to execute: SQL/JSON against xqa-db; XQuery against each xqa-shard and materialises the results.

* [![Build Status](https://travis-ci.org/jameshnsears/xqa-query-ui.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-query-ui) [![Coverage Status](https://coveralls.io/repos/github/jameshnsears/xqa-query-ui/badge.svg?branch=master)](https://coveralls.io/github/jameshnsears/xqa-query-ui?branch=master) [xqa-query-ui](https://github.com/jameshnsears/xqa-query-ui) - a simple web UI to run XQuery and for ad-hoc status / auditing queries.

### 3.2. Optional Services
* [![Build Status](https://travis-ci.org/jameshnsears/xqa-elk.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-elk) [xqa-elk](https://github.com/jameshnsears/xqa-elk) - Logstash (with Filebeat grok for ActiveMQ audit log); Elasticsearch; Kibana.
* [![Build Status](https://travis-ci.org/jameshnsears/xqa-perf.svg?branch=master)](https://travis-ci.org/jameshnsears/xqa-perf) [xqa-perf](https://github.com/jameshnsears/xqa-perf) - end to end performance metrics / environment construction.
* [xqa-test-data](https://github.com/jameshnsears/xqa-test-data) - sample XML files.

## 4. Technologies
* [ActiveMQ](http://activemq.apache.org/)
* [Angular](https://angular.io/)
* [BaseX](http://basex.org/)
* [Docker CE](https://docs.docker.com/engine/) & [Docker Compose](https://docs.docker.com/compose/)
* IDE's
    * [eclipse](https://www.eclipse.org/) with [PyDev](http://www.pydev.org/)
    * [IntelliJ IDEA Community](https://www.jetbrains.com/idea/)
    * [PyCharm Community](https://www.jetbrains.com/pycharm/)
    * [Visual Studio Code](https://code.visualstudio.com/)
* [Java 8](http://www.oracle.com/technetwork/java/javase/downloads/index-jsp-138363.html)
    * [Dropwizard](http://www.dropwizard.io/)
    * [Qpid JMS](https://qpid.apache.org/components/jms/index.html)
* Linux
    * [CentOS 7](https://wiki.centos.org/Download)
    * [Debian Stretch](https://www.debian.org/releases/)
* [PostgreSQL 10.1](https://www.postgresql.org/)
* [Python 3.5+](https://www.python.org/)
    * [Apache Qpid Proton](https://qpid.apache.org/proton/)

## 5. Limitations
Remember: XQA is **work in progress**...
* Shards store data in RAM.
* Security not implemented - i.e. default username and passwords are used for UI components & SSL / SASL is not used.
* Transactions not implemented.

## 6. Current Status
For current status refer to the [issue board](https://github.com/jameshnsears/xqa-documentation/projects/1) in GitHub.
