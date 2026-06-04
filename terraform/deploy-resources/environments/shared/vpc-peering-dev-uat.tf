# module "dev_to_uat_peering" {
#   source = "../../modules/networking/vpc_peering"

#   requester_vpc_id = module.dev_vpc.vpc_id
#   accepter_vpc_id  = module.uat_vpc.vpc_id

#   requester_region = "eu-west-1" #var.dev_region
#   accepter_region  = "us-east-1" #var.uat_region

#   requester_route_table_ids = module.dev_vpc.private_route_table_ids
#   accepter_route_table_ids  = module.uat_vpc.private_route_table_ids

#   requester_cidr_block = module.dev_vpc.vpc_cidr_block
#   accepter_cidr_block  = module.uat_vpc.vpc_cidr_block

#   auto_accept = true

#   tags = {
#     Name        = "dev-to-uat-peering"
#     Environment = "shared"
#     Component   = "networking"
#   }
# }