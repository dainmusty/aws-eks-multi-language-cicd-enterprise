module "prod_vpn" {
  source = "../../modules/networking/vpn"

  vpc_id = module.prod_environment.vpc_id
  environment = "prod"

  customer_gateway_ip = "1.2.3.4" # Put your company's public IP here.

  tags = {
    Environment = "prod"
    Component   = "vpn"
  }
}

