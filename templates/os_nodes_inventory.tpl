[vpn_server]
${vpn_server_name} ansible_host=${vpn_server_ip}

[ctrlnodes]
${os_controller_node_name} ansible_host=${os_controller_node_ip}

[compnodes]
${os_compute_node_name} ansible_host=${os_compute_node_ip} 

[all:vars]
ansible_user=admin
ansible_ssh_private_key_file=${key_path}
ansible_ssh_common_args='-o StrictHostKeyChecking=no'