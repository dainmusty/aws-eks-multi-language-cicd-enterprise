module "web_servers" {
  source = "../../../modules/web_servers"

  tier_name = "web"

  instance_count = 1
  instance_type  = "t2.micro"
  ami_id         = data.aws_ami.amazon_linux.id

  subnet_ids = module.prod_vpc.public_subnet_ids

  security_group_ids = [module.web_sg.web_sg_id]

  key_name = "prod-key" # you can store this in module.ssm.key_name

  instance_profile_name = "your-instance-profile" #module.iam.ec2_profile
  volume_size = 8

  tags = {
    Environment = "prod"
    Project     = "startup"
  }
}