data "aws_availability_zones" "available" {
  state = "available"
}
locals {
  web_subnets = {
    for i, cidr in var.web : cidr => {
      cidr_block        = cidr
      availability_zone = data.aws_availability_zones.available.names[i % length(data.aws_availability_zones.available.names)]
    }
  }
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
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true
  tags                    = var.web_tags
}
