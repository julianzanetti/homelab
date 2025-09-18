module "public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.0.2"

  for_each = var.instances

  name = "homelab-public-${each.key}"
  create_spot_instance = each.value.is_spot
  spot_type = each.value.is_spot ? "persistent" : null
  spot_wait_for_fulfillment = each.value.is_spot

  instance_type = each.value.instance_type
  ami = data.aws_ami.amzlinux2.id

  availability_zone = element(module.vpc.azs, tonumber(each.key) % length(module.vpc.azs))
  key_name = var.instance_key
  vpc_security_group_ids = [module.homelab_sg_public.security_group_id]
  subnet_id = element(module.vpc.public_subnets, tonumber(each.key) % length(module.vpc.public_subnets))
  associate_public_ip_address = true
  root_block_device = {
    type = "gp3"
    size = 10
  }

  tags = local.common_tags
}