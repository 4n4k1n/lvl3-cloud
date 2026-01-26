#!/bin/bash

openstack flavor create k8s.control \
    --vcpus 2 \
    --ram 6144 \
    --disk 10 \
    --public

openstack flavor create k8s.worker \
    --vcpus 1 \
    --ram 4096 \
    --disk 10 \
    --public