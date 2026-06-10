
output "cloudtrail_arn" {
  description = "CloudTrail ARN"
  value       = aws_cloudtrail.cloudtrail.arn
}

output "cloudtrail_id" {
  description = "CloudTrail ID"
  value       = aws_cloudtrail.cloudtrail.id
}