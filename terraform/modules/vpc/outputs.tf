output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = values(aws_subnet.public_subnet)[*].id
}

output "private_subnet_ids" {
  value = values(aws_subnet.private_subnet)[*].id
}

output "public_route_table_ids" {
  value = aws_route_table.PublicRT[*].id
}

output "private_route_table_ids" {
  value = aws_route_table.PrivateRT[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.ngw[*].id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.vpc.cidr_block
}