#!/bin/bash

echo "Updating system..."
sudo dnf update -y

echo "Installing Git..."
sudo dnf install git -y
git --version

echo "Installing Docker..."
sudo dnf install docker -y

echo "Starting Docker..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Adding ec2-user to docker group..."
sudo usermod -aG docker ec2-user

echo "Installing Java..."
sudo dnf install java-17-amazon-corretto -y

echo "Adding Jenkins repo..."
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

echo "Importing Jenkins key..."
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

echo "Installing Jenkins..."
sudo dnf install jenkins -y

echo "Starting Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Setup completed!"