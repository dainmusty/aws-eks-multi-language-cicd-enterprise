module "uat_prod_s3_replication" {
  source = "../../modules/storage/s3_replication"

  environment = "uat-prod"

  log_bucket_id  = module.uat_environment.log_bucket_name
  log_bucket_arn = module.uat_environment.log_bucket_arn
  replication_bucket_arn = module.uat_environment.replication_bucket_arn
  s3_replication_role_arn = module.uat_environment.replication_role_arn
  tags = {
    Environment = "uat-prod"
    Component   = "replication"
  }
}