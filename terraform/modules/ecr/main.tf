resource "aws_ecr_repository" "app" {

  for_each = toset(var.service_names)

  name = "${var.project_name}/${each.value}"

  image_tag_mutability = var.environment == "dev" ? "MUTABLE" : "IMMUTABLE"

  force_delete = var.environment == "prod" ? false : true

  encryption_configuration {
    encryption_type = "KMS"
    kms_key        = var.kms_key_arn
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.tags, {
    Name        = each.value
    Environment = var.environment
  })
}

resource "aws_ecr_lifecycle_policy" "app" {

  for_each   = aws_ecr_repository.app
  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Remove untagged images older than 7 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = var.environment == "prod" ? "Keep last 50 images" : "Keep last 10 images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.environment == "prod" ? 50 : 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}