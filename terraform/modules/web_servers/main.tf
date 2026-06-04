resource "aws_instance" "web_server" {

  count = var.instance_count

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = var.subnet_ids[
    count.index % length(var.subnet_ids)
  ]

  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile = var.instance_profile_name

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Environment"]}-${var.tier_name}-${count.index + 1}"
    }
  )
}