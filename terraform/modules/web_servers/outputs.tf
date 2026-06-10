output "web_server_id" {
  description = "List of web server instance IDs"
  value       = aws_instance.web_server[*].id
}
  