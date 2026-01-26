#!/bin/bash

IMAGE_DIR="/opt/stack/images"
IMAGE_FILE="$IMAGE_DIR/ubuntu-22.04.img"
IMAGE_URL="https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"

# Create directory
sudo mkdir -p "$IMAGE_DIR"

# Download if missing
if [ ! -f "$IMAGE_FILE" ]; then
    echo "Downloading image..."
    sudo wget -O "$IMAGE_FILE" "$IMAGE_URL"
fi

# Create in OpenStack
openstack image create "ubuntu-22.04" \
    --file "$IMAGE_FILE" \
    --disk-format qcow2 \
    --container-format bare \
    --public