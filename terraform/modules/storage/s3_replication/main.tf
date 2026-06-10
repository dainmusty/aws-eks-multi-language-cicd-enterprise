resource "aws_s3_bucket_replication_configuration" "replication" {
  
  role   = var.s3_replication_role_arn
  bucket = var.log_bucket_id

  rule {
    id     = "replication-rule"
    status = "Enabled"

    destination {
      bucket        = var.replication_bucket_arn
      storage_class = "STANDARD"
    }
  }
}