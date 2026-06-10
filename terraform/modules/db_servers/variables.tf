variable "tier_name" {}

variable "instance_count" {
  type = number
}

variable "instance_type" {}

variable "ami_id" {}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "key_name" {}

variable "instance_profile_name" {}

variable "volume_size" {
  default = 20
}

variable "tags" {
  type = map(string)
}