# Building
* see [common instructions](common-instructions.md).

## 1. IDE's
XQA was built using:
* [Eclipse](http://www.eclipse.org/) with pydev
* [IntelliJ IDEA](https://www.jetbrains.com/idea/) Community Edition
* [PyCharm](https://www.jetbrains.com/pycharm) Community Edition

## 2. Development
* You'll need at least 4GB of RAM to develop and much more if you want multiple shards.
* The most important service is to have the xqa-message-broker up and running - without it you'll be unable to start up any of the other microservices.
* Once the broker is running, simply develop along the usual GitHub [Pull Request](https://help.github.com/articles/about-pull-requests) process. Take into account that the .travis.yml files are tied to the master branches.
* The software uses Qpid libraries, which are AMQP 1.0 compliant - meaning only AMQP 1.0 compliant message brokers will work with the XQA software. This also means, for example, that pure JMS clients will not be interoperable with the XQA, AMQP, queues.

## 3. Building Images / Starting Containers / Publishing Images To [hub.docker.com](http://hub.docker.com)
* see the bash shell scripts in [xqa-documentation/bin](https://github.com/jameshnsears/xqa-documentation/tree/master/bin).
* you will need [Maven](https://maven.apache.org/) to be installed and in your path to successfully run build.sh

## 4. Message Broker Queues / "Topics"
???

## 5. Misc. Docker Commands
export IMG_NAME=<...>

### 5.1. build image
docker image build -t ${IMG_NAME} .

docker volume create --driver local --opt type=nfs --opt o=addr=<ip of nfs server>,rw --opt device=:<nfs mount path> ${IMG_NAME}

### 5.2. run container
docker volume create --driver local ${IMG_NAME}

docker run -d --name="${IMG_NAME}" --net="host" -p 5672:5672 -p 8161:8161 jameshnsears/${IMG_NAME}

docker run --net="host" -it ${IMG_NAME}:latest /bin/bash

### 5.3. Misc.
docker-compose stop

docker stop $(docker ps -aq)

docker rm $(docker ps -aq)
