FROM openjdk:10-slim AS collector

MAINTAINER Josh Ghiloni <jghiloni@pivotal.io>

WORKDIR /root

COPY starter.zip .

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install unzip
RUN unzip starter.zip -d project

WORKDIR /root/project

RUN ./mvnw dependency:resolve

FROM openjdk:10-slim AS resource

COPY --from=collector /root/.m2/ /root/.m2/

FROM resource
