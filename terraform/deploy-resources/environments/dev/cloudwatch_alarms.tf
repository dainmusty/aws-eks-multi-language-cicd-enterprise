# module "cloudwatch_alarms" {
#   source = "../../../modules/monitoring/cloudwatch"

#   create_alarms            = true
#   create_sns_notifications = true
#   cluster_name = module.eks.cluster_name

#   sns_topic_name = "prod-cloudwatch-alerts"

#   slack_webhook_endpoint = "your-slack-webhook-url" # Replace with your actual Slack webhook URL

#   alarm_definitions = {

#     HighCPUUtilization = {
#       description         = "Alarm when EC2 CPU exceeds 80%"
#       namespace           = "AWS/EC2"
#       metric_name         = "CPUUtilization"
#       comparison_operator = "GreaterThanThreshold"
#       evaluation_periods  = 2
#       period              = 300
#       statistic           = "Average"
#       threshold           = 80

#       dimensions = {
#         InstanceId = module.db_servers.db_server_id
#       }
#     }

#     InstanceStatusCheckFailed = {
#       description         = "Alarm when EC2 status check fails"
#       namespace           = "AWS/EC2"
#       metric_name         = "StatusCheckFailed"
#       comparison_operator = "GreaterThanThreshold"
#       evaluation_periods  = 1
#       period              = 60
#       statistic           = "Maximum"
#       threshold           = 1

#       dimensions = {
#         InstanceId = module.db_servers.db_server_id
#       }
#     }

#     ASGUnhealthyInstances = {
#       description         = "Alarm when Auto Scaling Group has unhealthy instances"
#       namespace           = "AWS/AutoScaling"
#       metric_name         = "UnhealthyHostCount"
#       comparison_operator = "GreaterThanThreshold"
#       evaluation_periods  = 1
#       period              = 60
#       statistic           = "Average"
#       threshold           = 1

#       dimensions = {
#         AutoScalingGroupName = module.alb_asg.asg_name
#       }
#     }

#   }

#   alarm_actions = []

#   tags = {
#     Environment = "prod"
#     ManagedBy   = "Terraform"
#     Component   = "Monitoring"
#   }
# }