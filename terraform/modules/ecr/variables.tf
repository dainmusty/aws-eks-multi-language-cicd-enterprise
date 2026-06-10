variable "service_names" {
  type        = list(string)
  description = "List of microservices to create ECR repositories for"
}

variable "project_name" {
  type        = string
}

variable "environment" {
  type        = string
  description = "dev | staging | prod"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of the KMS key to use for encrypting ECR images"
}