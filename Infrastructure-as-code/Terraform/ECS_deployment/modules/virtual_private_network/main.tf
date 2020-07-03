# creating vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.aws_vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = var.vpc_name
  }
}

# creating internet gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-internetGateway"
  }
}

# creating public subnets,
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets_availability_zone)
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.public_subnets_availability_zone[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-publicSubnet-${count.index+1}"
  }
}

# creating eip
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.IGW]
  vpc = true
  tags = {
    Name = "${var.vpc_name}-natGatewayElasticIP"
  }
}

# creating natgateway in public subnets 1
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = "${var.vpc_name}-natGateway"
  }
}

# creating public route table for dmz and pulic subent
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-publicRouteTable"
  }
}

# associatons of public subnets to the route table
resource "aws_route_table_association" "public_association" {
  count             = length(var.public_subnets_availability_zone)
  route_table_id    = aws_route_table.public_rt.id
  subnet_id         = aws_subnet.public_subnet[count.index].id

}

resource "random_integer" "numnet_dmz" {
  max = 10
  min = 0
}
# creating dmz subnets
resource "aws_subnet" "DMZ_subnet" {
  count                   = length(var.dmz_subnets_availability_zone)
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index+2+random_integer.numnet_dmz.result)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.dmz_subnets_availability_zone[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-DMZSubnet-${count.index+1}"
  }
}

# associatons of dmz subnets to the route table
resource "aws_route_table_association" "DMZ_association" {
  count             = length(var.dmz_subnets_availability_zone)
  route_table_id    = aws_route_table.public_rt.id
  subnet_id         = aws_subnet.DMZ_subnet[count.index].id
}

# internet gateway attachment with public route table
resource "aws_route" "public_route" {
  depends_on             = [aws_internet_gateway.IGW]
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id

}

resource "random_integer" "numnet" {
  max = 15
  min = 10
}

# creating private subnets
resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_subnets_availability_zone)
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index+5)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.private_subnets_availability_zone[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.vpc_name}-privateSubnet-${count.index+1}"
  }
}

#creating route table for private subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-privateRT"
  }
}
# associations of private subnets with route table
resource "aws_route_table_association" "private_association" {
  count          = length(var.private_subnets_availability_zone)
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}

# nat-gateway attachment with private route table
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# security group for public subnets
resource "aws_security_group" "public_subnet_SG" {
  vpc_id      = aws_vpc.vpc.id
  description = "Security Group to access public subnets"

  dynamic "ingress" {
    for_each = [80, 22]
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = ingress.value
      protocol    = "tcp"
      to_port     = ingress.value
    }
  }
  tags = {
    Name = "${var.vpc_name}-publicSecurityGroup"
  }
}

# security group for dmz subnets
resource "aws_security_group" "dmz_subnet_SG" {
  vpc_id      = aws_vpc.vpc.id
  description = "Security Group to access public subnets"

  dynamic "ingress" {
    for_each = [80]
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = ingress.value
      protocol    = "tcp"
      to_port     = ingress.value
    }
  }
  tags = {
    Name = "${var.vpc_name}-dmzSecurityGroup"
  }
}
