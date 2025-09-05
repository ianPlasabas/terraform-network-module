resource "aws_vpc" "main" {
  cidr_block           = var.vpc_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.vpc_tags
}

resource "aws_subnet" "web_subnet" {
  for_each                = var.web_subnet
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = each.value
  map_public_ip_on_launch = true
  tags                    = var.web_tags
}

resource "aws_subnet" "app_subnet" {
  for_each                = var.app_subnet
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = each.value
  map_public_ip_on_launch = false
  tags                    = var.app_tags
}

resource "aws_subnet" "db_subnet" {
  for_each                = var.db_subnet
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = each.value
  map_public_ip_on_launch = false
  tags                    = var.db_tags
}