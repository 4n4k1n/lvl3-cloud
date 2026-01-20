#!/bin/bash
current_dir=$(pwd)

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
sudo -u stack git clone https://opendev.org/openstack/devstack /opt/stack/devstack

# Copy local.conf template
sudo cp ${current_dir}/local.config.template /opt/stack/devstack/local.conf

# Change ownership to stack user
sudo chown stack:stack /opt/stack/devstack/local.conf

# Run stack.sh as stack user
sudo -u stack /opt/stack/devstack/stack.sh
