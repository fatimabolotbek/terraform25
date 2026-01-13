/// VPC ////
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = var.tags
}


/// Public subnet ////
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  tags              = var.tags
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2b"
  tags              = var.tags
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2c"
  tags              = var.tags
}

/// Privat subnet ////

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2a"
  tags              = var.tags
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-2b"
  tags              = var.tags
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-2c"
  tags              = var.tags
}

//// IGW /////

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = var.tags
}

//// EIP ////

resource "aws_eip" "elastic_ip" {
  domain = "vpc"
  tags = var.tags
}

/// NGW /////

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = var.tags
  depends_on = [ aws_internet_gateway.main ]
}

/// RT ///

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  tags = var.tags
    
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  tags = var.tags
    
}

//// Public rt assosiation /////

resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

//// Private route NAT GW  ////
resource "aws_route" "ngw_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

//// Public route table associations ////
resource "aws_route_table_association" "public_rt_association1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_rt_association2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_rt_association3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public_route_table.id
}

//// Private route table associations ////
resource "aws_route_table_association" "private_association1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_association2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_association3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_route_table.id
}