# module "uat_to_prod_peering" {
#   source = "../../modules/networking/vpc_peering"

#   requester_vpc_id = module.uat_vpc.vpc_id
#   accepter_vpc_id  = module.prod_vpc.vpc_id

#   requester_region = "us-east-1" #var.uat_region
#   accepter_region  = "ap-southeast-1" #var.prod_region

#   requester_route_table_ids = module.uat_vpc.private_route_table_ids
#   accepter_route_table_ids  = module.prod_vpc.private_route_table_ids

#   requester_cidr_block = module.uat_vpc.vpc_cidr_block
#   accepter_cidr_block  = module.prod_vpc.vpc_cidr_block

#   auto_accept = true

#   tags = {
#     Name        = "uat-to-prod-peering"
#     Environment = "shared"
#     Component   = "networking"
#   }
# }

