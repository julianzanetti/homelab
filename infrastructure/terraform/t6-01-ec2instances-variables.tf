locals {
  instances = {
    "1" = { instance_type = "t4g.small" }
    "2" = { instance_type = "t4g.small" }
    "3" = { instance_type = "t4g.micro" }
  }
}

variable "instance_key" {
  description = "EC2 Instance keypair"
  type = string
  default = "terraform-key"
}