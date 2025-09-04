variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition = length(var.cidr_block) > 0
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

variable "subnet" {
  description = "Map object for web subnet/s"
  type        = object({
    web = map(string)
    app = map(string)
    db  = map(string)
  })
  default     = {
    web = {}
    app = {}
    db  = {}
  }
}

variable "web_tags" {
  description = "Tags for web subnet"
  type        = map(string)
  default     = {}
}