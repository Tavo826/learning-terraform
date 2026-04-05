resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "VPC-${var.project_name}-${var.env}"
    }
}

resource "aws_subnet" "public" {
    count                   = length(var.public_subnets)
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.public_subnets[count.index]
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-Subnet-${var.project_name}-${var.env}-${count.index + 1}"
    }
}

resource "aws_subnet" "private" {
    count                   = length(var.private_subnets)
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.private_subnets[count.index]
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    tags = {
        Name = "Private-Subnet-${var.project_name}-${var.env}-${count.index + 1}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "IGW-${var.project_name}-${var.env}"
    }
}

resource "aws_route_table" "pub" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "Public-RT-${var.project_name}-${var.env}"
    }
}


resource "aws_route_table_association" "public_assoc" {
    count          = length(var.public_subnets)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.pub.id
}

resource "aws_eip" "nat" {
    domain = "vpc"

    tags = {
      Name = "NAT-EIP-${var.project_name}-${var.env}"
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public[0].id
    tags = {
        Name = "NAT-GW-${var.project_name}-${var.env}"
    }
}

resource "aws_route_table" "priv" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
      Name = "Private-RT-${var.project_name}-${var.env}"
    }
}

resource "aws_route_table_association" "priv_assoc" {
    count          = length(var.private_subnets)
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.priv.id
}

data "aws_availability_zones" "available" {
  state = "available"
}