FROM jenkins/jenkins:lts

USER root

# Install Maven
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean

# Set Maven environment variables
ENV MAVEN_HOME=/usr/share/maven
ENV MAVEN_CONFIG="/var/maven/.m2"

USER jenkins
