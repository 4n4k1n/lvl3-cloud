#!/bin/bash
set -e

# Source OpenStack credentials
source /opt/stack/devstack/openrc admin admin

# Initialize and apply terraform
cd /opt/stack/lvl3-cloud/infra/terraform/k8s
terraform init
terraform apply -auto-approve

cd /opt/stack/lvl3-cloud/infra/ansible && ansible-playbook -i inventory.ini site.yml
