output "alarm_names" {
  description = "List of created CloudWatch alarm names"
  value       = [for alarm in aws_cloudwatch_metric_alarm.cloudwatch_metric_alarms : alarm.alarm_name]
}

