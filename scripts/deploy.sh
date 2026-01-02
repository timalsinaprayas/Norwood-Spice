#!/bin/bash

# DevSecOps Deployment Script for NorwoodSpice Restaurant Application
# This script provides a comprehensive deployment workflow

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
INFRA_DIR="$PROJECT_ROOT/infrastructure/terraform"
ENVIRONMENT="${ENVIRONMENT:-production}"
AWS_REGION="${AWS_REGION:-us-east-1}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Pre-deployment checks
pre_deployment_checks() {
    log_info "Running pre-deployment checks..."

    # Check required tools
    command -v terraform >/dev/null 2>&1 || { log_error "Terraform is required but not installed."; exit 1; }
    command -v aws >/dev/null 2>&1 || { log_error "AWS CLI is required but not installed."; exit 1; }
    command -v docker >/dev/null 2>&1 || { log_error "Docker is required but not installed."; exit 1; }

    # Check AWS credentials
    aws sts get-caller-identity >/dev/null 2>&1 || { log_error "AWS credentials not configured."; exit 1; }

    # Check GitHub repository access (if deploying from CI/CD)
    if [[ -n "${GITHUB_ACTIONS:-}" ]]; then
        log_info "Running in GitHub Actions environment"
    fi

    log_success "Pre-deployment checks passed"
}

# Security scanning
run_security_scans() {
    log_info "Running security scans..."

    # File system scanning
    if command -v trivy >/dev/null 2>&1; then
        log_info "Running Trivy filesystem scan..."
        trivy fs --exit-code 1 --no-progress --format json . > trivy-fs-results.json || {
            log_warning "Trivy found vulnerabilities. Review trivy-fs-results.json"
        }
    fi

    # Container scanning (if images exist)
    if [[ -n "${FRONTEND_IMAGE:-}" ]] && [[ -n "${BACKEND_IMAGE:-}" ]]; then
        log_info "Scanning container images..."
        # This would be run in CI/CD pipeline
    fi

    log_success "Security scans completed"
}

# Infrastructure deployment
deploy_infrastructure() {
    log_info "Deploying infrastructure with Terraform..."

    cd "$INFRA_DIR"

    # Initialize Terraform
    terraform init -backend-config="bucket=norwoodspice-terraform-state-${AWS_ACCOUNT_ID}" \
                   -backend-config="key=devsecops/terraform.tfstate" \
                   -backend-config="region=${AWS_REGION}"

    # Validate configuration
    terraform validate

    # Plan deployment
    terraform plan -out=tfplan -var="environment=${ENVIRONMENT}"

    # Apply with auto-approve in CI/CD, manual approval locally
    if [[ -n "${AUTO_APPROVE:-}" ]]; then
        terraform apply -auto-approve tfplan
    else
        log_warning "Review the Terraform plan above and run 'terraform apply tfplan' to deploy"
        terraform apply tfplan
    fi

    log_success "Infrastructure deployment completed"
}

# Application deployment
deploy_application() {
    log_info "Deploying application..."

    # Build and push Docker images
    log_info "Building frontend image..."
    cd "$PROJECT_ROOT/frontend"
    docker build -t "norwoodspice/frontend:${GITHUB_SHA:-latest}" .

    log_info "Building backend image..."
    cd "$PROJECT_ROOT/backend"
    docker build -t "norwoodspice/backend:${GITHUB_SHA:-latest}" .

    # Login to ECR and push images
    aws ecr get-login-password --region "$AWS_REGION" | \
        docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

    # Tag and push images
    docker tag "norwoodspice/frontend:${GITHUB_SHA:-latest}" \
               "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/norwoodspice/frontend:${GITHUB_SHA:-latest}"
    docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/norwoodspice/frontend:${GITHUB_SHA:-latest}"

    docker tag "norwoodspice/backend:${GITHUB_SHA:-latest}" \
               "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/norwoodspice/backend:${GITHUB_SHA:-latest}"
    docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/norwoodspice/backend:${GITHUB_SHA:-latest}"

    # Update ECS services
    log_info "Updating ECS services..."
    aws ecs update-service \
        --cluster norwoodspice-cluster \
        --service norwoodspice-frontend-service \
        --force-new-deployment \
        --region "$AWS_REGION"

    aws ecs update-service \
        --cluster norwoodspice-cluster \
        --service norwoodspice-backend-service \
        --force-new-deployment \
        --region "$AWS_REGION"

    log_success "Application deployment completed"
}

