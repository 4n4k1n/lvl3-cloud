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
sudo -i -u stack git clone https://github.com/4n4k1n/lvl3-cloud.git /opt/stack/lvl3-cloud

# Clone devstack repository
echo "Cloning devstack repository..."
sudo -i -u stack git clone https://opendev.org/openstack/devstack /opt/stack/devstack

# Detect host IP (first IP from hostname -I)
echo "Detecting host IP address..."
HOST_IP=$(hostname -I | awk '{print $1}')
echo "Using HOST_IP: $HOST_IP"

# Copy local.conf template and replace HOST_IP
echo "Copying and configuring local.conf template..."
sudo -i -u stack cp /opt/stack/lvl3-cloud/local.conf.template /opt/stack/devstack/local.conf
sudo sed -i "s/^HOST_IP=.*/HOST_IP=$HOST_IP/" /opt/stack/devstack/local.conf

# Run stack.sh as stack user (with proper HOME environment)
echo "Running stack.sh (this will take 15-30 minutes)..."
sudo -i -u stack bash -c "cd /opt/stack/devstack && ./stack.sh"

echo ""
echo ""
echo "================================"

# TODO: Run unit tests (script not yet implemented)
# echo "Running unit tests..."
# cd /opt/stack/devstack && sudo -i -u stack ./run_tests.sh

# setup cluster
echo "Setup the k8s cluster..."
chmod +x /opt/stack/lvl3-cloud/scripts/*
/opt/stack/lvl3-cloud/scripts/cluster.sh

echo ""
echo ""
echo "================================"
echo "Setup complete!"
echo "================================"
