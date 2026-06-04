resource "aws_launch_template" "web_lt" {
  name_prefix   = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.web_sg_id]

  user_data = base64encode(var.user_data)

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.launch_template_name}-instance"
    }
  }
}
