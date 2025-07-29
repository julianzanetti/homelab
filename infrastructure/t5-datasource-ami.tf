# Get Latest AWS AMI ID for Amazon2 Linux
data "aws_ami" "amzlinux2" {
  most_recent = true                            # We will get the latest version of the AMI we choose later
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-arm64-gp2" ]   
  }
  filter {
    name = "root-device-type"                  
    values = [ "ebs" ]  
  }
  filter {
    name = "virtualization-type"           
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "arm64" ]
  }
}