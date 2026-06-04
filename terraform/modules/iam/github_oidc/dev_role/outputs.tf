output "gitactions_dev_role_arn" {
  value = aws_iam_role.github_actions_dev.arn
  description = "Use this in GitHub Actions: role-to-assume"
}