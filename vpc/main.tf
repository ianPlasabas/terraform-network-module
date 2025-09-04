data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Trim the list of AZs to match the number of CIDR blocks
  limited_azs = slice(data.aws_availability_zones.available.names, 0, length(var.subnet_cidr_blocks))
  # Create a map pairing each CIDR with a specific AZ
  subnet_config = zipmap(local.limited_azs, var.subnet_cidr_blocks)
}


resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.vpc_tags
}

resource "aws_subnet" "web" {
  for_each                = local.subnet_config
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags                    = var.web_tags
}
