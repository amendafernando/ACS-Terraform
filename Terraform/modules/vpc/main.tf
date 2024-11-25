resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count           = length(var.public_subnets)
  vpc_id          = aws_vpc.main.id
  cidr_block      = var.public_subnets[count.index].cidr
  availability_zone = var.public_subnets[count.index].az
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnets[count.index].name
  }
}

resource "aws_subnet" "private" {
  count           = length(var.private_subnets)
  vpc_id          = aws_vpc.main.id
  cidr_block      = var.private_subnets[count.index].cidr
  availability_zone = var.private_subnets[count.index].az
  tags = {
    Name = var.private_subnets[count.index].name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "${var.vpc_name}-nat"
  }
}

resource "aws_eip" "nat" {
  # vpc = true
  domain   = "vpc"
  
  tags = {
    Name = "NAT Gateway Elastic IP"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
