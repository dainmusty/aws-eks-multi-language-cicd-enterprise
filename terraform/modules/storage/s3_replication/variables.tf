variable "log_bucket_arn" {
  type = string
}

variable "log_bucket_id" {
  type = string
}

variable "replication_bucket_arn" {
  type = string
}

variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "s3_replication_role_arn" {
  type = string
  description = "Replication role arn"
}