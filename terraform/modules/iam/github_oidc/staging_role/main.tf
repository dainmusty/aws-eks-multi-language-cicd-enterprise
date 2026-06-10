# terraform/modules/github-oidc/main.tf

data "aws_caller_identity" "current" {}

##############################
# Create or use existing OIDC provider
##############################
resource "aws_iam_openid_connect_provider" "github" {
  count = var.create_oidc_provider ? 1 : 0

  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  tags = var.tags
}



# Build the subject pattern list: use provided or fallback to wildcard
locals {
  oidc_subjects = length(var.github_oidc_subjects) > 0 ? var.github_oidc_subjects : ["repo:*/*:*"]
}



# Staging role: Moderately permissive, allow feature branches
resource "aws_iam_role" "github_actions_staging" {
  name = "GitHubActionsRole-Staging"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.create_oidc_provider ? aws_iam_openid_connect_provider.github[0].arn : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        }
        StringLike = {
          # Allow all branches to deploy to dev
          "token.actions.githubusercontent.com:sub" = "repo:yourcompany/infrastructure:*"
        }
      }
    }]
  })
  tags = var.tags
}


# -------------------------
# Inline policies (map -> for_each)
# For each entry in inline_policies, create a policy and attach it
# -------------------------
resource "aws_iam_policy" "inline" {
  name = "${var.role_name}-policy"

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      for key, st in var.inline_policy_statements :
      {
        Sid      = st.Sid
        Effect   = st.Effect
        Action   = st.Action
        Resource = st.Resource
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "attach_inline" {
  role       = aws_iam_role.github_actions_staging.name
  policy_arn = aws_iam_policy.inline.arn
}


# -------------------------
# Managed policy attachments
# -------------------------
resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.github_actions_staging.name
  policy_arn = each.key
}
