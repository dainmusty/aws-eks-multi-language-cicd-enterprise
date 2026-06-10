resource "aws_network_acl" "acl" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Environment"]}-nacl"
    }
  )
}

resource "aws_network_acl_association" "assoc" {

  for_each = {
    for idx, subnet_id in var.subnet_ids :
    idx => subnet_id
  }

  subnet_id      = each.value
  network_acl_id = aws_network_acl.acl.id
}

resource "aws_network_acl_rule" "ingress" {
  for_each = {
    for rule in var.ingress_rules : rule.rule_number => rule
  }

  network_acl_id = aws_network_acl.acl.id
  rule_number    = each.value.rule_number
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
  egress         = false
}

resource "aws_network_acl_rule" "egress" {
  for_each = {
    for rule in var.egress_rules : rule.rule_number => rule
  }

  network_acl_id = aws_network_acl.acl.id
  rule_number    = each.value.rule_number
  protocol       = each.value.protocol
  rule_action    = each.value.rule_action
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
  egress         = true
}




