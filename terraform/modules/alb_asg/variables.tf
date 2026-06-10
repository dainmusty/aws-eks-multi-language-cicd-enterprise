variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "web_sg_id" {
  description = "Security group ID for EC2 instances"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type for launch template"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = ""
}

variable "launch_template_name" {
  description = "Name prefix for Launch Template"
  type        = string
  default     = "web-lt"
}

variable "asg_name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum ASG size"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum ASG size"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "Desired ASG capacity"
  type        = number
  default     = 2
}

variable "alb_name" {
  description = "Name of Application Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Target Group name"
  type        = string
}

variable "app_port" {
  description = "Port for application (EC2 and ALB)"
  type        = number
  default     = 3000
}

variable "alb_sg_id" {
  description = "List of security group IDs to associate with the ALB"
  type        = list(string)
}

variable "alb_type" {
  description = "Type of the Application Load Balancer"
  type        = string
   
}