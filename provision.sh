#!/bin/bash

# Install required packages
sudo yum install -y epel-release
sudo yum install -y wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct

# Disable SELinux
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Install Docker
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker

# Install OpenShift CLI
sudo wget https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz
sudo tar -xvf oc.tar.gz
sudo mv oc /usr/local/bin/