variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
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
  default     = {}
}

variable "web" {
  description = "List of CIDR blocks for web subnets"
  type        = list(string)
  default     = []
}

variable "web_tags" {
  description = "Tags for web subnets"
  type        = map(string)
  default     = {}
}

variable "app" {
  description = "List of CIDR blocks for application subnets"
  type        = list(string)
  default     = []
}

variable "app_tags" {
  description = "Tags for application subnets"
  type        = map(string)
  default     = {}
}

variable "db" {
  description = "List of CIDR blocks for database subnets"
  type        = list(string)
  default     = []
}

variable "db_tags" {
  description = "Tags for database subnets"
  type        = map(string)
  default     = {}
}