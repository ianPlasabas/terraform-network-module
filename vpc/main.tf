locals {
  # This for expression flattens the nested map into a single map
  # with keys like "web_subnet_10.16.16.0/20"
  flat_subnets = {
    for subnet_type, cidr_map in var.subnets :
    for cidr_block, az in cidr_map :
    "${subnet_type}_${cidr_block}" => {
      cidr_block        = cidr_block
      availability_zone = az
      type              = subnet_type
    }
  }
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.vpc_tags
}

resource "aws_subnet" "this" {
  for_each = local.flat_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  # Here is the conditional using the `startswith` function.
  # It checks the 'type' field which was created in the local variable.
  map_public_ip_on_launch = startswith(each.value.type, "web_")
}