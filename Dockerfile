FROM jenkins/jenkins:lts
USER root
# Install OpenJDK 8
RUN apt-get update
RUN apt-get install -y openjdk-11-jdk
# Install Maven
RUN apt-get install -y maven
USER jenkins

