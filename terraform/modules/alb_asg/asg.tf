resource "aws_autoscaling_group" "web_asg" {
  name                      = var.asg_name
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = "EC2"
  force_delete              = true

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web_tg.arn]

  tag {
    key                 = "Name"
    value               = var.asg_name
    propagate_at_launch = true
  }
}
