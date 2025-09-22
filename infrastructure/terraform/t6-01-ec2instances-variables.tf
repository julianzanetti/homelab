variable "instance_key" {
  description = "EC2 Instance keypair"
  type = string
  default = "terraform-us"
}

variable "type_instance" {
  description = "Type of instance"
  type = string
  default = "t4g.small"
}

variable "worker_user_data_file" {
  description = "Path to user data file for worker nodes"
  type = string
  default = "scripts/k3s-workers.sh"  
}