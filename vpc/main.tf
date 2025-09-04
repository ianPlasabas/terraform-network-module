data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  local_web_subnet = toset(var.web)
  all_azs = tolist(data.aws_availability_zones.available.names[*])
  selected_azs    = slice(local.all_azs, 0, length(var.web))
  local_subnets_by_az = zipmap(
    tolist(var.web),
    tolist(local.selected_azs)
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
  for_each                = local.local_subnets_by_az
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = each.value
  map_public_ip_on_launch = true
  tags                    = var.web_tags
}
