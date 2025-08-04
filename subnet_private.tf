resource "aws_subnet" "confloss_openstack-private_network" {
  vpc_id            = aws_vpc.confloss_openstack-vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, 2)
  availability_zone = "${data.aws_region.current.region}a"

  map_public_ip_on_launch = var.map_public_ip_priv_network

  tags = merge(local.tags,
    {
      Name = "${var.project_name}-private_network"
    }
  )
}