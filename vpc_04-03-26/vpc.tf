provider "aws" {
  region = "ap-south-2"
}
resource "aws_vpc" "tf_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "tf_subnet" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "my-internet-gateway"
  }
}

resource "aws_default_route_table" "tf_default_route_table" {
  default_route_table_id = aws_vpc.tf_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_internet_gateway.id
  }
tags = {
  Name= "my-default-route-table"
}
}

resource "aws_route_table_association" "tf_route_table_association" {
  subnet_id      = aws_subnet.tf_subnet.id
  route_table_id = aws_vpc.tf_vpc.default_route_table_id
}