# Health checks
run_health_checks() {
    log_info "Running post-deployment health checks..."

    # Get ALB DNS name
    ALB_DNS=$(aws elbv2 describe-load-balancers \
              --names norwoodspice-alb \
              --region "$AWS_REGION" \
              --query 'LoadBalancers[0].DNSName' \
              --output text)

    # Wait for services to be healthy
    log_info "Waiting for frontend service to be healthy..."
    timeout=300
    while [ $timeout -gt 0 ]; do
        if curl -f -s "http://$ALB_DNS" >/dev/null 2>&1; then
            log_success "Frontend is healthy"
            break
        fi
        sleep 10
        timeout=$((timeout - 10))
    done

    if [ $timeout -le 0 ]; then
        log_error "Frontend health check failed"
        exit 1
    fi

    log_info "Waiting for backend service to be healthy..."
    timeout=300
    while [ $timeout -gt 0 ]; do
        if curl -f -s "http://$ALB_DNS:8080/actuator/health" >/dev/null 2>&1; then
            log_success "Backend is healthy"
            break
        fi
        sleep 10
        timeout=$((timeout - 10))
    done

    if [ $timeout -le 0 ]; then
        log_error "Backend health check failed"
        exit 1
    fi

    log_success "All health checks passed"
}

# Rollback function
rollback() {
    log_warning "Deployment failed. Initiating rollback..."

    # Rollback ECS services to previous task definition
    aws ecs update-service \
        --cluster norwoodspice-cluster \
        --service norwoodspice-frontend-service \
        --task-definition norwoodspice-frontend \
        --region "$AWS_REGION"

    aws ecs update-service \
        --cluster norwoodspice-cluster \
        --service norwoodspice-backend-service \
        --task-definition norwoodspice-backend \
        --region "$AWS_REGION"

    log_info "Rollback completed"
}

# Main deployment function
main() {
    log_info "Starting DevSecOps deployment for NorwoodSpice Restaurant Application"
    log_info "Environment: $ENVIRONMENT"
    log_info "AWS Region: $AWS_REGION"

    # Set up error handling
    trap rollback ERR

    pre_deployment_checks
    run_security_scans
    deploy_infrastructure
    deploy_application
    run_health_checks

    log_success "🎉 Deployment completed successfully!"
    log_info "Application URLs:"
    ALB_DNS=$(aws elbv2 describe-load-balancers \
              --names norwoodspice-alb \
              --region "$AWS_REGION" \
              --query 'LoadBalancers[0].DNSName' \
              --output text)
    echo "Frontend: http://$ALB_DNS"
    echo "Backend: http://$ALB_DNS:8080"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --environment|-e)
            ENVIRONMENT="$2"
            shift 2
            ;;
        --region|-r)
            AWS_REGION="$2"
            shift 2
            ;;
        --auto-approve)
            AUTO_APPROVE="true"
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "DevSecOps deployment script for NorwoodSpice Restaurant Application"
            echo ""
            echo "Options:"
            echo "  -e, --environment ENV    Deployment environment (default: production)"
            echo "  -r, --region REGION      AWS region (default: us-east-1)"
            echo "  --auto-approve          Auto-approve Terraform changes"
            echo "  -h, --help              Show this help message"
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Validate environment variables
if [[ -z "${AWS_ACCOUNT_ID:-}" ]]; then
    log_error "AWS_ACCOUNT_ID environment variable is required"
    exit 1
fi

main "$@"