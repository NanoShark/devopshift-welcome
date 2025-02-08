resource "aws_vpc" "michael_vpc" {
  cidr_block = "10.0.0.0/${var.cider_block_range}"
  tags = {
    Name = "michael-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count = var.subnet_count_public
  vpc_id = aws_vpc.michael_vpc.id
  cidr_block = cidrsubnet(aws_vpc.michael_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone = random_shuffle.az_shuffle.result[count.index]

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = var.subnet_count_private

  vpc_id = aws_vpc.michael_vpc.id
  cidr_block = cidrsubnet(aws_vpc.michael_vpc.cidr_block, 8, count.index + var.subnet_count_public)
  map_public_ip_on_launch = false
  availability_zone = random_shuffle.az_shuffle.result[count.index + var.subnet_count_public]

  tags = {
  Name = "private-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.michael_vpc.id
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.michael_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.michael_vpc.id
}

resource "aws_route_table_association" "public_association" {
  count = length(aws_subnet.public_subnet)
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "private_association" {
  count  = length(aws_subnet.private_subnet)
  subnet_id = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_RT.id
}

resource "random_shuffle" "az_shuffle" {
  input        = var.availability_zone
   result_count = var.subnet_count_public + var.subnet_count_private
}
