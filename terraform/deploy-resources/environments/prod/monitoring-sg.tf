# MONITORING SG
module "monitoring_sg" {
  source          = "../../../modules/security_groups/monitoring"
  vpc_id          = module.prod_vpc.vpc_id
  environment     = "prod"

  monitoring_ingress_rules = [
    {
      description = "Allow Prometheus"
      from_port   = 9090
      to_port     = 9090
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow Grafana"
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  monitoring_egress_rules = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  monitoring_sg_tags = {
    Name        = "monitoring-sg"
    Environment = "prod"
  }

}
