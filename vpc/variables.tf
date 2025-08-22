variable "vpc" {
  type = map(object({
    cidr_block = string
    tenancy    = string
    enable_dns_support = bool
    enable_dns_hostnames = bool
  }))
  default = {
    main = {
      cidr_block           = "10.0.0.0/16"
      tenancy              = "default"
      enable_dns_support   = true
      enable_dns_hostnames = true
    }
  }
}
