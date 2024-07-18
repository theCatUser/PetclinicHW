FROM jenkins/jenkins:lts

USER root

# Ensure basic tools are installed
RUN apt-get update && apt-get install -y software-properties-common apt-transport-https wget

# Add the buster-backports repository for more recent versions of packages
RUN echo "deb http://deb.debian.org/debian buster-backports main" >> /etc/apt/sources.list

# Update and install OpenJDK 11 from buster-backports
RUN apt-get update && apt-get install -y -t buster-backports openjdk-11-jdk

# Install Maven
RUN apt-get install -y maven

USER jenkins
