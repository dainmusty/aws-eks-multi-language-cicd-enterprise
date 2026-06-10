# Bastion SG
module "bastion_sg" {
  source = "../../../modules/security_groups/bastion"
  vpc_id = module.dev_vpc.vpc_id
  environment    = "Dev"

  bastion_ingress_rules = [
    {
      description = "Allow traffic from the internet"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]


  bastion_egress_rules = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  bastion_sg_tags = {
    Name        = "bastion-sg"
    Environment = "Dev"
  }

}

