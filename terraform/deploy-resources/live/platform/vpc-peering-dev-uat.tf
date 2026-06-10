module "dev_to_uat_peering" {
  source = "../../modules/networking/vpc_peering"

  requester_vpc_id = module.dev_environment.vpc_id
  accepter_vpc_id  = module.uat_environment.vpc_id

  requester_region = "us-east-1" #var.dev_region
  accepter_region  = "us-east-2" #var.uat_region

  requester_route_table_ids = module.dev_environment.private_route_table_ids
  accepter_route_table_ids  = module.uat_environment.private_route_table_ids

  requester_cidr_block = module.dev_environment.vpc_cidr_block
  accepter_cidr_block  = module.uat_environment.vpc_cidr_block
}