resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-main"
  }
}

resource "aws_subnet" "public-a" {
  vpc_id = aws_vpc.main.id
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-a"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id = aws_vpc.main.id
  availability_zone = "ap-northeast-1c"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-c"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id = aws_vpc.main.id
  availability_zone =  "ap-northeast-1a"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private-a"
  }
}

resource "aws_subnet" "private-c" {
  vpc_id = aws_vpc.main.id
  availability_zone = "ap-northeast-1c"
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private-c"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw_terraform"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private"
  }
}

resource "aws_route_table_association" "public-a" {
  subnet_id = aws_subnet.public-a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-c" {
  subnet_id = aws_subnet.public-c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-a" {
  subnet_id = aws_subnet.private-a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-c" {
  subnet_id = aws_subnet.private-c.id
  route_table_id = aws_route_table.private.id
}