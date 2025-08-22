resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    name = each.key
  }
}

resource "aws_subnet" "private_main" {
  for_each   = var.private_subnet
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = {
    Name = "Main"
  }
}