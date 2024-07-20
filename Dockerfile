FROM jenkins/jenkins:lts

USER root

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Add the Jenkins user to the Docker group
# Create the docker group and add the catUser95 user to the docker group
RUN groupadd docker && \
    usermod -aG docker catUser95

# Change Docker socket permissions
RUN chmod 666 /var/run/docker.sock

# Switch back to the Jenkins user
USER catUser95
