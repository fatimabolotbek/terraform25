/// VPC ///
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  tags = merge(
    var.tags,
    { "Name" = "vpc_homework" }
  )
}

//// Public subnet /////
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]

  tags = merge(
    var.tags,
    { "Name" = "public_subnet_${count.index + 1}" }
  )
}

///// Privat subnet //////

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    var.tags,
    { "Name" = "private_subnet_${count.index + 1}" }
  )
}

////Internet gateway ////
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    { "Name" = "Internet gateway" }
  )
}

//// Public route tables //////

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

///// public rout table  associations /////
resource "aws_route_table_association" "public_assoc" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

///// Eip ///////
resource "aws_eip" "nat" {
  domain = "vpc"
  
}

//// nat gateway ///////

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.tags,
    { "Name" = "Nat gateway" }
  )
  
}

///// privat route table ////

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id


  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  
}
/////// privat route association  //////
resource "aws_route_table_association" "private_assoc" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}