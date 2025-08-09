data  "template_file" "os_nodes_inventory" {
    template = "${file("./templates/os_nodes_inventory.tpl")}"
    vars = {
        os_controller_node = "${join("\n", aws_instance.os_ctrl_node_server.*.public_ip)}"
        os_compute_node = "${join("\n", aws_instance.os_comp_node_server.*.public_ip)}"
    }
}

resource "local_file" "os_nodes_invent_file" {
  content  = "${data.template_file.os_nodes_inventory.rendered}"
  filename = "./inventory/os_nodes"
}
