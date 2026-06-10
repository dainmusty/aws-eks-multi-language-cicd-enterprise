# module "vpc_flow_logs" {
#   source = "../../../modules/monitoring/vpc_flow_logs"

#   vpc_id = module.dev_vpc.vpc_id

#   log_destination_type = "s3"
#   log_destination_arn  = module.s3_log_buckets.log_bucket_arn
#   enable_flow_logs = true
#   vpc_flow_log_iam_role_arn = null # Not needed for S3 destination, for cloudwatch logs,your value should be the ARN of the IAM role that has permissions to write to CloudWatch Logs
#   traffic_type = "ALL"

#   max_aggregation_interval = 600 # 600 seconds = cheaper 60 seconds = more detailed Dev / UAT → 600 Prod → 60 - Best practice

#   tags = {
#     Environment = "dev"
#     Project     = "multi-region-platform"
#     ManagedBy   = "Terraform"
#   }
# }
