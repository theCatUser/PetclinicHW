FROM jenkins/jenkins:lts
USER root
# Ensure basic tools are installed
RUN apt-get update && apt-get install -y software-properties-common apt-transport-https wget
# Add the necessary repository for OpenJDK 11
RUN echo "deb http://deb.debian.org/debian buster main" >> /etc/apt/sources.list
# Update and install OpenJDK 11
RUN apt-get update && apt-get install -y openjdk-11-jdk
# Install Maven
RUN apt-get install -y maven
USER jenkins
