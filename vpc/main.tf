resource "aws_vpc" "main" {
  for_each             = var.vpc
  cidr_block           = each.value.cidr_block
  instance_tenancy     = each.value.tenancy
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  tags = {
    name = each.key
  }
}