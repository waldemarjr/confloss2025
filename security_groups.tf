# Security Group VPN Server instance
resource "aws_security_group" "security_group_vpn_server" {

  name   = "${var.project_name}-secgroup_vpn_server"
  vpc_id = aws_vpc.project_name.id

  # SSH service
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # OpenVPN service
  ingress {
    from_port   = 63391
    to_port     = 63391
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags,
    {
      Name = "${var.project_name}-secgroup_vpn_server"
    }
  )

}