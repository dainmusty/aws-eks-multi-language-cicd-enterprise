module "ecr" {
  source = "../../../modules/ecr"

  environment = "dev"
  project_name = "mycompany"
  service_names = ["javascript-api", "java-service", "rust-processor"]
  kms_key_arn = module.kms.ecr_kms_arn

  tags = {
    Environment = "dev"
    Project     = "mycompany"
  }
  
}



