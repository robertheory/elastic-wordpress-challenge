# Description: This file contains the code to create a VPC, public and private subnets, internet gateway, route tables, NAT gateway, and Elastic IP.

# Create a VPC
resource "aws_vpc" "wp-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "wp-tf"
  }
}

# Public Resources

# Create a public subnet
resource "aws_subnet" "wp-public-subnet" {
  vpc_id            = aws_vpc.wp-vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.availability_zones[0] # Use the first AZ for the public subnet

  tags = {
    Name = "wp-public-subnet"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "wp-igw" {
  vpc_id = aws_vpc.wp-vpc.id

  tags = {
    Name = "wp-igw"
  }
}

# Create a public route table
resource "aws_route_table" "wp-public-route-table" {
  vpc_id = aws_vpc.wp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wp-igw.id
  }

  tags = {
    Name = "wp-public-route-table"
  }
}

# Associate the public route table with the public subnet
resource "aws_route_table_association" "wp-public-route-table-association" {
  subnet_id      = aws_subnet.wp-public-subnet.id
  route_table_id = aws_route_table.wp-public-route-table.id
}

# Create a NAT gateway Elastic IP
resource "aws_eip" "wp-nat-eip" {
  vpc = true

  tags = {
    Name = "wp-nat-eip"
  }
}

# Create a NAT gateway in the public subnet
resource "aws_nat_gateway" "wp-nat-gateway" {
  allocation_id = aws_eip.wp-nat-eip.id
  subnet_id     = aws_subnet.wp-public-subnet.id

  tags = {
    Name = "wp-nat-gateway"
  }
}

# Private Resources

# Create private subnets in multiple AZs

# Private subnet in the first AZ
resource "aws_subnet" "wp-private-subnet-az1" {
  vpc_id            = aws_vpc.wp-vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[0]
  availability_zone = var.availability_zones[0] # First AZ

  tags = {
    Name = "wp-private-subnet-az1"
  }
}

# Private subnet in the second AZ
resource "aws_subnet" "wp-private-subnet-az2" {
  vpc_id            = aws_vpc.wp-vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[1]
  availability_zone = var.availability_zones[1] # Second AZ

  tags = {
    Name = "wp-private-subnet-az2"
  }
}

# Create a private route table
resource "aws_route_table" "wp-private-route-table" {
  vpc_id = aws_vpc.wp-vpc.id

  tags = {
    Name = "wp-private-route-table"
  }
}

# Add a route for the private route table to the NAT Gateway
resource "aws_route" "wp-private-route" {
  route_table_id         = aws_route_table.wp-private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.wp-nat-gateway.id
}

# Associate the private route table with the private subnet in AZ1
resource "aws_route_table_association" "wp-private-route-table-association-az1" {
  subnet_id      = aws_subnet.wp-private-subnet-az1.id
  route_table_id = aws_route_table.wp-private-route-table.id
}

# Associate the private route table with the private subnet in AZ2
resource "aws_route_table_association" "wp-private-route-table-association-az2" {
  subnet_id      = aws_subnet.wp-private-subnet-az2.id
  route_table_id = aws_route_table.wp-private-route-table.id
}
