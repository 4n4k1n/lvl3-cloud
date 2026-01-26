#!/bin/bash

openstack flavor create k8s.custom \
    --vcpus 2 \
    --ram 4096 \
    --disk 20 \
    --ephemeral 0 \
    --public