# terraform/bootstrap/main.tf
# Run this FIRST to create state buckets

terraform {
  # This uses LOCAL state to create remote state infrastructure
  # It's the "chicken and egg" problem - we need somewhere to start
}


# S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-terraform-state-${var.environment}"

  lifecycle {
    prevent_destroy = true  # Don't accidentally delete state!
  }

  tags = {
    Name        = "Terraform State ${title(var.environment)}"
    Environment = var.environment
  }
}

# Enable versioning (can rollback state if needed)
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Encrypt state at rest
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access (state files contain secrets!)
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
