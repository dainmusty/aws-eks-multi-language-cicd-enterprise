module "alb_asg" {
  source = "../../../modules/alb_asg" # adjust path to where you put the module

  vpc_id              = module.prod_vpc.vpc_id
  subnet_ids          = module.prod_vpc.public_subnet_ids
  web_sg_id           = module.web_sg.web_sg_id
  alb_sg_id           = [module.alb_sg.alb_sg_id] # ALB SG expects a list
  ami_id              = "ami-08b5b3a93ed654d19" # Amazon Linux 2023 AMI ID in us-east-1 as of April 2024
  instance_type       = "t2.micro"
  key_name            = "us-east-1-musty"
  user_data           = file("${path.module}/../../../../scripts/public_userdata.sh") # Update the user_data script as needed

  launch_template_name = "startup-web-lt"
  asg_name             = "startup-web-asg"
  asg_min_size         = 1
  asg_max_size         = 2
  asg_desired_capacity = 1

  alb_name          = "startup-web-alb"
  target_group_name = "startup-web-tg"
  app_port          = 3000
  alb_type          = "application"
}

