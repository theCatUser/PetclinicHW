FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y sudo
RUN echo 'root:Password1!' | chpasswd

USER jenkins
