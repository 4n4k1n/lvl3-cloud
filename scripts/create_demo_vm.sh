#!/bin/bash
set -e

# Configuration
NET="demo-net"
SUBNET="demo-subnet"
ROUTER="demo-router"
EXTERNAL="public"
VM="demo-vm"
SG="demo-sg"
KEYFILE="$HOME/.ssh/id_rsa.pub"

# Generate SSH key if it doesn't exist
if [ ! -f "$KEYFILE" ]; then
    echo "SSH key not found. Generating new keypair..."
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
    echo "SSH key generated at $KEYFILE"
fi

# Network setup
echo "Creating network infrastructure..."
openstack network create $NET
openstack subnet create $SUBNET \
  --network $NET \
  --subnet-range 10.0.0.0/24 \
  --dns-nameserver 8.8.8.8

openstack router create $ROUTER
openstack router set --external-gateway $EXTERNAL $ROUTER
openstack router add subnet $ROUTER $SUBNET

# Security group
echo "Setting up security group..."
openstack security group create $SG
openstack security group rule create $SG --protocol tcp --dst-port 22
openstack security group rule create $SG --protocol icmp

# Keypair
echo "Creating OpenStack keypair..."
# Delete existing keypair if it exists
openstack keypair delete demo-key 2>/dev/null || true
openstack keypair create demo-key --public-key "$KEYFILE"

# VM creation
echo "Launching VM..."
openstack server create $VM \
  --flavor m1.small \
  --image cirros-0.6.3-x86_64-disk \
  --network $NET \
  --security-group $SG \
  --key-name demo-key

# Wait for VM to be active
echo "Waiting for VM to become active..."
while [ "$(openstack server show $VM -f value -c status)" != "ACTIVE" ]; do
    sleep 2
done

# Assign floating IP
echo "Assigning floating IP..."
FIP=$(openstack floating ip create $EXTERNAL -f value -c floating_ip_address)
openstack server add floating ip $VM $FIP

echo ""
echo "✓ VM ready at: $FIP"
echo "→ Connect: ssh cirros@$FIP"
echo "  (default password: gocubsgo)"
