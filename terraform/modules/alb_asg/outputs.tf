output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.web_alb.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.web_alb.arn
}


output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.web_tg.arn
}

output "asg_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.web_asg.name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.web_lt.id
}
