#!/bin/bash
# OpenStack DevStack Setup Script

set -e  # Exit on any error

# Create stack user with home directory
echo "Creating stack user..."
sudo useradd -s /bin/bash -d /opt/stack -m stack

# Set permissions on /opt/stack
echo "Setting permissions on /opt/stack..."
sudo chmod +x /opt/stack

# Add stack user to sudoers
echo "Adding stack user to sudoers..."
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack

# Clone lvl3-cloud repository
echo "Cloning lvl3-cloud repository..."
sudo -u stack git clone https://github.com/4n4k1n/lvl3-cloud.git /opt/stack/lvl3-cloud

# Clone devstack repository
echo "Cloning devstack repository..."
sudo -u stack git clone https://opendev.org/openstack/devstack /opt/stack/devstack

# Copy local.conf template
echo "Copying local.conf template..."
sudo -u stack cp /opt/stack/lvl3-cloud/local.config.template /opt/stack/devstack/local.conf

# Run stack.sh as stack user
echo "Running stack.sh (this will take 15-30 minutes)..."
sudo -u stack /opt/stack/devstack/stack.sh

echo ""
echo ""
echo "================================"

# Run unit tests
echo "Running unit tests..."
sudo -u stack /opt/stack/lvl3-cloud/run_tests.sh

echo ""
echo ""
echo "================================"
echo "✓ Setup complete!"
echo "================================"
