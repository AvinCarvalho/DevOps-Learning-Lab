#!/bin/bash

echo "Updating packages..."
sudo yum update -y

echo "Installing Java..."
sudo yum install java-17-amazon-corretto -y

echo "Adding Jenkins repo..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

echo "Importing Jenkins key..."
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "Installing Jenkins..."
sudo yum install jenkins -y

echo "Starting Jenkins..."
sudo systemctl start jenkins

echo "Enabling Jenkins on boot..."
sudo systemctl enable jenkins

echo "Jenkins installation completed!"