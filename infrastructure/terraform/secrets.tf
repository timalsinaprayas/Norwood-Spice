# AWS Secrets Manager for Application Secrets
resource "aws_secretsmanager_secret" "app_secrets" {
  name                    = "norwoodspice/app-secrets"
  description             = "Application secrets for NorwoodSpice"
  kms_key_id              = aws_kms_key.main.id
  recovery_window_in_days = 30

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

resource "aws_secretsmanager_secret_version" "app_secrets" {
  secret_id = aws_secretsmanager_secret.app_secrets.id
  secret_string = jsonencode({
    DATABASE_URL      = "postgresql://${aws_db_instance.main.username}:${var.db_password}@${aws_db_instance.main.endpoint}/${aws_db_instance.main.db_name}"
    DATABASE_PASSWORD = var.db_password
    JWT_SECRET        = random_password.jwt_secret.result
    API_KEYS          = [random_password.api_key.result]
    ENCRYPTION_KEY    = random_password.encryption_key.result
  })
}

# Random passwords for secrets
resource "random_password" "jwt_secret" {
  length  = 64
  special = true
}

resource "random_password" "api_key" {
  length  = 32
  special = false
}

resource "random_password" "encryption_key" {
  length  = 32
  special = true
}

# IAM Policy for ECS Task to Access Secrets
resource "aws_iam_policy" "ecs_secrets_policy" {
  name        = "norwoodspice-ecs-secrets-policy"
  description = "Policy for ECS tasks to access application secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          aws_secretsmanager_secret.app_secrets.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt"
        ]
        Resource = [
          aws_kms_key.main.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_secrets_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_secrets_policy.arn
}

# GitHub OIDC Provider for Secure CI/CD
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/jwks"
}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}

# IAM Role for GitHub Actions
resource "aws_iam_role" "github_actions" {
  name = "norwoodspice-github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_repository}:*"
          }
        }
      }
    ]
  })
}

# IAM Policy for GitHub Actions
resource "aws_iam_policy" "github_actions_policy" {
  name        = "norwoodspice-github-actions-policy"
  description = "Policy for GitHub Actions CI/CD pipeline"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = [
          aws_ecr_repository.frontend.arn,
          aws_ecr_repository.backend.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ecs:UpdateService",
          "ecs:DescribeServices",
          "ecs:DescribeTasks",
          "ecs:DescribeTaskDefinition",
          "ecs:ListTasks"
        ]
        Resource = [
          aws_ecs_service.frontend.id,
          aws_ecs_service.backend.id,
          aws_ecs_cluster.main.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = [
          aws_iam_role.ecs_task_execution_role.arn
        ]
        Condition = {
          StringEquals = {
            "iam:PassedToService" = "ecs-tasks.amazonaws.com"
          }
        }
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.terraform_state.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_attachment" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}

# S3 Bucket for Terraform State (if not already created)
resource "aws_s3_bucket" "terraform_state" {
  bucket = "norwoodspice-terraform-state-${var.aws_account_id}"

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB Table for Terraform State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "norwoodspice-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

# Update main.tf backend configuration
# Note: This should be moved to a separate backend.tf file for bootstrapping
