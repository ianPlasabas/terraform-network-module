# data.tf (as discussed, this is where you'd put the data source)
data "aws_availability_zones" "available" {
  state = "available"
}

# The number of subnets is determined by the length of the
# CIDR list provided by the user. We use a for expression to
# create a map with a stable key (the CIDR block) for for_each.
locals {
  web_subnets = {
    for index, cidr in var.web : cidr => data.aws_availability_zones.available.names[index]
  }

  app_subnets = {
    for index, cidr in var.app : cidr => data.aws_availability_zones.available.names[index]
  }

  db_subnets = {
    for index, cidr in var.db : cidr => data.aws_availability_zones.available.names[index]
  }
}

resource "aws_vpc" "main" {
  cidr_block          = var.cidr_block
  instance_tenancy    = var.tenancy
  enable_dns_support  = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                = var.vpc_tags
}

resource "aws_subnet" "web" {
  for_each                = local.web_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = each.value
  map_public_ip_on_launch = true
  tags                    = var.web_tags
}

resource "aws_subnet" "app" {
  for_each                = local.app_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = each.value
  tags                    = var.app_tags
}

resource "aws_subnet" "db" {
  for_each                = local.db_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = each.value
  tags                    = var.db_tags
}