variable "aws_region" {
    description = "Region in which AWS Resources to be created"
    type = string
    default = "us-east-1"
}

locals {
    common_tags = {
        Environment = "Homelab"
        Owner       = "Julian Zanetti"
        ManagedBy   = "Terraform"
    }
}