# # environments/shared/backend.tf
# terraform {
#   backend "s3" {
#     bucket         = "mycompany-terraform-state-shared"  # Shared bucket
#     key            = "infrastructure/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-lock-shared"  # Prevents concurrent applies
#   }
# }