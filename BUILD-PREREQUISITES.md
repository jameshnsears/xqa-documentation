# Build Prerequisites
This document lists the tools, and installation commands, used to build & test the containers for: Debian 9; CentOS 7; Ubuntu 18.04

## 1. installation commands
### 1.1. Docker CE; docker-compose; openjdk-8-jdk; git
#### 1.1.1. Debian 9
```
su -

apt update
apt upgrade -y

apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get -y install docker-ce openjdk-8-jdk git curl wget

curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# assuming your normal id is jsears :-)
usermod -aG docker jsears

systemctl start docker
systemctl enable docker

shutdown -r now
```

#### 1.1.2. CentOS 7
```
su -

yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum update
yum install -y docker-ce java-1.8.0-openjdk-devel git curl curl-devel expat-devel gettext-devel openssl-devel zlib-devel

curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

usermod -aG docker jsears

systemctl start docker
systemctl enable docker

shutdown -r now
```

#### 1.1.3. Ubuntu 18.04
```
sudo su -

apt update
apt install docker.io docker-compose openjdk-8-jdk git curl wget

usermod -aG docker jsears

systemctl start docker
systemctl enable docker

shutdown -r now
```

### 1.2. maven; NodeJS
```
# login as jsears

export XQA_BIN=$HOME/xqa/bin
mkdir -p $XQA_BIN
cd $XQA_BIN

curl http://mirror.ox.ac.uk/sites/rsync.apache.org/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz | tar xz

wget --no-check-certificate https://nodejs.org/dist/v8.11.2/node-v8.11.2-linux-x64.tar.xz && tar xf node-v8.11.2-linux-x64.tar.xz && rm node-v8.11.2-linux-x64.tar.xz

export PATH=$HOME/xqa/bin/apache-maven-3.5.3/bin:$HOME/xqa/bin/node-v8.11.2-linux-x64/bin:$PATH

echo "" >> $HOME/.bashrc
echo "export PATH=$HOME/xqa/bin/apache-maven-3.5.3/bin:$HOME/xqa/bin/node-v8.11.2-linux-x64/bin:$PATH" >> $HOME/.bashrc
```

### 1.3. Python 3.6
#### 1.3.1. CentOS 7
```
su - 

yum groupinstall -y development
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel expat-devel

exit  # from root

export XQA_BUILD=$HOME/xqa/build
mkdir -p $XQA_BUILD
cd $XQA_BUILD
# see below...
```

#### 1.3.2. Debian 9; Ubuntu 18.04
```
sudo su -

apt install libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev

exit  # from root

export XQA_BUILD=$HOME/xqa/build
mkdir -p $XQA_BUILD
cd $XQA_BUILD

export XQA_PY=3.6.5
wget --no-check-certificate https://www.python.org/ftp/python/$XQA_PY/Python-$XQA_PY.tar.xz && tar xf Python-$XQA_PY.tar.xz && rm Python-$XQA_PY.tar.xz

cd Python-$XQA_PY
./configure --prefix=$HOME/xqa/bin/Python-$XQA_PY
make -j4 install

export PATH=$HOME/xqa/bin/Python-$XQA_PY/bin:$PATH

pip3 install --upgrade pip
```

## 2. Building & Test the containers
```
export XQA_GIT_REPOS=$HOME/xqa/GIT_REPOS
mkdir -p $XQA_GIT_REPOS
cd $XQA_GIT_REPOS

git clone https://github.com/jameshnsears/xqa-perf
cd $XQA_GIT_REPOS/xqa-perf/bin
./build.sh  &> build.log &
tail -f build.log
```

### 2.1. Indicative Output (after build completed)
```
docker images

REPOSITORY                                      TAG                 IMAGE ID            CREATED             SIZE
xqa-shard                                       latest              5e28cbf696ec        3 minutes ago       1.09GB
xqa-message-broker                              latest              b0c387a43813        7 minutes ago       746MB
xqa-message-broker-filebeat                     latest              b637364526a8        11 minutes ago      277MB
xqa-ingest-balancer                             latest              ef5c056fdb73        11 minutes ago      560MB
xqa-ingest                                      latest              7c00f19a8f5d        11 minutes ago      560MB
xqa-db-amqp                                     latest              f2493ca2df69        12 minutes ago      727MB
xqa-db                                          latest              aa8362a9ab2a        16 minutes ago      287MB
xqa-query-balancer                              latest              dfb55f38fe4d        17 minutes ago      567MB
xqa-query-ui                                    latest              7893b8c2d582        21 minutes ago      17.3MB
xqa-elk-kibana                                  latest              e20eedd33bbf        25 minutes ago      636MB
xqa-elk-logstash                                latest              e75420ed1efe        26 minutes ago      597MB
xqa-elk-elasticsearch                           latest              000371a93eb9        28 minutes ago      720MB
debian                                          stretch             8626492fecd3        10 days ago         101MB
nginx                                           1.12.2-alpine       24ed1c575f81        3 months ago        15.5MB
postgres                                        10.1                ec61d13c8566        4 months ago        287MB
google/cadvisor                                 latest              75f88e3ec333        5 months ago        62.2MB
docker.elastic.co/beats/filebeat                5.6.2               f515807739ae        7 months ago        277MB
docker.elastic.co/kibana/kibana                 5.6.2               5b27c7e97a53        7 months ago        635MB
docker.elastic.co/logstash/logstash             5.6.2               0a28dae3fd86        7 months ago        597MB
docker.elastic.co/elasticsearch/elasticsearch   5.6.2               59b11c02b218        7 months ago        657MB
```

### 2.2. Indicative Output (after e2e.sh run)
```
export XQA_GIT_REPOS=$HOME/xqa/GIT_REPOS
cd $XQA_GIT_REPOS
git clone https://github.com/jameshnsears/xqa-test-data

cd $XQA_GIT_REPOS/xqa-perf/bin
SHARDS=1 XQA_TEST_DATA=$XQA_GIT_REPOS/xqa-test-data ./e2e.sh

# wait / docker logs <dev_xqa-ingest_1 | dev_xqa-shard_1>

docker logs dev_xqa-shard_1 | grep "size=40"
```

## 3. xqa-perf unit test
```
export DEVPATH=$HOME/xqa/GIT_REPOS
export PYTHONPATH=$DEVPATH/xqa-perf/src:$DEVPATH/xqa-perf/test:$PYTHONPATH
export PATH=$DEVPATH/xqa-perf/bin:$PATH
cd $DEVPATH/xqa-perf

pip3 install -r requirements.txt

XQA_TEST_DATA=$XQA_GIT_REPOS/xqa-test-data pytest -s
```
