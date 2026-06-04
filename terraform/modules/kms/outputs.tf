# EKS KMS Outputs
output "kms_arn" {
  value = aws_kms_key.eks.arn
}

output "kms_alias_name" {
  value = aws_kms_alias.eks.name
}

output "kms_alias_arn" {
  value = aws_kms_alias.eks.arn
}

# ECR KMS Outputs
output "ecr_kms_arn" {
  value = aws_kms_key.ecr.arn
}

output "ecr_kms_alias_name" {
  value = aws_kms_alias.ecr.name
}

output "ecr_kms_alias_arn" {
  value = aws_kms_alias.ecr.arn
}
