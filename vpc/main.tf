data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  local_web_subnet = toset(var.web)
  local_azs        = toset(data.aws_availability_zones.available.names[*])
  local_subnets_by_az = zipmap(
    tolist(local.local_azs),
    tolist(var.web)
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
  for_each                = local.local_web_subnet
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags                    = var.web_tags
}
