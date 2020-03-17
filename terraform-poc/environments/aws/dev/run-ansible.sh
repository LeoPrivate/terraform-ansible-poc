#!/bin/bash

## OLD WAY
#TF_STATE=./ ansible-playbook --inventory-file=/usr/bin/terraform-inventory ../../../ansible/deploy-web-3-tier.yml --private-key=~/.ssh/frontkey

## NEW WAY

ansible-playbook ../../../../ansible/deploy-web-3-tier.yml --private-key=~/.ssh/frontkey -i /etc/ansible/ec2.py 
