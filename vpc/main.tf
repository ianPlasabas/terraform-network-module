data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Create a map from the list, with numeric keys
  web_subnets_map = { for idx, val in var.web : idx => val }
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.vpc_tags
}

resource "aws_subnet" "web" {
  for_each                = toset(var.web)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = data.aws_availability_zones.available.names[each.value % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true
  tags                    = var.web_tags
}
