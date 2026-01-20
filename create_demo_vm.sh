#!/bin/bash
set -e

NET="demo-net"
SUBNET="demo-subnet"
ROUTER="demo-router"
EXTERNAL="public"
VM="demo-vm"

openstack network create $NET
openstack subnet create $SUBNET --network $NET --subnet-range 10.0.0.0/24 --dns-nameserver 8.8.8.8

openstack router create $ROUTER
openstack router set --external-gateway $EXTERNAL $ROUTER
openstack router add subnet $ROUTER $SUBNET

SG="demo-sg"
openstack security group create $SG
openstack security group rule create $SG --protocol tcp --dst-port 22
openstack security group rule create $SG --protocol icmp

# Create keypair from your existing SSH key
KEYFILE="$HOME/.ssh/id_rsa.pub"
if [ -f "$KEYFILE" ]; then
    openstack keypair create demo-key --public-key "$KEYFILE"
else
    echo "No SSH key found at $KEYFILE"
    exit 1
fi

openstack server create $VM \
  --flavor m1.small \
  --image cirros-0.6.3-x86_64-disk \
  --network $NET \
  --security-group $SG \
  --key-name demo-key

sleep 10
FIP=$(openstack floating ip create $EXTERNAL -f value -c floating_ip_address)
openstack server add floating ip $VM $FIP

echo "VM ready at: $FIP"
echo "ssh cirros@$FIP"
