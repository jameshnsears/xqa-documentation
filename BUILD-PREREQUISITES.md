# Build Prerequisites
This document lists the tools, and installation commands, used to build & test the containers for Ubuntu 18.04.

## 1. IDE's
* Eclipse Java EE IDE for Web Developers.
    * PyDev
* IntelliJ IDEA.
* Pycharm.
* Visual Studio Code.

### 1.1. Useful IDE Extensions
* PMD
* SpotBugs
* CheckStyle
* Sonalint

## 2. Docker CE & Docker Compose
```
sudo su -

apt update

apt install docker.io docker-compose curl wget

usermod -aG docker jsears # devloper account

systemctl start docker

systemctl enable docker

shutdown -r now
```

## 3. git; Java; Python; Maven; Node; etc... 
```
sudo apt install git openjdk-11-jdk python3-dev python3-pip python3-distutils python3-tk maven nodejs npm postgresql-client ruby ruby-dev socat

sudo gem install travis
```

## 4. Build XQA Containers
```
cd 

git clone https://github.com/jameshnsears/xqa-perf

xqa-perf/bin/build-images.sh
```

### 4.1. End 2 End Test
```
git clone https://github.com/jameshnsears/xqa-test-data

git clone https://github.com/jameshnsears/xqa-documentation

sed -i 's/jameshnsears\///g' xqa-documentation/docker-compose.yml

docker-compose -f xqa-documentation/docker-compose.yml up -d --scale xqa-shard=1

docker run -d --net="xqadocumentation_xqa" --name="xqa-ingest" -v ~/xqa-test-data:/xml xqa-ingest:latest 
-message_broker_host xqa-message-broker -path /xml

sleep 180

docker logs xqa-shard | grep "size=40"
```

## 6. socat
```
sudo mv /var/run/docker.sock /var/run/hidden.socket

sudo socat -t100 -x -v UNIX-LISTEN:/var/run/docker.sock,mode=777,reuseaddr,fork UNIX-CONNECT:/var/run/hidden.socket

sudo mv /var/run/hidden.socket /var/run/docker.sock
```
