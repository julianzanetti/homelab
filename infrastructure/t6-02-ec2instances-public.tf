module "public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.0.2"

  name = "homelab-public"
  create_spot_instance = true
  spot_type = "persistent"

  instance_type = var.instance_type
  key_name = var.instance_key
  vpc_security_group_ids = [module.homelab_sg_public.security_group_id]
  subnet_id = element(module.vpc.public_subnets, tonumber(each.key))

  tags = local.common_tags
}