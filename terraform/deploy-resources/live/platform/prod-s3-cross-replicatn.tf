module "prod_s3_replication" {
  source = "../../modules/storage/s3_replication"

  environment = "prod"

  log_bucket_id  = module.prod_environment.log_bucket_name
  log_bucket_arn = module.prod_environment.log_bucket_arn
  replication_bucket_arn = module.prod_environment.replication_bucket_arn
  s3_replication_role_arn = module.prod_environment.replication_role_arn
  tags = {
    Environment = "prod"
    Component   = "replication"
  }
}