variable "create_alarms" {
  description = "Toggle to enable or disable CloudWatch alarms"
  type        = bool
  default     = true
}

variable "alarm_definitions" {
  description = "Map of CloudWatch alarm configurations"

  type = map(object({
    description         = string
    namespace           = string
    metric_name         = string
    comparison_operator = string
    evaluation_periods  = number
    period              = number
    statistic           = string
    threshold           = number
    dimensions          = map(string)
  }))

  default = {}
}

variable "alarm_actions" {
  description = "SNS topic ARNs for alarm notifications"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for CloudWatch alarms"
  type        = map(string)
  default     = {}
}

variable "create_sns_notifications" {
  description = "Create SNS topic for alarm notifications"
  type        = bool
  default     = false
}

variable "sns_topic_name" {
  description = "Name of SNS topic for alerts"
  type        = string
  default     = "cloudwatch-alerts-topic"
}

variable "slack_webhook_endpoint" {
  description = "Slack webhook HTTPS endpoint for notifications"
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "EKS Cluster name for log group naming"
  type        = string
}

variable "log_retention_days" {
  description = "Retention period for CloudWatch logs in days"
  type        = number
  default     = 30
}

