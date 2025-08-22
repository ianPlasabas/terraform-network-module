variable vpc {
  type        = map(object({
    cidr_block = string
    name_tag = string
  }))
  default={
    main = {
        vpc_cidr = "10.0.0.0/16"
        name_tag = "custom-vpc"
    }
  }
}
