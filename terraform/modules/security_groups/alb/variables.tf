variable "environment" {
  type        = string
  description = "Prefix for resource naming"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where security group will be created"
}

variable "alb_sg_ingress_rules" {
  description = "List of ingress rules for ALB security group"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    description     = optional(string)
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))

}

variable "alb_sg_egress_rules" {
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

variable "alb_sg_tags" {
  description = "Additional tags for the ALB security group"
  type        = map(string)
  default     = {}
}
