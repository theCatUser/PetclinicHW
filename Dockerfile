FROM jenkins/jenkins:lts
USER root
# Install OpenJDK 8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk
# Install Maven
RUN apt-get install -y maven
USER jenkins
