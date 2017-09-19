# XQA - XML Quality Assurance

## Summary
XQA is a toolset that allows you to use XQuery against "large" XML data sets.

A typical use case would be that you publish XML and that you want to use XQuery to insure that it meets downstream's requirements.

XQA is easy to set up and use, but the main reason for using it is that it's fast: ActiveMQ and Docker are used to shard BaseX instances - the benefit is that XQuery can take much less time to run than if you we're using a single BaseX instance.

### Advantages
* Easy to follow installation instructions.
* Simple UI to import, execute XQuery, export and manage the environment.
* Scalability: horizontal as well as vertical.
* Good test coverage.
* Open source, microservice architecture.

### Disadvantages
* Data is not replicated - if a shard becomes unavailable then so does its data.

## Technologies Used
- ActiveMQ
- AMQP - Apache Proton
- BaseX
- Docker
- Linux - Debian 9
- Python 3.5+