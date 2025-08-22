output "vpc_id"{
    description = "ID of VPC"
    value = { for key, value in aws_vpc.main: key => value.id }
}

output "vpc_arn"{
    description = "ARN of VPC"
    value = { for key, value in aws_vpc.main: key => value.arn }
}

output "vpc_cidr"{
    description = "CIDR of VPC"
    value = { for key, value in aws_vpc.main: key => value.cidr }
}