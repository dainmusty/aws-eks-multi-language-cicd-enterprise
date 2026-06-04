variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "environment" {
  type        = string
  description = "Prefix for environment"
}


variable "description" {
  type        = string
  default     = "monitoring security group"
}

variable "monitoring_ingress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    description              = string
    cidr_blocks              = optional(list(string))
    source_security_group_ids = optional(list(string))
  }))
  default = []
}

variable "monitoring_egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "monitoring_sg_tags" {
  description = "Additional tags for the monitoring security group"
  type        = map(string)
  default     = {}
  
}

