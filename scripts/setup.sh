#!/bin/bash
# OpenStack DevStack Setup Script

set -e  # Exit on any error

# Create stack user with home directory
echo "Creating stack user..."
sudo useradd -s /bin/bash -d /opt/stack -m stack 2>/dev/null || true

# Set permissions on /opt/stack
echo "Setting permissions on /opt/stack..."
sudo chmod +x /opt/stack

# Add stack user to sudoers
echo "Adding stack user to sudoers..."
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack

# Clone lvl3-cloud repository
echo "Cloning lvl3-cloud repository..."
sudo -i -u stack git clone https://github.com/4n4k1n/lvl3-cloud.git /opt/stack/lvl3-cloud < /dev/null

# Clone devstack repository
echo "Cloning devstack repository..."
sudo -i -u stack git clone https://opendev.org/openstack/devstack /opt/stack/devstack < /dev/null

# Detect host IP (first IP from hostname -I)
echo "Detecting host IP address..."
HOST_IP=$(hostname -I | awk '{print $1}')
echo "Using HOST_IP: $HOST_IP"

# Copy local.conf template and replace HOST_IP
echo "Copying and configuring local.conf template..."
sudo -i -u stack cp /opt/stack/lvl3-cloud/local.conf.template /opt/stack/devstack/local.conf < /dev/null
sudo sed -i "s/^HOST_IP=.*/HOST_IP=$HOST_IP/" /opt/stack/devstack/local.conf

# Run stack.sh as stack user (with proper HOME environment)
echo "Running stack.sh (this will take 15-30 minutes)..."
sudo -i -u stack bash -c "cd /opt/stack/devstack && ./stack.sh" < /dev/null

echo ""
echo ""
echo "================================"

# TODO: Run unit tests (script not yet implemented)
# echo "Running unit tests..."
# cd /opt/stack/devstack && sudo -i -u stack ./run_tests.sh

# Install Terraform
echo "Installing Terraform..."
sudo apt-get update
sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update
sudo apt-get install -y terraform

# Install Ansible
echo "Installing Ansible..."
sudo apt-get install -y ansible

# setup cluster
echo "Setup the k8s cluster..."
chmod +x /opt/stack/lvl3-cloud/scripts/*
sudo -i -u stack /opt/stack/lvl3-cloud/scripts/cluster.sh < /dev/null

echo ""
echo ""
echo "================================"
echo "Setup complete!"
echo "================================"
