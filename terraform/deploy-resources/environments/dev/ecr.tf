# module "ecr" {
#   source = "../../../modules/ecr"

#   environment = "dev"
#   project_name = "microservices-platform"
#   service_names = ["javascript-api", "java-service", "rust-processor"]
#   kms_key_arn = module.kms.ecr_kms_arn

#   tags = {
#     Environment = "dev"
#     Project     = "microservices-platform"
#   }
  
# }



