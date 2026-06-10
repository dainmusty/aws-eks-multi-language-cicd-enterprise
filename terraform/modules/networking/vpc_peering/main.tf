resource "aws_vpc_peering_connection" "requester_to_accepter" {

  vpc_id        = var.requester_vpc_id
  peer_vpc_id   = var.accepter_vpc_id
  peer_region   = var.accepter_region
  auto_accept   = var.auto_accept

  tags = merge(
    var.tags,
    {
      Name = "${var.requester_region}-to-${var.accepter_region}-peering"
    }
  )
}

############################################################
# routes.tf
############################################################

resource "aws_route" "requester_routes" {

  for_each = {
    for index, route_table_id in var.requester_route_table_ids :
    index => route_table_id
  }

  route_table_id            = each.value
  destination_cidr_block    = var.accepter_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester_to_accepter.id
}

resource "aws_route" "accepter_routes" {

  for_each = {
    for index, route_table_id in var.accepter_route_table_ids :
    index => route_table_id
  }

  route_table_id            = each.value
  destination_cidr_block    = var.requester_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester_to_accepter.id
}
