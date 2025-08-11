resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.project_name.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.tags,
    {
      Name = "${var.project_name}-public_route_table"
    }
  )

}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.project_name.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge(local.tags,
    {
      Name = "${var.project_name}-private_route_table"
    }
  )

}

