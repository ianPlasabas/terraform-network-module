variable vpc_main {
  type        = map(object({
    vpc_cidr = string
    name_tag = string
  }))
  default={
    main = {
        vpc_cidr = "10.0.0.0/16"
        name_tag = "custom-vpc"
    }
  }
}
