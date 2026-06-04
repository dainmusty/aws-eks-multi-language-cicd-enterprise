output "vpc_peering_connection_id" {
  description = "VPC Peering Connection ID"
  value       = aws_vpc_peering_connection.requester_to_accepter.id
}

output "vpc_peering_status" {
  description = "Status of VPC peering connection"
  value       = aws_vpc_peering_connection.requester_to_accepter.accept_status
}