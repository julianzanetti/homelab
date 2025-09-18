variable "instance_key" {
  description = "EC2 Instance keypair"
  type = string
  default = "terraform-us"
}

variable "instances" {
  description = "Configuration for EC2 instances (Type and Spot)"
  type = map(object({
    instance_type = string
    is_spot       = bool
  }))

  default = {
    "1" = {
      instance_type = "t4g.small"
      is_spot       = false
    }
    "2" = {
      instance_type = "t4g.small"
      is_spot       = true
    }
    "3" = {
      instance_type = "t4g.small"
      is_spot       = true
    }  
  }
}