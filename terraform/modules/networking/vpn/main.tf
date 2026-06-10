# Create the VPN Gateway
resource "aws_vpn_gateway" "vgw" {
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.environment}-vgw"
  })
}

#Customer Gateway (On-Prem Simulation)
resource "aws_customer_gateway" "cgw" {
  bgp_asn    = var.customer_gateway_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  tags = merge(var.tags, {
    Name = "${var.environment}-cgw"
  })
}


# Create the VPN Connection
resource "aws_vpn_connection" "vpn" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.cgw.id
  type                = "ipsec.1"

  static_routes_only = true

  tags = merge(var.tags, {
    Name = "${var.environment}-vpn"
  })
}

resource "aws_vpn_connection_route" "onprem_route" {
  vpn_connection_id = aws_vpn_connection.vpn.id
  destination_cidr_block = "192.168.0.0/16"
}

# Wire this in later to the private route tables in the VPC module, but for now we can just output the VPN connection details.
# # VPN Gateway Route to On-Premises Network
# resource "aws_route" "to_onprem" {
#   route_table_id         = module.prod_environment.private_route_table_ids[0]
#   destination_cidr_block = "192.168.0.0/16"
#   gateway_id             = aws_vpn_gateway.vgw.id
# }
