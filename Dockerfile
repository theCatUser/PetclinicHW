FROM jenkins/jenkins:lts
USER root
# Install OpenJDK 8
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository 'deb http://deb.debian.org/debian buster main' && \
    apt-get update && \
    apt-get install -y openjdk-11-jdk
# Install Maven
RUN apt-get install -y maven
USER jenkins
