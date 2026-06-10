output "guardduty_detector_id" {
  description = "GuardDuty detector ID"
  value       = aws_guardduty_detector.guardduty.id
}

output "guardduty_enabled" {
  description = "GuardDuty enabled status"
  value       = aws_guardduty_detector.guardduty.enable
}
