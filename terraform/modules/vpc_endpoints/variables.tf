########################
# VPC Endpoint Variables
########################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "service_name" {
  description = "AWS service name (e.g. com.amazonaws.region.s3)"
  type        = string
}

variable "endpoint_type" {
  description = "Gateway or Interface"
  type        = string
}

variable "route_table_ids" {
  description = "Route tables for Gateway endpoint"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Subnets for Interface endpoint"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "Security groups for Interface endpoint"
  type        = list(string)
  default     = []
}

variable "private_dns_enabled" {
  description = "Enable private DNS"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
