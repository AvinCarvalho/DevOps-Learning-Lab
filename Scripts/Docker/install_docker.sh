#!/bin/bash

echo "Updating system...."
sudo yum update -y

echo "Set Docker's package repository"
sudo yum config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

echo "Installing Docker"
sudo yum install docker -y

echo "Start Docker"
sudo systemctl start docker 

echo "Enable Docker"
sudo systemctl enable docker


echo "Docker installation completed !" 