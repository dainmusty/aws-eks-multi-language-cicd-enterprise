provider "aws" {
  region = "us-east-1"
  #profile = "default"

}


provider "aws" {
  region = "ap-southeast-1"
  alias = "prod"
  #profile = "default"

}


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}