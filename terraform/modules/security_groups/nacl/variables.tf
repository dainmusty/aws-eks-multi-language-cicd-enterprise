variable "vpc_id" {
  description = "VPC ID where the NACL will be created"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets to associate with the NACL"
  type        = list(string)
}

variable "ingress_rules" {
  description = "Ingress NACL rules"
  type = list(object({
    rule_number = number
    protocol    = string
    rule_action = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
  default = []
}

variable "egress_rules" {
  description = "Egress NACL rules"
  type = list(object({
    rule_number = number
    protocol    = string
    rule_action = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
  default = []
}

variable "tags" {
  description = "Tags for the NACL"
  type        = map(string)
  default     = {}
}

