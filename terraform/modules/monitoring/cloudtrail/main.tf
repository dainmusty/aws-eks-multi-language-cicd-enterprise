resource "aws_cloudtrail" "cloudtrail" {
  name                          = var.trail_name
  s3_bucket_name                = var.s3_bucket_name
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_log_file_validation    = var.enable_log_file_validation

  cloud_watch_logs_group_arn = var.cloudwatch_log_group_name != null ? "${var.cloudwatch_log_group_name}:*" : null
  cloud_watch_logs_role_arn  = var.cloudwatch_role_arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }

  tags = var.tags
}

  