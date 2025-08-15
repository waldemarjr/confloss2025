resource "aws_eip" "natgw_elastic_ip" {

  tags = merge(local.tags,
    {
      Name = "${var.project_name}-vpn_server_elastic_ip"
    }
  )
}

output "natgw_elastic_ip" {
  value = aws_eip.natgw_elastic_ip.public_ip
}


resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.natgw_elastic_ip.id
  subnet_id     = aws_subnet.public_network.id
  tags = merge(local.tags,
    {
      Name = "${var.project_name}-natgw"
    }
  )

}
