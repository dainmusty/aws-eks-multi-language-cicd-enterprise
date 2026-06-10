# module "private_nacl" {
#   source = "../../../modules/security_groups/nacl"

#   vpc_id     = module.dev_vpc.vpc_id
#   subnet_ids = module.dev_vpc.private_subnet_ids

#   ingress_rules = [
#     {
#       rule_number = 100
#       protocol    = "tcp"
#       rule_action = "allow"
#       cidr_block  = "10.0.0.0/16"
#       from_port   = 1024
#       to_port     = 65535
#     }
#   ]

#   egress_rules = [
#     {
#       rule_number = 100
#       protocol    = "tcp"
#       rule_action = "allow"
#       cidr_block  = "0.0.0.0/0"
#       from_port   = 0
#       to_port     = 0
#     }
#   ]

#   tags = {
#     Environment = "dev"
#   }
# }
