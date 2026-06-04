
# State bucket variables
variable "region" {
  default = "us-east-1"
}

variable "environment" {
  description = "dev, staging, or production"
}

variable "project_name" {
  description = "The name of the project for tagging purposes"
}


