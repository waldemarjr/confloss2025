resource "aws_vpc" "confloss_openstack-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = merge(local.tags,
    {
      Name = "${var.project_name}-vpc"
    }
  )
}

