resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarms" {

  for_each = var.create_alarms ? var.alarm_definitions : {}

  alarm_name          = each.key
  alarm_description   = each.value.description
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  metric_name         = each.value.metric_name
  namespace           = each.value.namespace
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold

  dimensions = each.value.dimensions

  alarm_actions = var.create_sns_notifications ? [aws_sns_topic.cloudwatch_alerts[0].arn] : var.alarm_actions


  tags = var.tags
}


############################################################
# SNS TOPIC (Optional — Slack Integration)
############################################################

resource "aws_sns_topic" "cloudwatch_alerts" {
  count = var.create_sns_notifications ? 1 : 0

  name = var.sns_topic_name

  tags = var.tags
}

resource "aws_sns_topic_subscription" "slack_subscription" {
  count = var.create_sns_notifications && var.slack_webhook_endpoint != null ? 1 : 0

  topic_arn = aws_sns_topic.cloudwatch_alerts[0].arn
  protocol  = "https"
  endpoint  = var.slack_webhook_endpoint
}



# =========================================================
# CloudWatch Log Group
# =========================================================

resource "aws_cloudwatch_log_group" "eks" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.log_retention_days

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-logs"
  })
}