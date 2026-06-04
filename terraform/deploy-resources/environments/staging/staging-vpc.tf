module "dev_vpc" {
  source = "../../../modules/vpc"

  vpc_cidr             = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  public_subnet_cidr = ["10.1.1.0/24","10.1.2.0/24"]
  private_subnet_cidr = ["10.1.3.0/24","10.1.4.0/24"]
  availability_zones = ["us-east-1a","us-east-1b"]
  public_ip_on_launch = true
  PublicRT_cidr  = "0.0.0.0/0"
  PrivateRT_cidr = "0.0.0.0/0"

  #Tags
  project_name = "Startup"
  environment = "staging"
  cluster_name = "staging"

  # NEW — NAT behavior control
  nat_strategy = "single" # Options: "none", "single", "per_az"
  
}
