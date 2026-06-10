resource "aws_security_group" "db_sg" {
  name        = "${var.environment}-db-sg"
  description = "Security group for ${var.environment}-db"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.db_sg_ingress_rules
    content {
      description      = lookup(ingress.value, "description", null)
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = lookup(ingress.value, "cidr_blocks", [])
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", [])
      prefix_list_ids  = lookup(ingress.value, "prefix_list_ids", [])
      security_groups  = lookup(ingress.value, "source_security_group_ids", [])
      self             = lookup(ingress.value, "self", false)
    }
  }

  dynamic "egress" {
    for_each = var.db_sg_egress_rules
    content {
      description      = lookup(egress.value, "description", null)
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = lookup(egress.value, "cidr_blocks", [])
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", [])
      prefix_list_ids  = lookup(egress.value, "prefix_list_ids", [])
      security_groups  = lookup(egress.value, "security_groups", [])
      self             = lookup(egress.value, "self", false)
    }
  }

  tags = merge(
    var.db_sg_tags,
    { Name = "${var.environment}-db-sg" }
  )
}


# Cache SG
# Security group for ElastiCache (Memcached)
resource "aws_security_group" "cache_sg" {
  name        = "${var.environment}-cache-sg"
  description = "Allow app servers to access Memcached"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 11211
    to_port         = 11211
    protocol        = "tcp"
    security_groups = var.cache_source_sg # only app servers can talk to cache
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-cache-sg"
  }
}
