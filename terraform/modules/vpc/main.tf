# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy

  tags = merge(
  local.common_tags,
  {
    Name = "${var.environment}-vpc"
  }
)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
  local.common_tags,
  {
    Name = "${var.environment}-igw"
  }
)
}
# Public Subnets
resource "aws_subnet" "public_subnet" {
  for_each = {
    for idx, cidr in var.public_subnet_cidr :
    idx => cidr
  }

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = element(var.availability_zones, each.key)
  map_public_ip_on_launch = var.public_ip_on_launch

  tags = merge(
  local.common_tags,
  {
    Name = "${var.environment}-Public-Subnet-${each.key + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
)
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  for_each = {
    for idx, cidr in var.private_subnet_cidr :
    idx => cidr
  }

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = element(var.availability_zones, each.key)

  tags = merge(
  local.common_tags,
  {
    Name = "${var.environment}-Private-Subnet-${each.key + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"            = "1"
  }
)
}

# Public Route Table
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.PublicRT_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
  local.common_tags,
  {
    Name = "${var.environment}-Public-RT"
  }
)
}

resource "aws_route_table_association" "PublicSubnetAssoc" {
  for_each = aws_subnet.public_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.PublicRT.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "eip" {
  count = local.nat_gateway_count

  tags = merge(
  local.common_tags,
  {
    Name = "${var.environment}-eip-${count.index + 1}"
  }
)
}

# NAT Gateway
resource "aws_nat_gateway" "ngw" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.eip[count.index].id

  subnet_id = (
    var.environment == "prod"
      ? values(aws_subnet.public_subnet)[count.index].id
      : values(aws_subnet.public_subnet)[0].id
  )

  tags = merge(
  local.common_tags,
  {
    Name = "${var.environment}-ngw-${count.index + 1}"
  }
)
}

# Private Route Table (single for dev)
resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.vpc.id

  dynamic "route" {
    for_each = local.nat_gateway_count > 0 ? [1] : []

    content {
      cidr_block     = var.PrivateRT_cidr
      nat_gateway_id = aws_nat_gateway.ngw[0].id
    }
  }

  tags = merge(
  local.common_tags,
  {
    Name = "${var.environment}-Private-RT"
  }
)
}

resource "aws_route_table_association" "PrivateSubnetAssoc" {
  for_each = aws_subnet.private_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.PrivateRT.id
}


# # Default Security Group
# resource "aws_default_security_group" "restrict_default" {
#   vpc_id = aws_vpc.vpc.id

#   # Remove all inbound rules
#   ingress = []

#   # Allow all outbound traffic (AWS default)
#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = merge(
#     var.tags,
#     {
#       Name = "${var.environment}-default-sg-restricted"
#     }
#   )
# }
