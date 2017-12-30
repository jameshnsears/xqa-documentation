# Common Instructions
## 1. sudo requirement
* $USER has sudo.

## 2. Apache Qpid Proton is installed
* [python-qpid-proton](https://pypi.python.org/pypi/python-qpid-proton) - including any of its [dependencies](https://github.com/apache/qpid-proton/blob/master/INSTALL.md) - see .travis.yml files.

## 3. Docker CE & Docker Compose are installed
* XQA's scalability comes from [Docker CE](https://docs.docker.com/engine/) & [Docker Compose](https://docs.docker.com/compose/)

## 4. Python 3.5+ 
### 4.1. A virtualenv is installed
For example, on Debian Stretch use:
* mkdir ~/bin
* virtualenv -p /usr/bin/python3.5 ~/bin/python3.5-ve01

A virtualenv is recommended as the python projects ship with a requirements.txt file.

### 4.2. CentOS 7
* I built python from source and installed it in ~/bin, and based the virtualenv off it.

## 5. JDK 8 is installed
* Use either [Oracle's](http://www.oracle.com/technetwork/java/javase/downloads/index.html) JDK or [OpenJDK](http://openjdk.java.net/install/).
* Maven will also need to be installed, if using it from the command line.
