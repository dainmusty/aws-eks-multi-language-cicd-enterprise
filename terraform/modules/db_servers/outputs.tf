output "db_server_id" {
  description = "Primary DB server instance ID"
  value       = aws_instance.db_servers[0].id
}