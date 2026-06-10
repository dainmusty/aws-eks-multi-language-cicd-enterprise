resource "aws_kms_key" "ecr" {
  description         = "ECR encryption key for ${var.project_name}-${var.environment}"
  enable_key_rotation = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-ecr-key-${var.environment}"
  })
}

resource "aws_kms_alias" "ecr" {
  name          = "alias/${var.project_name}-ecr-${var.environment}"
  target_key_id = aws_kms_key.ecr.key_id
}