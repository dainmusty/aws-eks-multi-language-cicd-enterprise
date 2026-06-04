# module "guardduty" {
#   source = "../../../modules/monitoring/guardduty"

#   enable_guardduty = true

#   finding_publishing_frequency = "FIFTEEN_MINUTES"

#   tags = {
#     Environment = "dev"
#     Project     = "multi-region-platform"
#     ManagedBy   = "Terraform"
#   }
# }
