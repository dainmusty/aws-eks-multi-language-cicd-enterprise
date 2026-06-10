# WEB SG
module "web_sg" {
  source          = "../../../modules/security_groups/web"
  vpc_id          = module.prod_vpc.vpc_id
  environment = "prod"

  web_ingress_rules = [
    {
      description              = "Allow traffic from ALB"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      source_security_group_ids = [module.alb_sg.alb_sg_id]
    }
  ]

  web_egress_rules = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  web_sg_tags = {
    Name        = "web-sg"
    Environment = "prod"
  }

}
