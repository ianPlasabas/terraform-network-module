output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "web_subnet_ids" {
  description = "The IDs of the web subnets"
  value       = [for subnet in aws_subnet.web : subnet.id]
}

output "app_subnet_ids" {
  description = "The IDs of the application subnets"
  value       = [for subnet in aws_subnet.app : subnet.id]
}

output "db_subnet_ids" {
  description = "The IDs of the database subnets"
  value       = [for subnet in aws_subnet.db : subnet.id]
}