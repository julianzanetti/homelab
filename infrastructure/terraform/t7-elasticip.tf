resource "aws_eip" "public_elastic_ip" {
  depends_on = [ module.public_ec2_instance, module.vpc ]
  instance = module.public_ec2_instance.id
  domain = "vpc"
  tags = merge(local.common_tags, {
    Name = "homelab-public-elastic-ip"
  })
}

# --- SSM Parameter for Master IP ---
resource "aws_ssm_parameter" "k3s_master_ip" {
  name        = "/k3s/master_ip"
  description = "IP for Master Instace to joining nodes to the cluster"
  type        = "String"
  value       = "${aws_eip.public_elastic_ip.public_ip}"
  overwrite   = true
  tags        = local.common_tags
}