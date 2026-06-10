module "dev_environment" {
  source = "../../environments/dev"
}

module "uat_environment" {
  source = "../../environments/uat"
}

module "prod_environment" {
  source = "../../environments/prod"
}

