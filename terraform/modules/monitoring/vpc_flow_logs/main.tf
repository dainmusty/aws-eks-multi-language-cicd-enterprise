resource "aws_flow_log" "vpc_flow_logs" {

  count  = var.enable_flow_logs ? 1 : 0

  vpc_id = var.vpc_id

  log_destination_type = var.log_destination_type
  log_destination      = var.log_destination_arn
  iam_role_arn = var.log_destination_type == "cloud-watch-logs" ? var.vpc_flow_log_iam_role_arn: null

  traffic_type = var.traffic_type

  log_format = var.log_format

  max_aggregation_interval = var.max_aggregation_interval

  tags = var.tags
}