variable "vpc_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "customer_gateway_ip" {
  type = string
}

variable "customer_gateway_asn" {
  type    = number
  default = 65000
}

variable "tags" {
  type    = map(string)
  default = {}
}