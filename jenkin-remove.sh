#!/bin/bash

# Check if Jenkins is installed and running or stopped
if systemctl is-active --quiet jenkins || systemctl is-active --quiet jenkins.service; then
    echo "Jenkins is installed. Removing..."
else
    echo "Jenkins is not installed. Exiting..."
    exit 0
fi

# Stop Jenkins service
sudo systemctl stop jenkins

# Uninstall Jenkins
sudo apt purge -y jenkins

# Remove Jenkins configuration files
sudo rm -rf /var/lib/jenkins
sudo rm -rf /etc/default/jenkins
sudo rm -rf /etc/init.d/jenkins

# Print message
echo "Jenkins has been successfully removed from the system."
