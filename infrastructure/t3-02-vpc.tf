module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = var.vpc_availability_zones
  private_subnets = var.vpc_private_subnet_cidrs
  public_subnets  = var.vpc_public_subnet_cidrs

  # Enable DNS hostnames and support for IPv6
  enable_dns_hostnames = true
  enable_dns_support   = true 

  # Tags
  ## Tags for Public Subnets
  public_subnet_tags = {
    Name        = "${var.vpc_name}-public"
    Environment = "Homelab"
    Owner      = "Julian Zanetti"
  }

  ## Tags for Private Subnets
  private_subnet_tags = {
    Name        = "${var.vpc_name}-private"
    Environment = "Homelab"
    Owner      = "Julian Zanetti"
  }

  ## Tags for the VPC
  tags = {
    Name        = var.vpc_name
    Environment = "Homelab"
    Owner      = "Julian Zanetti"
  }
}