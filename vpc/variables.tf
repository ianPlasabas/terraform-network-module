#=================================================
# VPC Variables
#=================================================
variable "vpc_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = length(var.vpc_block) > 0
    error_message = "Please provide a VPC CIDR"
  }
}

variable "tenancy" {
  description = "Tenancy option for VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_support" {
  description = "DNS support option for VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "DNS hostname option for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags for VPC"
  type        = map(string)
  default = {
    Name = "vpc"
  }
}

#=================================================
# Subnet Variable
#=================================================
variable "subnets" {
  description = "Map object for web subnet/s"
  type = map(object({
    cidr = string
    az   = string
    tags = optional(map(string))
  }))
  default = {}
}

#=================================================
# Internet Gateway Variables
#=================================================
variable "igw_tags" {
  description = "Tags for Internet Gateway"
  type        = map(string)
  default = {
    Name = "vpc-igw"
  }
}

#=================================================
# NAT Gateway Variables
#=================================================
variable "eip_tags" {
  description = "Tags for Elastic IP"
  type        = map(string)
  default = {
    Name = "eip"
  }
}

variable "nat_gw_tags" {
  description = "Tags for Elastic IP"
  type        = map(string)
  default = {
    Name = "nat-gateway"
  }
}

#=================================================
# Web Route Table Tags Variables
#=================================================
variable "web_rt_tags" {
  description = "Tags for Web Subnet/s"
  type        = map(string)
  default = {
    Name = "web-rt"
  }
}

#=================================================
# App Route Table Tags Variables
#=================================================
variable "app_rt_tags" {
  description = "Tags for App Subnet/s"
  type        = map(string)
  default = {
    Name = "app-rt"
  }
}

#=================================================
# DB Route Table Tags Variables
#=================================================
variable "db_rt_tags" {
  description = "Tags for DB Subnet/s"
  type        = map(string)
  default = {
    Name = "db-rt"
  }
}
