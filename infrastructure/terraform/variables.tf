variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "norwoodspice"
}

variable "frontend_cpu" {
  description = "CPU units for frontend task"
  type        = number
  default     = 256
}

variable "frontend_memory" {
  description = "Memory for frontend task"
  type        = number
  default     = 512
}

variable "backend_cpu" {
  description = "CPU units for backend task"
  type        = number
  default     = 512
}

variable "backend_memory" {
  description = "Memory for backend task"
  type        = number
  default     = 1024
}

variable "desired_count_frontend" {
  description = "Desired number of frontend tasks"
  type        = number
  default     = 2
}

variable "desired_count_backend" {
  description = "Desired number of backend tasks"
  type        = number
  default     = 1
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "db_password" {
  description = "Database password for the application"
  type        = string
  sensitive   = true
}

variable "alert_email" {
  description = "Email address for receiving alerts"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository for OIDC provider (format: owner/repo)"
  type        = string
}
