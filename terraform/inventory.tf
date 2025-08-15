data "template_file" "os_nodes_inventory" {
  template = file("./templates/os_nodes_inventory.tpl")
  vars = {
    vpn_server_ip       = "${join("\n", aws_instance.vpn_server.*.public_ip)}"
    vpn_server_name     = "${join("\n", aws_instance.vpn_server.*.tags.Name)}"
    vpn_server_ssh_user = var.vpn_server_ssh_user

    os_controller_node_ip   = "${join("\n", aws_instance.os_ctrl_node_server.*.private_ip)}"
    os_controller_node_name = "${join("\n", aws_instance.os_ctrl_node_server.*.tags.Name)}"

    os_compute_node_ip   = "${join("\n", aws_instance.os_comp_node_server.*.private_ip)}"
    os_compute_node_name = "${join("\n", aws_instance.os_comp_node_server.*.tags.Name)}"

    os_node_ssh_user = var.os_node_ssh_user

    key_path = "${join("\n", local_file.private_key_file.*.filename)}"

  }
}

resource "local_file" "os_nodes_invent_file" {
  content  = data.template_file.os_nodes_inventory.rendered
  filename = "./inventory/os_nodes"
}
