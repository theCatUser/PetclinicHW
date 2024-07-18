FROM jenkins/jenkins:lts
USER root
# Install OpenJDK 8
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
# Install Maven
RUN apt-get install -y maven
USER jenkins

