#!/bin/bash

# Check if Jenkins is installed and running or stopped
if systemctl is-active --quiet jenkins || systemctl is-active --quiet jenkins.service; then
    echo "Jenkins is already installed and running or stopped. Exiting..."
    exit 0
fi

# Update package lists
sudo apt update

# Install OpenJDK 11
sudo apt install -y openjdk-17-jdk

# check the java version 
java -version

# Add Jenkins repository key to the system
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository to the system
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists again to include Jenkins repository
sudo apt-get update

# Install Jenkins
sudo apt-get install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins service to start on boot
sudo systemctl enable jenkins

# Wait for Jenkins to start (optional)
sleep 10

# Set a custom initial admin password
sudo echo "support1" > /var/lib/jenkins/secrets/initialAdminPassword

# Install Jenkins plugins (dependencies)
# sudo java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080/ install-plugin \
# pipeline \
# git \
# github \
# junit \
# warnings-ng \
# credentials \
# ssh-agent \
# email-ext \
# artifactory \
# docker-workflow \
# sonar \
# blueocean \
# nodejs \
# ec2 \
# kubernetes

# Restart Jenkins to apply changes
sudo systemctl restart jenkins

# Open port 8080 in firewall (if using UFW)
sudo ufw allow 8080

# Print Jenkins URL
echo "Jenkins is now installed and running. Access it at: http://localhost:8080"
