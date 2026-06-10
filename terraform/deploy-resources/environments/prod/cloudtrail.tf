module "cloudtrail" {
  source = "../../../modules/monitoring/cloudtrail"

  trail_name     = "prod-cloudtrail"
  s3_bucket_name = module.s3_log_buckets.log_bucket_arn

  enable_log_file_validation    = true
  is_multi_region_trail         = true
  include_global_service_events = true

  tags = {
    Environment = "prod"
    Project     = "multi-region-platform"
  }
}
