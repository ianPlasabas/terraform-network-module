data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # This creates a map with the CIDR blocks as the keys
  # This makes each element uniquely identifiable and independent of its position in the list.
  web_subnets_map = { for cidr in var.web : cidr => cidr }
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
  cidr_block              = each.key
  availability_zone       = data.aws_availability_zones.available.names[index(var.web, each.value) % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true
  tags                    = var.web_tags
}
