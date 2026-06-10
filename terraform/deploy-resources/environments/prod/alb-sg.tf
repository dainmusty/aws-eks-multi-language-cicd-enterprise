# Security Groups Module
# ALB SG
module "alb_sg" {
  source          = "../../../modules/security_groups/alb"
  vpc_id          = module.prod_vpc.vpc_id
  environment = "prod"

  alb_sg_ingress_rules = [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  alb_sg_egress_rules = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  alb_sg_tags = {
  "Name"        = "dev-alb-sg"
  "Project"     = "Startup"
  "Environment" = "prod"
  "ManagedBy"   = "Terraform"
}

}