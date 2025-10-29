#=================================================
# Route Outputs
#=================================================
output "routes_id" {
  description = "Route ID/s"
  value       = { for key, value in aws_route.this : key => value.id }
}

output "routes_status" {
  description = "Route ID/s"
  value       = { for key, value in aws_route.this : key => value.state }
}