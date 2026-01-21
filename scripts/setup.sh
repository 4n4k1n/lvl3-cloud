#!/bin/bash

# Create stack user
sudo useradd -s /bin/bash -d /opt/stack -m stack
if [ $? -ne 0 ]; then
    echo "Failed to create stack user"
    exit 1
fi

# Set permissions on /opt/stack
sudo chmod +x /opt/stack
if [ $? -ne 0 ]; then
    echo "Failed to add executable permissions"
    exit 1
fi

# Add stack user to sudoers
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack

# Clone devstack as stack user
sudo -u stack git https://github.com/4n4k1n/lvl3-cloud.git /opt/stack
sudo -u stack git clone https://opendev.org/openstack/devstack /opt/stack/devstack

# Copy local.conf template
sudo cp /opt/stack/local.config.template /opt/stack/devstack/local.conf

# Change ownership to stack user
sudo chown stack:stack /opt/stack/devstack/local.conf

# Run stack.sh as stack user
sudo -u stack /opt/stack/devstack/stack.sh

# run unit tests
sudo -u stack /opt/stack/devstack.run_tests.sh

