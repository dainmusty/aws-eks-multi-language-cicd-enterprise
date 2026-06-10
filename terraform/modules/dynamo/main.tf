
# DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"  # Cost: ~$0.01/month
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock ${title(var.environment)}"
    Environment = var.environment
  }
}
