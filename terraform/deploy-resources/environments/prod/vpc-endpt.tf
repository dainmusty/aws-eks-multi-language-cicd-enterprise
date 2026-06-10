module "s3_endpoint" {
  source = "../../../modules/vpc_endpoints"

  vpc_id        = module.prod_vpc.vpc_id
  service_name  = "com.amazonaws.eu-west-1.s3"
  endpoint_type = "Gateway"

  route_table_ids = module.prod_vpc.private_route_table_ids

  tags = {
    Environment = "prod"
  }
}
