#!/bin/bash
set -e

# Config (must match creation script)
NET="demo-net"
SUBNET="demo-subnet"
ROUTER="demo-router"
VM="demo-vm"
SG="demo-sg"

# Delete VM
openstack server delete $VM --wait 2>/dev/null || true

# Delete floating IPs
for fip in $(openstack floating ip list -f value -c ID); do
    openstack floating ip delete $fip 2>/dev/null || true
done

# Remove subnet from router & delete router
openstack router remove subnet $ROUTER $SUBNET 2>/dev/null || true
openstack router delete $ROUTER 2>/dev/null || true

# Delete subnet & network
openstack subnet delete $SUBNET 2>/dev/null || true
openstack network delete $NET 2>/dev/null || true

# Delete security group
openstack security group delete $SG 2>/dev/null || true

# Delete keypair
openstack keypair delete demo-key 2>/dev/null || true
rm -f demo-key.pem

echo "Cleanup complete!"
