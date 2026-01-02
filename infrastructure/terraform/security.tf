# Security Groups with Enhanced Rules
resource "aws_security_group" "database" {
  name_prefix = "norwoodspice-db-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "PostgreSQL from ECS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

# AWS Config Rules for Compliance
resource "aws_config_config_rule" "s3_bucket_versioning" {
  name = "s3-bucket-versioning-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "ec2_encrypted_volumes" {
  name = "ec2-volumes-must-be-encrypted"

  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "root_mfa" {
  name = "root-account-mfa-enabled"

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.main]
}

# AWS Config Recorder
resource "aws_config_configuration_recorder" "main" {
  name     = "norwoodspice-config-recorder"
  role_arn = aws_iam_role.config_role.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = "norwoodspice-config-delivery"
  s3_bucket_name = aws_s3_bucket.config_bucket.bucket
  s3_key_prefix  = "config"
  depends_on     = [aws_config_configuration_recorder.main]
}

# IAM Role for AWS Config
resource "aws_iam_role" "config_role" {
  name = "norwoodspice-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "config_policy" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

# S3 Bucket for Config Logs
resource "aws_s3_bucket" "config_bucket" {
  bucket = "norwoodspice-config-${var.aws_account_id}-${var.aws_region}"

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

resource "aws_s3_bucket_versioning" "config_bucket" {
  bucket = aws_s3_bucket.config_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "config_bucket" {
  bucket = aws_s3_bucket.config_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "config_bucket" {
  bucket = aws_s3_bucket.config_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# CloudTrail for Audit Logging
resource "aws_cloudtrail" "main" {
  name                          = "norwoodspice-trail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.id
  s3_key_prefix                 = "cloudtrail"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "norwoodspice-cloudtrail-${var.aws_account_id}-${var.aws_region}"

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AWSCloudTrailAclCheck"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.cloudtrail_bucket.arn
      },
      {
        Sid    = "AWSCloudTrailWrite"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.cloudtrail_bucket.arn}/cloudtrail/AWSLogs/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

# GuardDuty for Threat Detection
resource "aws_guardduty_detector" "main" {
  enable = true

  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = false
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = true
        }
      }
    }
  }

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

# Security Hub for Centralized Security Findings
resource "aws_securityhub_account" "main" {}

resource "aws_securityhub_standards_subscription" "cis" {
  standards_arn = "arn:aws:securityhub:${var.aws_region}::standards/cis-aws-foundations-benchmark/v/1.4.0"
  depends_on    = [aws_securityhub_account.main]
}

resource "aws_securityhub_standards_subscription" "pci_dss" {
  standards_arn = "arn:aws:securityhub:${var.aws_region}::standards/pci-dss/v/3.2.1"
  depends_on    = [aws_securityhub_account.main]
}

# AWS Systems Manager Parameter Store for Secrets
resource "aws_ssm_parameter" "db_password" {
  name        = "/norwoodspice/${var.environment}/db/password"
  description = "Database password for NorwoodSpice application"
  type        = "SecureString"
  value       = var.db_password

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

# KMS Key for Encryption
resource "aws_kms_key" "main" {
  description             = "KMS key for NorwoodSpice application"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.aws_account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow CloudWatch Logs"
        Effect = "Allow"
        Principal = {
          Service = "logs.${var.aws_region}.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
        Condition = {
          ArnEquals = {
            "kms:EncryptionContext:aws:logs:arn" = "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:log-group:*"
          }
        }
      }
    ]
  })

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

# Additional CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "unauthorized_api_calls" {
  alarm_name          = "norwoodspice-unauthorized-api-calls"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "UnauthorizedAttemptCount"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors unauthorized API calls"
  alarm_actions       = [aws_sns_topic.security_alerts.arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
  }
}

# SNS Topic for Security Alerts
resource "aws_sns_topic" "security_alerts" {
  name = "norwoodspice-security-alerts"

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

# Route 53 Health Checks
resource "aws_route53_health_check" "frontend" {
  fqdn              = aws_lb.main.dns_name
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "3"
  request_interval  = "30"

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

resource "aws_route53_health_check" "backend" {
  fqdn              = aws_lb.main.dns_name
  port              = 8080
  type              = "HTTP"
  resource_path     = "/actuator/health"
  failure_threshold = "3"
  request_interval  = "30"

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}
