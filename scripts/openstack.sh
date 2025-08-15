#!/bin/bash

# User Home
USER_HOME="/home/waldemar"

# Terraform files - IaC provisioning infrastructure.
TERRAFORM_PATH="$USER_HOME/confloss2025/git/confloss2025/terraform"

# Public and private keys - SSH auth - Openstack: controller e compute nodes
OS_SSH_KEYS_DIR="$USER_HOME/confloss2025/openstackSSHKeys"
OS_SSH_KEYS_FILE="$OS_SSH_KEYS_DIR/OS_pubprivKeys"

# Host (openstack nodes) - Ansible inventory
OS_INVENTORY_DIR="$USER_HOME/confloss2025/git/confloss2025/inventory"
OS_INVENTORY_FILE="$OS_INVENTORY_DIR/os_nodes"

# Playbooks - deploy configuration - Openstack: controller e compute nodes
OS_CTRL_PB_DEPLOY="$USER_HOME/confloss2025/ansible/openstack/ctrl_nodes.yml"
OS_COMP_PB_DEPLOY="$USER_HOME/confloss2025/ansible/openstack/comp_nodes.yml"


clear

echo "+--------------------------------+"
echo "| Starting infrastructure build  |"
echo "+--------------------------------+"


echo "Provisioning Cloud Infrastructure..."
terraform  -chdir=$TERRAFORM_DIR apply -auto-approve


echo "+------------------+"
echo "| Controller nodes |"
echo "+------------------+"

rm -f $OS_SSH_KEYS_DIR/*
ssh-keygen -t rsa -b 4096 -N "" -f $OS_SSH_KEYS_FILE 1> /dev/null

ansible-playbook -i $OS_INVENTORY_FILE $OS_CTRL_PB_DEPLOY

sleep 3
clear

echo "+-------------------+"
echo "|   Compute nodes   |"
echo "+-------------------+"

ansible-playbook -i $OS_INVENTORY_FILE $OS_COMP_PB_DEPLOY 
