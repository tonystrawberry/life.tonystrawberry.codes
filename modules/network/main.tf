# Create a VPC for the project
resource "aws_vpc" "aws_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.project}-vpc"
  }
}

# Create a public subnet for the project
resource "aws_subnet" "aws_subnet" {
  vpc_id     = aws_vpc.aws_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${var.project}-subnet"
  }
}


# Create an internet gateway for the project
resource "aws_internet_gateway" "aws_internet_gateway" {
  vpc_id = aws_vpc.aws_vpc.id
}

# Create a route table for the project
resource "aws_route_table" "aws_route_table" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_internet_gateway.id
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "aws_route_table_association" {
  subnet_id      = aws_subnet.aws_subnet.id
  route_table_id = aws_route_table.aws_route_table.id
}

# Create a security group for the project
resource "aws_security_group" "aws_security_group" {
  name        = "${var.project}-security-group"
  description = "Allow inbound & outbound traffic"

  vpc_id = aws_vpc.aws_vpc.id

  ingress {
    description = "Allow inbound traffic from all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic to all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
