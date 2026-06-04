module "uat_to_prod_peering" {
  source = "../../modules/networking/vpc_peering"

  requester_vpc_id = module.uat_environment.vpc_id
  accepter_vpc_id  = module.prod_environment.vpc_id

  requester_region = "us-east-2" #var.uat_region
  accepter_region  = "us-west-1" #var.prod_region

  requester_route_table_ids = module.uat_environment.private_route_table_ids
  accepter_route_table_ids  = module.prod_environment.private_route_table_ids

  requester_cidr_block = module.uat_environment.vpc_cidr_block
  accepter_cidr_block  = module.prod_environment.vpc_cidr_block
}