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

variable "private_subnet" {
  description = "Map object for private subnet/s"
  type        = map(string)
  default     = {}
}