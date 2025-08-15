resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project_name.id

  tags = merge(local.tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
}

