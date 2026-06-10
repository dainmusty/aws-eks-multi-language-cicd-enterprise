
# State bucket outputs (for remote state configuration in child modules)
output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

