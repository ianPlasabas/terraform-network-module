resource "aws_vpc" "main" {
  for_each = var.vpc_main
  cidr_block = each.value.vpc_cidr
  tags = {
    name = each.value.name_tag
  }
}