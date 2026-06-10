resource "aws_vpc_endpoint" "vpc_endpt" {
  vpc_id            = var.vpc_id
  service_name      = var.service_name
  vpc_endpoint_type = var.endpoint_type

  route_table_ids    = var.endpoint_type == "Gateway" ? var.route_table_ids : null
  subnet_ids         = var.endpoint_type == "Interface" ? var.subnet_ids : null
  security_group_ids = var.endpoint_type == "Interface" ? var.security_group_ids : null

  private_dns_enabled = var.endpoint_type == "Interface" ? var.private_dns_enabled : null

  tags = var.tags
}
