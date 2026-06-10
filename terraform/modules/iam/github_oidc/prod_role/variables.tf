variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string
}

variable "create_oidc_provider" {
  description = "Create a GitHub OIDC provider in the account (true) or use existing (false)"
  type        = bool
  default     = false
}

variable "github_oidc_subjects" {
  description = <<EOF
List/map of OIDC subject patterns (token.actions.githubusercontent.com:sub).
Example: ["repo:org/repo:ref:refs/heads/main", "repo:org/*:ref:refs/tags/v*"]
EOF
  type    = list(string)
 
}

variable "managed_policy_arns" {
  description = "List of managed policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

variable "inline_policy_statements" {
  type = list(object({
    Sid      = string
    Effect   = string
    Action   = list(string)
    Resource = list(string)
  }))
}



variable "tags" {
  type    = map(string)
  default = {}
}
