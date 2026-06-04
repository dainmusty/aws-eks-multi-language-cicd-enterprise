# # Create state infrastructure for each environment
# cd terraform/bootstrap

# # Dev
# terraform apply -var="environment=dev"

# # Staging
# terraform apply -var="environment=staging"

# # Production
# terraform apply -var="environment=production"

# # You'll now have 3 S3 buckets and 3 DynamoDB tables

module "state_buckets" {

  source = "../../modules/s3/state_buckets"
  environment = var.environment
  project_name = var.project_name
  region = var.region

}
  








