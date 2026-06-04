variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "allowed_cidrs" {
  type = list(string)
}

variable "cluster_role_arn" {
  type = string
}

variable "node_group_role_arn" {
  type = string
}

variable "cluster_policy_attachments" {
  type = any
}

variable "node_policy_attachments" {
  type = any
}

variable "capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "node_disk_size" {
  type    = number
  default = 50
}

variable "log_retention_days" {
  type    = number
  default = 30
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "key_arn" {
  type = string
}

variable "cloudwatch_log_group" {
  type = string
}