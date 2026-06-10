output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_lock.name
}