variable "trail_name" {
  description = "Name of the CloudTrail trail"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name to store CloudTrail logs"
  type        = string
}

variable "enable_log_file_validation" {
  description = "Enable log file integrity validation"
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  description = "Enable multi-region logging"
  type        = bool
  default     = true
}

variable "include_global_service_events" {
  description = "Include global service events (e.g., IAM)"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_name" {
  description = "Optional CloudWatch log group name"
  type        = string
  default     = null
}

variable "cloudwatch_role_arn" {
  description = "IAM role ARN for CloudTrail to write to CloudWatch"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to CloudTrail resources"
  type        = map(string)
  default     = {}
}
 