# DevSecOps Infrastructure for NorwoodSpice Restaurant Application

This directory contains the Infrastructure as Code (IaC) for deploying the NorwoodSpice restaurant application using DevSecOps principles.

## 🏗️ Architecture Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   GitHub Actions │    │   AWS ECR       │    │   AWS ECS       │
│   CI/CD Pipeline │───▶│   Container     │───▶│   Fargate       │
│                 │    │   Registry      │    │   Services      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Security      │    │   Monitoring    │    │   Alerting      │
│   Scanning      │    │   & Logging     │    │   & Response    │
│                 │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 📋 Prerequisites

### Required Tools
- **Terraform** >= 1.5.0
- **AWS CLI** >= 2.0
- **GitHub CLI** (optional)
- **Docker** (for local testing)

### AWS Requirements
- AWS Account with appropriate permissions
- IAM user or role with administrative access
- Route 53 hosted zone (for custom domain)

### GitHub Requirements
- GitHub repository with Actions enabled
- Repository secrets configured
- Branch protection rules

## 🚀 Quick Start

### 1. Clone and Initialize
```bash
git clone <your-repo-url>
cd restaurant-app/infrastructure/terraform

# Initialize Terraform
terraform init
```

### 2. Configure Variables
Create a `terraform.tfvars` file or set environment variables:

```hcl
aws_region       = "us-east-1"
environment      = "production"
aws_account_id   = "123456789012"
github_repository = "your-org/restaurant-app"
alert_email      = "alerts@yourcompany.com"
db_password      = "your-secure-db-password"
```

### 3. Plan and Apply
```bash
# Review the plan
terraform plan

# Apply the infrastructure
terraform apply
```

### 4. Configure GitHub Secrets
Set the following secrets in your GitHub repository:

```bash
# AWS Credentials
AWS_ACCESS_KEY_ID=your-aws-access-key
AWS_SECRET_ACCESS_KEY=your-aws-secret-key
AWS_REGION=us-east-1

# Terraform Cloud (optional)
TF_API_TOKEN=your-terraform-cloud-token
TF_ORG=your-terraform-org
TF_WORKSPACE=restaurant-app-prod
```

## 🔒 Security Features

### Infrastructure Security
- **VPC** with private/public subnets
- **Security Groups** with least privilege access
- **WAF** with OWASP Core Rule Set and SQL injection protection
- **AWS Config** for compliance monitoring
- **CloudTrail** for audit logging
- **GuardDuty** for threat detection
- **Security Hub** for centralized security findings

### Application Security
- **Container Scanning** with Trivy
- **Secret Management** with AWS Secrets Manager
- **KMS Encryption** for sensitive data
- **IAM Roles** with minimal required permissions
- **HTTPS Enforcement** via ALB

### CI/CD Security
- **GitHub OIDC** for secure AWS access
- **SAST/DAST** scanning with CodeQL
- **Dependency Scanning** with automated updates
- **Manual Approval** for production deployments
- **Branch Protection** rules

## 📊 Monitoring & Observability

### CloudWatch Dashboards
- ECS CPU/Memory utilization
- ALB request counts and error rates
- Application logs and metrics

### Alerting
- High CPU/Memory usage
- 5XX error spikes
- Unhealthy service instances
- Security incidents

### Distributed Tracing
- AWS X-Ray integration
- Request tracing across services

## 🔄 CI/CD Pipeline

### Stages
1. **Security Scan** - Trivy, CodeQL, Gitleaks
2. **Build & Test** - Maven, npm, Docker build
3. **Container Scan** - ECR image scanning
4. **Infrastructure Test** - Terraform validation, Checkov
5. **Deploy to Staging** - Automated deployment
6. **Deploy to Production** - Manual approval required

### Quality Gates
- **Test Coverage** > 80%
- **Security Scans** must pass
- **Linting** must pass
- **Build** must succeed

## 🛠️ Development Workflow

### Local Development
```bash
# Start local development environment
docker-compose up --build

# Run security scans locally
trivy fs .
docker run --rm -v $(pwd):/app aquasecurity/trivy image your-image:tag
```

### Infrastructure Changes
```bash
# Format and validate
terraform fmt
terraform validate

# Plan changes
terraform plan

# Apply with approval
terraform apply
```

### Security Testing
```bash
# Run security scans
npm audit
mvn dependency-check:check
trivy fs .
```

## 📋 Compliance & Standards

### Frameworks Supported
- **CIS AWS Foundations Benchmark**
- **OWASP Top 10**
- **PCI DSS** (partial)
- **SOC 2** (partial)

### Security Controls
- **Encryption at Rest**: KMS, S3 SSE
- **Encryption in Transit**: TLS 1.2+
- **Access Control**: IAM, Security Groups
- **Monitoring**: CloudWatch, CloudTrail
- **Incident Response**: Automated alerts

## 🆘 Troubleshooting

### Common Issues

#### Terraform State Lock
```bash
# Force unlock (use with caution)
terraform force-unlock LOCK_ID
```

#### ECR Authentication
```bash
# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
```

#### ECS Service Issues
```bash
# Check service status
aws ecs describe-services --cluster norwoodspice-cluster --services norwoodspice-backend-service

# View service logs
aws logs tail /ecs/norwoodspice/backend --follow
```

### Getting Help
- Check CloudWatch logs
- Review GitHub Actions logs
- Check AWS service health dashboard
- Review Terraform state

## 📚 Additional Resources

- [AWS ECS Documentation](https://docs.aws.amazon.com/ecs/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [GitHub Actions Security](https://docs.github.com/en/actions/security-guides)
- [OWASP DevSecOps Guidelines](https://owasp.org/www-project-devsecops-guideline/)

## 🤝 Contributing

1. Follow the security guidelines in `SECURITY.md`
2. Use the provided commit message format
3. Ensure all tests pass
4. Get security review for infrastructure changes
5. Update documentation for significant changes

---

**Note**: This infrastructure implements production-ready DevSecOps practices. Always review and test changes in a development environment before applying to production.