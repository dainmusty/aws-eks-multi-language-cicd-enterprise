##############################
# README (quick start)
##############################
# Quick start
# 1. Create a separate repository/folder for bootstrap resources (this module).
# 2. Run `terraform init` and `terraform apply` in the bootstrap repo as an administrator.
# 3. Note the output.role_arn and add it to your GitHub Actions workflow as the assume role.
#
# Using the role in GitHub Actions:
# - Ensure the workflow has permissions.id-token: write
# - Add a repository secret AWS_ACCOUNT_ID containing your numeric AWS account id
# - Use aws-actions/configure-aws-credentials to assume the role:
#
# with:
#   role-to-assume: arn:aws:iam::${{ secrets.AWS_ACCOUNT_ID }}:role/role-name-from-output
#   role-session-name: GitHubActions-Terraform-Run-${{ github.run_id }}
#   aws-region: us-east-1
#
# Security notes
# - The AWS account id is not secret but we recommend keeping it in a repo secret if you prefer not to expose it in pipeline logs.
# - After bootstrap, avoid destroying these resources unless you intend to retire the pipeline.

 # Command examples to individual roles:
 # tf plan -target=module.data_analytics_role
# tf apply --auto-approve -target=module.data_analytics_role
# tf destroy --auto-approve -target=module.data_analytics_role

# tf plan -target=module.multi_tgw_role
# tf apply --auto-approve -target=module.multi_tgw_role
# tf destroy --auto-approve -target=module.multi_tgw_role

# tf plan -target=module.enterprise_infra_role
# tf apply --auto-approve -target=module.enterprise_infra_role
# tf destroy --auto-approve -target=module.enterprise_infra_role
# tam module.microservices_project_tf_role

# inline policy statements are expected to be a flat list of statements, not a full JSON policy with "Version" and "Statement" blocks.



module "gitactions_dev_role" {

  source = "../../modules/iam/github_oidc/dev_role"

  role_name           = "gitactions-dev-role"
  create_oidc_provider = false

  github_oidc_subjects = [
    "repo:dainmusty/terraform-aws-serverless-platform:*" #update with dev repo
  ]

  inline_policy_statements = [

    #########################################
    # VPC / Networking
    #########################################
    {
      Sid    = "AllowVPC"
      Effect = "Allow"

      Action = [
        "ec2:CreateVpc",
        "ec2:DeleteVpc",
        "ec2:DescribeVpcs",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeRouteTables",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeAvailabilityZones"
      ]

      Resource = ["*"]
    },

    #########################################
    # S3
    #########################################
    {
      Sid    = "AllowS3Logging"
      Effect = "Allow"

      Action = [
        "s3:CreateBucket",
        "s3:DeleteBucket",
        "s3:PutBucketPolicy",
        "s3:GetBucketPolicy",
        "s3:PutBucketTagging",
        "s3:GetBucketTagging",
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ]

      Resource = [
        "arn:aws:s3:::mustydain",
        "arn:aws:s3:::mustydain/*"
      ]
    },

    #########################################
    # DynamoDB
    #########################################
    {
  Sid    = "AllowDynamoDB"
  Effect = "Allow"

  Action = [
    "dynamodb:CreateTable",
    "dynamodb:DeleteTable",
    "dynamodb:DescribeTable",
    "dynamodb:DescribeContinuousBackups",
    "dynamodb:UpdateTable",
    "dynamodb:TagResource",
    "dynamodb:UntagResource",
    "dynamodb:GetItem",
    "dynamodb:PutItem",
    "dynamodb:UpdateItem",
    "dynamodb:DeleteItem",
    "dynamodb:Scan",
    "dynamodb:Query",
    "dynamodb:DescribeTimeToLive",
    "dynamodb:ListTagsOfResource"
  ]

  Resource = ["*"]
},

    #########################################
    # Lambda
    #########################################
    {
      Sid    = "AllowLambda"
      Effect = "Allow"

      Action = [
        "lambda:CreateFunction",
        "lambda:DeleteFunction",
        "lambda:GetFunction",
        "lambda:UpdateFunctionCode",
        "lambda:UpdateFunctionConfiguration",
        "lambda:AddPermission",
        "lambda:RemovePermission",
        "lambda:TagResource",
        "lambda:UntagResource",
        "lambda:InvokeFunction",
        "lambda:PublishVersion",
        "lambda:ListVersionsByFunction",
        "lambda:ListVersionsByFunction",
        "lambda:GetFunctionCodeSigningConfig",
        "lambda:GetFunctionCodeSigningConfig",
        "lambda:GetPolicy"
      ]

      Resource = ["*"]
    },

    #########################################
    # IAM
    #########################################
    {
  Sid    = "AllowIAM"
  Effect = "Allow"

  Action = [
    "iam:CreateRole",
    "iam:DeleteRole",
    "iam:GetRole",
    "iam:ListRolePolicies",
    "iam:ListAttachedRolePolicies",
    "iam:PassRole",
    "iam:AttachRolePolicy",
    "iam:DetachRolePolicy",
    "iam:PutRolePolicy",
    "iam:DeleteRolePolicy",
    "iam:TagRole",
    "iam:UntagRole",
    "iam:ListInstanceProfilesForRole",
    "iam:CreatePolicy",
    "iam:DeletePolicy",
    "iam:GetPolicy",
    "iam:TagPolicy",
    "iam:GetPolicyVersion",
    "iam:ListPolicyVersions",
    "iam:CreatePolicyVersion"
  ]

  Resource = ["*"]
},

    #########################################
    # CloudWatch Logs
    #########################################
    {
      Sid    = "AllowCloudWatchLogs"
      Effect = "Allow"

      Action = [
        "logs:CreateLogGroup",
        "logs:DeleteLogGroup",
        "logs:CreateLogStream",
        "logs:DeleteLogStream",
        "logs:PutLogEvents",
        "logs:TagResource",
        "logs:PutRetentionPolicy",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:ListTagsForResource"
        
      ]

      Resource = ["*"]
    },

    #########################################
    # API Gateway
    #########################################
    {
      Sid    = "AllowAPIGateway"
      Effect = "Allow"

      Action = [
        "apigateway:POST",
        "apigateway:GET",
        "apigateway:PUT",
        "apigateway:DELETE",
        "apigateway:PATCH",
        "apigateway:TagResource"
      ]

      Resource = ["*"]
    },

    #########################################
    # Amplify
    #########################################
    {
      Sid    = "AllowAmplify"
      Effect = "Allow"

      Action = [
        "amplify:CreateApp",
        "amplify:DeleteApp",
        "amplify:GetApp",
        "amplify:UpdateApp",
        "amplify:CreateBranch",
        "amplify:DeleteBranch",
        "amplify:GetBranch",
        "amplify:UpdateBranch",
        "amplify:StartJob",
        "amplify:StopJob",
        "amplify:TagResource",
        "amplify:UntagResource"
      ]

      Resource = ["*"]
    }
  ]

  tags = {
    Project = "enterprise-infra"
    Owner   = "effulgencetech"
  }
}








