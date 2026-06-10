output "vpc_id" {
  description = "VPC ID"
  value       = module.prod_vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.prod_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = module.prod_vpc.private_subnet_ids
}

output "public_route_table_ids" {
  description = "Public Route Table IDs"
  value       = module.prod_vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "Private Route Table IDs"
  value       = module.prod_vpc.private_route_table_ids
}

output "vpc_cidr_block" {
  description = "VPC CIDR Block"
  value       = module.prod_vpc.vpc_cidr_block
}



output "log_bucket_name" {
  value = module.s3_log_buckets.log_bucket_name
}

output "log_bucket_arn" {
  value = module.s3_log_buckets.log_bucket_arn
}

output "replication_bucket_arn" {
  value = module.s3_log_buckets.replication_bucket_arn
}

output "replication_role_arn" {
  value = module.iam_core.replication_role_arn
}