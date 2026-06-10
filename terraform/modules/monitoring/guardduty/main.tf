resource "aws_guardduty_detector" "guardduty" {
  enable = var.enable_guardduty

  finding_publishing_frequency = var.finding_publishing_frequency

  tags = var.tags
}

############################################################
# OPTIONAL — S3 Protection (Best Practice)
############################################################

resource "aws_guardduty_detector_feature" "s3_protection" {
  detector_id = aws_guardduty_detector.guardduty.id

  name   = "S3_DATA_EVENTS"
  status = "ENABLED"
}

############################################################
# OPTIONAL — EKS Protection (Future-Proof)
############################################################

resource "aws_guardduty_detector_feature" "eks_protection" {
  detector_id = aws_guardduty_detector.guardduty.id

  name   = "EKS_AUDIT_LOGS"
  status = "ENABLED"
}

############################################################
# OPTIONAL — Malware Protection for EC2 (New AWS Feature)
############################################################

resource "aws_guardduty_detector_feature" "malware_protection" {
  detector_id = aws_guardduty_detector.guardduty.id

  name   = "EBS_MALWARE_PROTECTION"
  status = "ENABLED"
}
 