#=================================================
# Route
#=================================================
resource "aws_route" "this" {
  for_each               = var.routes
  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.destination_cidr_block
  nat_gateway_id         = each.value.nat_gateway_id
  gateway_id             = each.value.gateway_id
}