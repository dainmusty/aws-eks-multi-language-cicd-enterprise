variable "environment" {
  type        = string
  description = "Prefix for resource naming"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where security group will be created"
}

variable "db_sg_ingress_rules" {
  description = "List of ingress rules for DB security group"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    description     = optional(string)
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))

}

variable "db_sg_egress_rules" {
  description = "List of egress rules for ALB security group"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    description     = optional(string)
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
  
}

variable "db_sg_tags" {
  description = "Additional tags for the DB security group"
  type        = map(string)
  default     = {}
}

variable "cache_source_sg" {
  description = "List of security group IDs allowed to access ElastiCache"
  type        = list(string)
  default     = []
}
