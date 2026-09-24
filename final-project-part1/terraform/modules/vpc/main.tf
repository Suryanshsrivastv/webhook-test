resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "app-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "app-igw"
  }
}

resource "aws_subnet" "public_app" {
  vpc_id                  = aws_vpc.main.id
  cidr_block               = var.public_subnet_app_cidr
  availability_zone        = var.availability_zone
  map_public_ip_on_launch  = true

  tags = {
    Name = "public-subnet-app"
  }
}

resource "aws_subnet" "public_cicd" {
  vpc_id                  = aws_vpc.main.id
  cidr_block               = var.public_subnet_cicd_cidr
  availability_zone        = var.availability_zone
  map_public_ip_on_launch  = true

  tags = {
    Name = "public-subnet-cicd"
  }
}

resource "aws_subnet" "private_db" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_db_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "private-subnet-db"
  }
}

resource "aws_subnet" "private_db2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_db2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "private-subnet-db-2"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_app" {
  subnet_id      = aws_subnet.public_app.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_cicd" {
  subnet_id      = aws_subnet.public_cicd.id
  route_table_id = aws_route_table.public.id
}