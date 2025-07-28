
###############################
#           VPC              #
###############################
resource "aws_vpc" "AppVPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "AppVPC"
  }
}

resource "aws_internet_gateway" "AppInternetGateway" {
  vpc_id = aws_vpc.AppVPC.id
  tags = {
    Name = "AppInternetGateway"
  }
}

###############################
#         SUBNETS            #
###############################
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.AppVPC.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "ALBPublicSubnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.AppVPC.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "ALBPublicSubnet_2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.AppVPC.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "AppPrivateSubnet"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.AppVPC.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "AppPrivateSubnet_2"
  }
}

###############################
#     NAT & EIP for NAT      #
###############################
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "NAT EIP"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT Gateway"
  }
}

###############################
#      SECURITY GROUPS       #
###############################
resource "aws_security_group" "WebTrafficSG" {
  name        = "web-traffic-sg"
  description = "Allow app traffic on port 4000"
  vpc_id      = aws_vpc.AppVPC.id

  ingress {
  from_port   = 4000
  to_port     = 4000
  protocol    = "tcp"
  security_groups = [aws_security_group.alb_sg.id] # Allow from ALB
  }
   ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "WebTrafficSG"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow inbound access on port 4000"
  vpc_id      = aws_vpc.AppVPC.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}