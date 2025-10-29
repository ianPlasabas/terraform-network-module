#=================================================
# VPC Outputs
#=================================================
output "vpc_arn" {
  description = "ARN of VPC"
  value       = aws_vpc.this.arn
}

output "vpc_id" {
  description = "ID of VPC"
  value       = aws_vpc.this.id
}

#=================================================
# Internet Gateway Outputs
#=================================================
output "igw_id" {
  description = "ID of Internet Gateway"
  value       = aws_internet_gateway.this[0].id
}

output "igw_arn" {
  description = "ARN of Internet Gateway"
  value       = aws_internet_gateway.this[0].arn
}

#=================================================
# Nat Gateway Outputs
#=================================================
output "nat_id" {
  description = "ID of NAT Gateway"
  value       = { for key, value in aws_nat_gateway.this : key => value.id }
}

#=================================================
# Subnet/s Outputs
#=================================================
output "subnets_id" {
  description = "Web Subnet/s ID/s"
  value       = { for key, value in aws_subnet.this : key => value.id }
}

output "subnets_arn" {
  description = "Web Subnet/s ARN/s"
  value       = { for key, value in aws_subnet.this : key => value.arn }
}

#=================================================
# Web Route Table Outputs
#=================================================
output "web-rt-id" {
  description = "Web Route Table ID"
  value       = aws_route_table.web[0].id
}

output "web-rt-arn" {
  description = "Web Route Table ARN"
  value       = aws_route_table.web[0].arn
}

#=================================================
# App Route Table/s Outputs
#=================================================
output "app-rt-id" {
  description = "App Route Table/s ID/s"
  value       = { for key, value in aws_route_table.app : key => value.id }
}

output "app-rt-arn" {
  description = "App Route Table ARN"
  value       = { for key, value in aws_route_table.app : key => value.arn }
}

#=================================================
# DB Route Table/s Outputs
#=================================================
output "db-rt-id" {
  description = "DB Route Table/s ID/s"
  value       = { for key, value in aws_route_table.db : key => value.id }
}

output "db-rt-arn" {
  description = "DB Route Table ARN"
  value       = { for key, value in aws_route_table.db : key => value.arn }
}