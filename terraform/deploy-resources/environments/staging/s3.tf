# # S3 Module
module "s3_log_buckets" {
  source = "../../../modules/s3/log_buckets"

  # S3 Bucket Names
  log_bucket_name         = "dev-enterprise-log-bucket"
  operations_bucket_name  = "dev-enterprise-operations-bucket"
  replication_bucket_name = "dev-enterprise-replication-bucket"

  # Versioning Status
  log_bucket_versioning_status         = "Enabled"
  operations_bucket_versioning_status  = "Enabled"
  replication_bucket_versioning_status = "Enabled"

  # Logging Prefix
  logging_prefix = "logs/"
  ResourcePrefix = "Dev-Enterprise"
  region = "us-east-1"
  tags = {
    Environment = "dev"
    Project     = "Startup"
  }
}

module "s3_state_buckets" {
  source = "../../../modules/s3/state_buckets"

  region = "us-east-1"
  environment = "dev"
  project_name = "mycompany"

}


