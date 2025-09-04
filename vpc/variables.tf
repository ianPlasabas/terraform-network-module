variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition = length(var.cidr_block) == 0
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
  default     = {}
}

variable "web" {
  description = "Map object for web subnet/s"
  type        = set(string)
  default     = =[]
}

variable "web_tags" {
  description = "Tags for web subnet"
  type        = map(string)
  default     = {}
}

variable "app" {
  description = "Map object for app subnet/s"
  type        = map(string)
  default     = {}
}

variable "app_tags" {
  description = "Tags for app subnet"
  type        = map(string)
  default     = {}
}

variable "db" {
  description = "Map object for db subnet/s"
  type        = map(string)
  default     = {}
}

variable "db_tags" {
  description = "Tags for db subnet"
  type        = map(string)
  default     = {}
}