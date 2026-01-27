#!/bin/bash

cd /opt/stack/lvl3-cloud/infra/terraform/k8s && terraform apply -auto-approve

cd /opt/stack/lvl3-cloud/infra/ansible && ansible-playbook -i inventory.ini site.yml
