variable "instance_type" {
  description = "Type EC2 Instance"
  type = string
  default = "t4g.small"
}

variable "instance_key" {
  description = "EC2 Instance keypair"
  type = string
  default = "terraform-key"
}