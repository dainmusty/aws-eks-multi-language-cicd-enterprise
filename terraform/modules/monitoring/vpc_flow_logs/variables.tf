variable "enable_flow_logs" {
  description = "Enable or disable VPC Flow Logs"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC ID to enable flow logs for"
  type        = string
}

variable "log_destination_type" {
  description = "Destination type for logs (s3 or cloud-watch-logs)"
  type        = string
  default     = "s3"
}

variable "log_destination_arn" {
  description = "ARN of the destination (S3 bucket or CloudWatch Log Group)"
  type        = string
}

variable "traffic_type" {
  description = "Traffic type to capture (ACCEPT, REJECT, ALL)"
  type        = string
  default     = "ALL"
}

variable "log_format" {
  description = "Custom log format"
  type        = string
  default     = "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status}"
}

variable "max_aggregation_interval" {
  description = "Aggregation interval in seconds (60 or 600)"
  type        = number
  default     = 600
}

variable "tags" {
  description = "Tags to apply to VPC Flow Logs"
  type        = map(string)
  default     = {}
}

variable "vpc_flow_log_iam_role_arn" {
  description = "IAM role ARN for CloudWatch Flow Logs"
  type        = string
  default     = null
}