output "vpc_id" {
  description = "ID of VPC"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "ARN of VPC"
  value       = aws_vpc.main.arn
}

output "vpc_cidr" {
  description = "CIDR of VPC"
  value       = aws_vpc.main.cidr_block
}