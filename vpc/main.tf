#=================================================
# VPC
#=================================================
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.vpc_tags
}

#=================================================
# Subnets
#=================================================
resource "aws_subnet" "this" {
  for_each                = var.subnets
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = startswith(each.key, "web")
  tags                    = each.value.tags
}

#=================================================
# Internet Gateway
#=================================================
resource "aws_internet_gateway" "this" {
  count  = length({ for key, value in var.subnets : key => value if startswith(key, "web") }) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id
  tags   = var.igw_tags
}

#=================================================
# NAT Gateway
#=================================================

resource "aws_eip" "this" {
  for_each = { for key, value in var.subnets : key => value if startswith(key, "web") }
  domain   = "vpc"
  tags     = var.eip_tags
}

resource "aws_nat_gateway" "this" {
  for_each      = { for key, value in var.subnets : key => value if startswith(key, "web") }
  allocation_id = aws_eip.this[each.key].id
  subnet_id     = aws_subnet.this[each.key].id
  depends_on    = [aws_internet_gateway.this]
  tags          = var.nat_gw_tags
}

#=================================================
# Web Route Table
#=================================================
resource "aws_route_table" "web" {
  count  = length({ for key, value in var.subnets : key => value if startswith(key, "web") }) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id
  tags   = var.web_rt_tags

}

resource "aws_route_table_association" "web" {
  for_each       = { for key, value in var.subnets : key => value if startswith(key, "web") }
  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.web[0].id
}

#=================================================
# App Route Tables
#=================================================
resource "aws_route_table" "app" {
  for_each = { for key, value in var.subnets : key => value if startswith(key, "app") }
  vpc_id   = aws_vpc.this.id
  tags     = var.app_rt_tags
}

resource "aws_route_table_association" "app" {
  for_each       = { for key, value in var.subnets : key => value if startswith(key, "app") }
  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.app[each.key].id
}

#=================================================
# DB Route Tables
#=================================================
resource "aws_route_table" "db" {
  for_each = { for key, value in var.subnets : key => value if startswith(key, "db") }
  vpc_id   = aws_vpc.this.id
  tags     = var.db_rt_tags
}

resource "aws_route_table_association" "db" {
  for_each       = { for key, value in var.subnets : key => value if startswith(key, "db") }
  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.db[each.key].id
}