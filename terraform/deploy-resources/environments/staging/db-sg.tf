# DB SG
module "db_sg" {
  source          = "../../../modules/security_groups/db"
  vpc_id          = module.dev_vpc.vpc_id
  environment     = "Dev"

  db_sg_ingress_rules = [
    {
      description              = "Allow MySQL from web tier"
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      source_security_group_ids = [module.web_sg.web_sg_id]
    }
  ]

  db_sg_egress_rules = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  db_sg_tags = {
    Name        = "db-sg"
    Environment = "Dev"
  }
  # Cache Security Group
  cache_source_sg = [module.web_sg.web_sg_id]  # only app servers can talk to cache
}
