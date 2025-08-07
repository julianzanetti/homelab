output "public_security_group_id" {
  description = "The ID of the security group"
  value       = module.homelab_sg_public.security_group_id
}

output "public_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.homelab_sg_public.security_group_vpc_id
}

output "public_security_group_name" {
  description = "The name of the security group"
  value       = module.homelab_sg_public.security_group_name
}