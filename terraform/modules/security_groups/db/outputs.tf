output "db_sg_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.db_sg.id
}

output "cache_sg_id" {
  description = "The ID of the cache security group"
  value       = aws_security_group.cache_sg.id
}