output "ec2_public_instance_id" {
  description = "The ID of the EC2 Public instance"
  value       = [for ec2public in module.public_ec2_instance: ec2public.id]
}

output "ec2_public_instance_public_ip" {
  description = "The public IP address assigned to the EC2 Public instance."
  value       = [for ec2public in module.public_ec2_instance: ec2public.public_ip]
}

output "ec2_spot_instance_public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = [for ec2public in module.public_ec2_instance: ec2public.public_dns]
}