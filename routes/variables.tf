#=================================================
# Route Variables
#=================================================
variable "routes" {
  description = "Route parameters"
  type = map(object({
    route_table_id         = string
    destination_cidr_block = string
    nat_gateway_id         = optional(string)
    gateway_id             = optional(string)
  }))
  default = {}
}