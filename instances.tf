// VPN Server Instance

resource "aws_instance" "vpn_server" {

  ami           = var.vpn_server_ami
  instance_type = var.vpn_server_type
  //subnet_id              = aws_subnet.public_network.id
  ////vpc_security_group_ids = [aws_security_group.security_group_vpn_server.id]
  key_name      = aws_key_pair.generated_pubkey.key_name

  root_block_device {
    volume_type = var.vpn_server_vol_type
    volume_size = var.vpn_server_vol_size
  }

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.vpn_server_pubnet_interf.id
  }

  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.vpn_server_privnet_interf.id
  }


  tags = merge(local.tags,
    {
      Name = "${var.project_name}-vpn_server"
    }
  )

}

resource "aws_network_interface" "vpn_server_privnet_interf" {
  subnet_id       = aws_subnet.private_network.id
  private_ips     = [cidrhost(aws_subnet.private_network.cidr_block, 254)]
  security_groups = [aws_security_group.security_group_vpn_server.id]

  tags = merge(local.tags,
    {
      Name = "${var.project_name}-vpn_server_privnet_interf"
    }
  )
}

resource "aws_network_interface" "vpn_server_pubnet_interf" {
  subnet_id       = aws_subnet.public_network.id
  private_ips     = [cidrhost(aws_subnet.public_network.cidr_block, 254)]
  security_groups = [aws_security_group.security_group_vpn_server.id]

  tags = merge(local.tags,
    {
      Name = "${var.project_name}-vpn_server_pubnet_interf"
    }
  )
}

resource "aws_eip" "vpn_server_elastic_ip" {
  network_interface = aws_network_interface.vpn_server_pubnet_interf.id
  ////  associate_with_private_ip = cidrhost(aws_subnet.public_network.cidr_block, 254)
  tags = merge(local.tags,
    {
      Name = "${var.project_name}-vpn_server_elastic_ip"
    }
  )
}
