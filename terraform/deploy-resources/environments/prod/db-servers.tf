module "db_servers" {
  source = "../../../modules/db_servers"

  tier_name = "db"

  instance_count = 1
  instance_type  = "t2.micro"
  ami_id         = data.aws_ami.amazon_linux.id

  subnet_ids = module.prod_vpc.private_subnet_ids

  security_group_ids = [module.db_sg.db_sg_id]

  key_name = "us-east-1-musty" # module.ssm.key_name

  instance_profile_name = "admin-musty" #module.iam.ec2_profile
  volume_size = 8

  tags = {
    Environment = "prod"
    Project     = "startup"
  }
}