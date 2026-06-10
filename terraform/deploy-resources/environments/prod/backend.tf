# # environments/production/backend.tf
# terraform {
#   backend "s3" {
#     bucket         = "mycompany-terraform-state-prod"  # Production-only bucket
#     key            = "infrastructure/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-lock-prod"  # Prevents concurrent applies
#   }
# }