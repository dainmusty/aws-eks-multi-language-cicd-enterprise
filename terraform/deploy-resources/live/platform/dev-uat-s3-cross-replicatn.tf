module "dev_uat_s3_replication" {
  source = "../../modules/storage/s3_replication"

  environment = "dev-uat"

  log_bucket_id  = module.dev_environment.log_bucket_name
  log_bucket_arn = module.dev_environment.log_bucket_arn
  replication_bucket_arn = module.dev_environment.replication_bucket_arn
  s3_replication_role_arn = module.dev_environment.replication_role_arn
  tags = {
    Environment = "dev-uat"
    Component   = "replication"
  }
}