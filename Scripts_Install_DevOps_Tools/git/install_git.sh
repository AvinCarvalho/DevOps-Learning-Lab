#!/bin/bash

echo "Updating system..."
sudo yum update -y

echo "Installing Git..."
sudo yum install git -y

echo "Checking Git version..."
git --version

echo "Git Installation Completed!"