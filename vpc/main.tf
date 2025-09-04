locals {
  # The number of subnets is now determined by the length of the
  # CIDR list provided by the user.
  web_subnets = zipmap(
    data.aws_availability_zones.available.names[0:length(var.web)],
    var.web
  )
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.vpc_tags
}

resource "aws_subnet" "web" {
  for_each                = local.web_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags                    = var.web_tags
}

resource "aws_subnet" "app" {
  for_each          = var.app
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key
  tags              = var.app_tags
}

resource "aws_subnet" "db" {
  for_each          = var.db
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key
  tags              = var.db_tags
}

