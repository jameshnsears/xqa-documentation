# Common Instructions
## 1. sudo on Linux
* $USER has sudo.

## 2. Apache Qpid Proton is installed
* [python-qpid-proton](https://pypi.python.org/pypi/python-qpid-proton) - including any of its [dependencies](https://github.com/apache/qpid-proton/blob/master/INSTALL.md)

## 3. Docker CE & Docker Compose are installed
* [Docker CE](https://docs.docker.com/engine/) & [Docker Compose](https://docs.docker.com/compose/)

## 4. A Python 3.5+ virtualenv is installed
For example, on Debian use:
* mkdir ~/bin
* virtualenv -p /usr/bin/python3.5 ~/bin/python3.5-ve01

A virtualenv is required as the python projects ship with a requirements.txt file.

## 5. JDK 8 is installed
* Use either [Oracle's](http://www.oracle.com/technetwork/java/javase/downloads/index.html) JDK or [OpenJDK](http://openjdk.java.net/install/).
* Maven will also need to be installed, if using it from the command line.
