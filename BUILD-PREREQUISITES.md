# Build Prerequisites
This document lists the tools, and installation commands, used to build XQA for Ubuntu 18.04.

See each repo's CI files for testing instructions.

## 1. IDE's
* Eclipse Java EE IDE for Web Developers.
    * PyDev.
* IntelliJ IDEA.
* Pycharm.
* Visual Studio Code.

### 1.1. Useful IDE Extensions
* PMD
* SpotBugs
* CheckStyle
* Sonalint

## 2. Install Docker CE & Docker Compose
```
sudo su -

apt update

apt install -y docker.io docker-compose curl wget

usermod -aG docker jsears # devloper account

systemctl start docker

systemctl enable docker

shutdown -r now
```

## 3. Install toolchain
```
sudo su -

apt install -y git openjdk-11-jdk python3-dev python3-pip python3-distutils python3-tk maven nodejs npm postgresql-client ruby ruby-dev socat

gem install travis
```

## 4. Build Containers from source
```
cd # as developer account

git clone https://github.com/jameshnsears/xqa-perf

xqa-perf/bin/build-images.sh

xqa-perf/bin/tag-images.sh
```

## 5. socat - useful for observing docker.
```
sudo mv /var/run/docker.sock /var/run/hidden.socket

sudo socat -t100 -x -v UNIX-LISTEN:/var/run/docker.sock,mode=777,reuseaddr,fork UNIX-CONNECT:/var/run/hidden.socket

sudo mv /var/run/hidden.socket /var/run/docker.sock
```
