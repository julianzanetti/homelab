resource "aws_eip" "public_elastic_ip" {
  depends_on = [ module.public_ec2_instance["1"], module.vpc ]
  instance = module.public_ec2_instance["1"].id
  domain = "vpc"
  tags = local.common_tags + {
    Name = "Homelab-Public-ElasticIP"
  }
}