#!/bin/bash

echo "Updating System"
sudo yum update -y

echo "Install Docker "
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

echo "Enable Kernel Modules"
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

echo "===== Disable Swap ====="
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "===== Install Kubernetes ====="
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
EOF

sudo yum install -y kubelet kubeadm kubectl
sudo systemctl enable kubelet
sudo systemctl start kubelet

echo "===== Initialize Kubernetes Cluster ====="
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

echo "===== Setup kubeconfig ====="
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "===== Install Calico Network ====="
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo "===== Allow scheduling on master (for testing) ====="
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

echo "===== DONE ====="