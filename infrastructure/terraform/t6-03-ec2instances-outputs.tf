output "ec2_public_instance_id" {
  description = "The ID of the EC2 Public instance"
  value       = [module.public_ec2_instance.id]
}

output "ec2_public_instance_public_ip" {
  description = "The public IP address assigned to the EC2 Public instance."
  value       = [module.public_ec2_instance.public_ip]
}

output "ec2_spot_instance_public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = [module.public_ec2_instance.public_dns]
}