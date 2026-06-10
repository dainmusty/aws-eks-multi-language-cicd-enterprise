variable "requester_vpc_id" {
  description = "VPC ID initiating the peering request"
  type        = string
}

variable "accepter_vpc_id" {
  description = "VPC ID accepting the peering request"
  type        = string
}

variable "requester_region" {
  description = "AWS region of requester VPC"
  type        = string
}

variable "accepter_region" {
  description = "AWS region of accepter VPC"
  type        = string
}

variable "requester_route_table_ids" {
  description = "Route tables in requester VPC"
  type        = list(string)
}

variable "accepter_route_table_ids" {
  description = "Route tables in accepter VPC"
  type        = list(string)
}

variable "requester_cidr_block" {
  description = "CIDR block of requester VPC"
  type        = string
}

variable "accepter_cidr_block" {
  description = "CIDR block of accepter VPC"
  type        = string
}

variable "auto_accept" {
  description = "Automatically accept peering request"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
