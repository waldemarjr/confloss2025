[vpn_server]
${vpn_server_name} ansible_host=${vpn_server_ip} ansible_user=${vpn_server_ssh_user}

[ctrlnodes]
${os_controller_node_name} ansible_host=${os_controller_node_ip} ansible_user=${os_node_ssh_user}

[compnodes]
${os_compute_node_name} ansible_host=${os_compute_node_ip} ansible_user=${os_node_ssh_user}

[all:vars]
ansible_ssh_private_key_file=${key_path}
ansible_ssh_common_args='-o StrictHostKeyChecking=no'