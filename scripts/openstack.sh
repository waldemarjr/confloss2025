#!/bin/bash
USER_HOME="/home/waldemar"

clear

echo "+--------------------------------+"
echo "| Starting infrastructure build  |"
echo "+--------------------------------+"


echo "+------------------+"
echo "| Controller nodes |"
echo "+------------------+"

rm -f $USER_HOME/confloss2025/openstackSSHKeys/*
ssh-keygen -t rsa -b 4096 -N "" -f $USER_HOME/confloss2025/openstackSSHKeys/ctrl_node 1> /dev/null

ansible-playbook -i ../inventory/os_nodes ../ansible/openstack/ctrl_nodes.yml

sleep 3
clear

echo "+-------------------+"
echo "|   Compute nodes   |"
echo "+-------------------+"

ansible-playbook -i ../inventory/os_nodes ../ansible/openstack/comp_nodes.yml 

