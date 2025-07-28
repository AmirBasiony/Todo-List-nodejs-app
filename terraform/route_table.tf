
###############################
#        ROUTE TABLES        #
###############################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.AppVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.AppInternetGateway.id
  }

  tags = {
    Name = "AppRouteTable"
  }
}


# Associating the public subnet with the public route table 
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Associating the private subnet with the private route table
resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# This route table will route traffic through the NAT gateway for the private subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.AppVPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}
