# Application Insights and Monitoring
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "norwoodspice-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ClusterName", aws_ecs_cluster.main.name, "ServiceName", aws_ecs_service.frontend.name],
            [".", ".", ".", ".", "ServiceName", aws_ecs_service.backend.name]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "ECS CPU Utilization"
          period  = 300
          stat    = "Average"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ECS", "MemoryUtilization", "ClusterName", aws_ecs_cluster.main.name, "ServiceName", aws_ecs_service.frontend.name],
            [".", ".", ".", ".", "ServiceName", aws_ecs_service.backend.name]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "ECS Memory Utilization"
          period  = 300
          stat    = "Average"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", aws_lb.main.arn_suffix]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "ALB Request Count"
          period  = 300
          stat    = "Sum"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_Target_5XX_Count", "LoadBalancer", aws_lb.main.arn_suffix],
            [".", "HTTPCode_Target_4XX_Count", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "ALB Error Rates"
          period  = 300
          stat    = "Sum"
        }
      },
      {
        type   = "log"
        x      = 0
        y      = 12
        width  = 24
        height = 6

        properties = {
          query = "SOURCE '${aws_cloudwatch_log_group.backend.name}' | fields @timestamp, @message | sort @timestamp desc | limit 100"
          region = var.aws_region
          title  = "Recent Backend Logs"
        }
      }
    ]
  })
}

# X-Ray for Distributed Tracing
resource "aws_xray_sampling_rule" "main" {
  rule_name      = "norwoodspice-sampling"
  priority       = 100
  version        = 1
  reservoir_size = 1
  fixed_rate     = 0.1
  url_path       = "*"
  host           = "*"
  http_method    = "*"
  service_type   = "*"
  service_name   = "*"

  attributes = {
    environment = var.environment
  }
}

# Application Auto Scaling
resource "aws_appautoscaling_target" "frontend" {
  max_capacity       = 10
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.frontend.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "frontend_cpu" {
  name               = "frontend-cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.frontend.resource_id
  scalable_dimension = aws_appautoscaling_target.frontend.scalable_dimension
  service_namespace  = aws_appautoscaling_target.frontend.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 70.0
  }
}

resource "aws_appautoscaling_policy" "frontend_memory" {
  name               = "frontend-memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.frontend.resource_id
  scalable_dimension = aws_appautoscaling_target.frontend.scalable_dimension
  service_namespace  = aws_appautoscaling_target.frontend.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 80.0
  }
}

resource "aws_appautoscaling_target" "backend" {
  max_capacity       = 5
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.backend.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "backend_cpu" {
  name               = "backend-cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.backend.resource_id
  scalable_dimension = aws_appautoscaling_target.backend.scalable_dimension
  service_namespace  = aws_appautoscaling_target.backend.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 70.0
  }
}

# Performance Insights for RDS (if using RDS)
# resource "aws_db_instance" "main" {
#   # ... RDS configuration ...
#   performance_insights_enabled = true
#   performance_insights_kms_key_id = aws_kms_key.main.arn
# }

# CloudWatch Synthetics for Endpoint Monitoring
resource "aws_synthetics_canary" "frontend" {
  name                 = "norwoodspice-frontend-check"
  artifact_s3_location = "s3://${aws_s3_bucket.canary_bucket.bucket}/canary/"
  execution_role_arn   = aws_iam_role.canary_role.arn
  handler              = "frontendCheck.handler"
  runtime_version      = "syn-nodejs-puppeteer-3.9"
  start_canary         = true

  schedule {
    expression = "rate(5 minutes)"
  }

  run_config {
    timeout_in_seconds = 60
  }

  zip_file = data.archive_file.canary_zip.output_path

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

# IAM Role for Synthetics Canary
resource "aws_iam_role" "canary_role" {
  name = "norwoodspice-canary-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "canary_policy" {
  role       = aws_iam_role.canary_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/CloudWatchSyntheticsFullAccess"
}

# S3 Bucket for Canary Artifacts
resource "aws_s3_bucket" "canary_bucket" {
  bucket = "norwoodspice-canary-${var.aws_account_id}-${var.aws_region}"

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

# Data source for canary script (placeholder)
data "archive_file" "canary_zip" {
  type        = "zip"
  output_path = "${path.module}/canary.zip"

  source {
    content  = <<EOF
const synthetics = require('Synthetics');
const log = require('SyntheticsLogger');

const pageLoadBlueprint = async function () {

    const urls = ['${aws_lb.main.dns_name}'];

    for (const url of urls) {
        await synthetics.executeStep(`Navigate to ${url}`, async function () {
            const page = await synthetics.getPage();
            await page.goto(url, { waitUntil: 'networkidle0', timeout: 30000 });
        });
    }
};

exports.handler = async () => {
    return await pageLoadBlueprint();
};
EOF
    filename = "frontendCheck.js"
  }
}

# Additional CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "alb_5xx_errors" {
  alarm_name          = "norwoodspice-alb-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "This metric monitors ALB 5XX errors"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = aws_lb.main.arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_service_unhealthy" {
  alarm_name          = "norwoodspice-ecs-unhealthy"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors unhealthy ECS service instances"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    TargetGroup  = aws_lb_target_group.backend.arn_suffix
    LoadBalancer = aws_lb.main.arn_suffix
  }
}

# SNS Topic for Alerts
resource "aws_sns_topic" "alerts" {
  name = "norwoodspice-alerts"

  tags = {
    Environment = var.environment
    Project     = "NorwoodSpice"
  }
}

# SNS Topic Subscription (email)
resource "aws_sns_topic_subscription" "alerts_email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
