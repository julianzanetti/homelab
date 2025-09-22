# --- Master On-demand Instance ---
module "public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

  name = "homelab-master"
  instance_type = var.type_instance
  ami = data.aws_ami.amzlinux2.id

  availability_zone = element(module.vpc.azs, 0)
  key_name = var.instance_key
  vpc_security_group_ids = [module.homelab_sg_public.security_group_id]
  subnet_id = element(module.vpc.public_subnets, 0)
  associate_public_ip_address = true
  
  root_block_device = {
    type = "gp3"
    size = 10
    delete_on_termination = true
  }

  tags = merge(local.common_tags, {Role = "k3s-master"})
}

# --- SSM Parameter for Node token ---
resource "aws_ssm_parameter" "k3s_token" {
  name        = "/k3s/token"
  description = "K3s token for joining nodes to the cluster"
  type        = "String"
  value       = ""
  overwrite   = true
  tags        = local.common_tags
}


# --- ASG for Worker Nodes ---
module "k3s_workers_asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "9.0.1"
  
  # Austoscaling group settings
  name = "k3s-workers-asg"
  vpc_zone_identifier = module.vpc.public_subnets
  instance_name = "k3s-worker"
  min_size = 2
  max_size = 3
  desired_capacity = 2
  health_check_type = "EC2"
  capacity_rebalance = true
  wait_for_capacity_timeout = 0

  # Launch template settings
  launch_template_name = "k3s-workers-launch-template"
  launch_template_description = "K3s Worker Nodes Launch Template"
  image_id = data.aws_ami.amzlinux2.id
  instance_type = var.type_instance
  key_name = var.instance_key
  user_data = filebase64(var.worker_user_data_file)
  
  block_device_mappings = {
    device_name = "/dev/xvda"
    ebs = {
      volume_size = 10
      volume_type = "gp3"
      delete_on_termination = true
    }
  }

  network_interfaces = {
    associate_public_ip_address = true
    security_groups = [module.homelab_sg_public.security_group_id]
    device_index = 0
  }

}