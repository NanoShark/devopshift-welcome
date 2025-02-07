variable "MYNAME" {
  type = string
  default = "michael"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
        Name = "${var.MYNAME}_vpc"
    }
}

# first availability zone
variable "AZ_1" {
  default = "us-east-1a"
}
# secound availability zone
variable "AZ_2" {
  default = "us-east-1b"
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.michael_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true 
  availability_zone = var.AZ_1
  tags = {
    Name ="public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.michael_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.AZ_2
  map_public_ip_on_launch = false 

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.michael_vpc.id
    tags = {
      Name = "${var.MYNAME}_IGW"
    }
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.michael_vpc.id
  # allows outbound internet access
  route = {
    cidr_block = "0.0.0.0/0"
    geteway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "${var.MYNAME}_public_route_table"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.michael_vpc.id
  tags = {
    Name = "${var.MYNAME}_private_route_table"
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_RT.id
}

