resource "aws_vpc" "project_name" {
  cidr_block = var.vpc_cidr_block
  tags = merge(local.tags,
    {
      Name = "${var.project_name}-vpc"
    }
  )
}

