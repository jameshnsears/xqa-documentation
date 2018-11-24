# Build Prerequisites
This document lists the tools, and installation commands, used to build & test the containers for Ubuntu 18.04.

## 1. IDE's
* Eclipse Java EE IDE for Web Developers. Version: 2018-09 (4.9.0)+
    * PyDev
* IntelliJ IDEA. Version 2018.2.5+
* Pycharm. Version 2018.2.4+
* Visual Studio Code. Version 1.28.2+

## 2. Docker CE & Docker Compose
```
sudo su -
apt update
apt install docker.io docker-compose curl wget
usermod -aG docker xqa  # assuming xqa is user that installed Ubuntu
systemctl start docker
systemctl enable docker
shutdown -r now
```

## 3. git; Java; Python; Maven; Node
TODO - check ALL these things in this file on clean vm

```
sudo apt install git openjdk-11-jdk python3-dev python3-pip python3-distutils python3-tk maven nodejs npm
```

## 4. Build XQA Containers
```
XQA_GIT_REPOS=$HOME/GIT_REPOS
mkdir -p $XQA_GIT_REPOS
cd $XQA_GIT_REPOS

git clone https://github.com/jameshnsears/xqa-perf
cd $XQA_GIT_REPOS/xqa-perf/bin
./build.sh &> build.log &
tail -f build.log
```

Indicative output after build completed:
```
docker images

```

## 4.Unit Test 
```
export DEVPATH=$HOME/xqa/GIT_REPOS
export PYTHONPATH=$DEVPATH/xqa-perf/src:$DEVPATH/xqa-perf/test:$PYTHONPATH
export PATH=$DEVPATH/xqa-perf/bin:$PATH
cd $DEVPATH/xqa-perf

pip3 install -r requirements.txt

XQA_TEST_DATA=$XQA_GIT_REPOS/xqa-test-data pytest -s
```

### 5. Integration Test
```
export XQA_GIT_REPOS=$HOME/xqa/GIT_REPOS
cd $XQA_GIT_REPOS
git clone https://github.com/jameshnsears/xqa-test-data

cd $XQA_GIT_REPOS/xqa-perf/bin
SHARDS=1 XQA_TEST_DATA=$XQA_GIT_REPOS/xqa-test-data ./e2e.sh

# wait / docker logs <xqa-ingest | xqa-shard>

docker logs xqa-shard | grep "size=40"
```
