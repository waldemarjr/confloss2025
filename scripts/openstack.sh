#!/bin/bash

# SSH Port
SSH_PORT=22

# Wait time
WAIT_TIME=5

# User Home
USER_HOME="/home/waldemar"

# OpenVPN script path
VPN_SCRIPT_PATH="$USER_HOME/confloss2025/client_vpn"

# Terraform files - IaC provisioning infrastructure.
TERRAFORM_PATH="$USER_HOME/confloss2025/git/confloss2025/terraform"

# Public and private keys - SSH auth - Openstack: controller e compute nodes
OS_SSH_KEYS_DIR="$USER_HOME/confloss2025/openstackSSHKeys"
OS_SSH_KEYS_FILE="$OS_SSH_KEYS_DIR/OS_SSH_KEY"

# Host (VPN Server and Openstack nodes) - Ansible inventory
OS_INVENTORY_DIR="$USER_HOME/confloss2025/git/confloss2025/terraform/inventory"
OS_INVENTORY_FILE="$OS_INVENTORY_DIR/os_nodes"

# Playbooks - deploy configuration - VPN Server
VPN_SRV_PB_DEPLOY="$USER_HOME/confloss2025/git/confloss2025/ansible/vpn_server/vpn_server.yml"


# Playbooks - deploy configuration - Openstack: controller e compute nodes
OS_CTRL_PB_DEPLOY="$USER_HOME/confloss2025/git/confloss2025/ansible/openstack/ctrl_nodes.yml"
OS_COMP_PB_DEPLOY="$USER_HOME/confloss2025/git/confloss2025/ansible/openstack/comp_nodes.yml"


clear

echo "+------------------------------------------+"
echo "| Starting Openstack infrastructure build  |"
echo "+------------------------------------------+"


echo "Provisioning Cloud Infrastructure..."

cd $TERRAFORM_PATH
terraform apply -auto-approve

sleep $WAIT_TIME

cd - 1>/dev/null 2>/dev/null


echo "+-------------------+"
echo "|   VPN Server      |"
echo "+-------------------+"

echo -n "Waiting SSH service on VPN Server"
VPN_SERVER_IP=`terraform -chdir=$TERRAFORM_PATH output -raw vpn_server_elastic_ip`

while [ true ]; do 
    nc -zw 3 $VPN_SERVER_IP $SSH_PORT
    if [ $? -eq 0 ]; then
        break;
    fi
    echo -n .
    sleep $WAIT_TIME
done
echo

ansible-playbook -i "$OS_INVENTORY_FILE" "$VPN_SRV_PB_DEPLOY" 




echo "Please connect to the VPN via another terminal using: $VPN_SCRIPT_PATH, and then press any key to continue."
read -s -p ""


sleep $WAIT_TIME


echo "Make public and private keys..."
rm -f $OS_SSH_KEYS_DIR/*
ssh-keygen -t rsa -b 4096 -N "" -f $OS_SSH_KEYS_FILE 1> /dev/null


echo "+-------------------+"
echo "|   Compute node    |"
echo "+-------------------+"


echo -n "Waiting SSH service on compute node"
OS_COMP_IP=`terraform -chdir=$TERRAFORM_PATH output -json os_comp_ip |jq -r '.[0]'`

while [ true ]; do 
    nc -zw 3 $OS_COMP_IP $SSH_PORT
    if [ $? -eq 0 ]; then
        break;
    fi
    echo -n .
    sleep $WAIT_TIME
done
echo

ansible-playbook -i "$OS_INVENTORY_FILE" "$OS_COMP_PB_DEPLOY" 


sleep $WAIT_TIME


echo "+------------------+"
echo "| Controller node |"
echo "+------------------+"


echo -n "Waiting SSH service on controller node"
OS_CTRL_IP=`terraform -chdir=$TERRAFORM_PATH output -json os_ctrl_ip |jq -r '.[0]'`

while [ true ]; do 
    nc -zw 3 $OS_CTRL_IP $SSH_PORT
    if [ $? -eq 0 ]; then
        break;
    fi
    echo -n .
    sleep $WAIT_TIME
done
echo

ansible-playbook -i "$OS_INVENTORY_FILE" "$OS_CTRL_PB_DEPLOY"
