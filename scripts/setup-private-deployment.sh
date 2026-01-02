#!/bin/bash

# Setup script for private AWS deployment accessible only from your computer

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
INFRA_DIR="$PROJECT_ROOT/infrastructure/terraform"
AWS_REGION="${AWS_REGION:-us-east-1}"

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

# Get public IP
get_public_ip() {
    log_info "Getting your public IP address..."
    PUBLIC_IP=$(curl -s https://api.ipify.org)
    if [[ -z "$PUBLIC_IP" ]]; then
        log_error "Could not determine your public IP. Please check your internet connection."
        exit 1
    fi
    log_success "Your public IP: $PUBLIC_IP"
    echo "$PUBLIC_IP/32"
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."

    # Check AWS CLI
    if ! command -v aws >/dev/null 2>&1; then
        log_error "AWS CLI is not installed. Please install it first: https://aws.amazon.com/cli/"
        exit 1
    fi

    # Check Terraform
    if ! command -v terraform >/dev/null 2>&1; then
        log_error "Terraform is not installed. Please install it first: https://www.terraform.io/downloads"
        exit 1
    fi

    # Check AWS credentials
    if ! aws sts get-caller-identity >/dev/null 2>&1; then
        log_error "AWS credentials are not configured. Please run 'aws configure'"
        exit 1
    fi

    log_success "Prerequisites check passed"
}

# Setup SSH key pair
setup_ssh_key() {
    log_info "Setting up SSH key pair for bastion host access..."

    KEY_NAME="norwoodspice-bastion-key"
    KEY_PATH="$HOME/.ssh/$KEY_NAME"

    if [[ -f "$KEY_PATH" ]]; then
        log_warning "SSH key already exists at $KEY_PATH"
        read -p "Do you want to overwrite it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Using existing key"
            return
        fi
    fi

    # Create SSH key
    mkdir -p "$HOME/.ssh"
    ssh-keygen -t rsa -b 2048 -f "$KEY_PATH" -N "" -C "norwoodspice-bastion"

    # Create key pair in AWS
    aws ec2 import-key-pair \
        --key-name "$KEY_NAME" \
        --public-key-material "file://$KEY_PATH.pub" \
        --region "$AWS_REGION"

    log_success "SSH key pair created: $KEY_PATH"
    log_warning "Keep your private key secure: $KEY_PATH"
    log_info "To connect to bastion: ssh -i $KEY_PATH ec2-user@BASTION_IP"
}

# Create Terraform variables file
create_tfvars() {
    local public_ip="$1"
    local key_name="$2"

    log_info "Creating terraform.tfvars file..."

    cat > "$INFRA_DIR/terraform.tfvars" << EOF
aws_region = "$AWS_REGION"
environment = "development"
project_name = "norwoodspice"

frontend_cpu = 256
frontend_memory = 512
backend_cpu = 512
backend_memory = 1024

desired_count_frontend = 1
desired_count_backend = 1

# Security: Only allow access from your IP
allowed_ips = ["$public_ip"]

# SSH key for bastion host
key_pair_name = "$key_name"

# Note: aws_account_id will be set via environment variable
# Note: db_password should be set securely via AWS Secrets Manager in production
EOF

    log_success "Created terraform.tfvars file"
}

# Main setup function
main() {
    log_info "Setting up private AWS deployment for NorwoodSpice Restaurant Application"
    log_info "This will create resources accessible only from your computer"

    check_prerequisites

    # Get user's public IP
    PUBLIC_IP_CIDR=$(get_public_ip)

    # Setup SSH key
    setup_ssh_key
    KEY_NAME="norwoodspice-bastion-key"

    # Create Terraform configuration
    create_tfvars "$PUBLIC_IP_CIDR" "$KEY_NAME"

    # Get AWS account ID
    AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    export AWS_ACCOUNT_ID

    log_success "Setup completed!"
    log_info ""
    log_info "Next steps:"
    echo "1. Review and update the terraform.tfvars file if needed"
    echo "2. Run: cd infrastructure/terraform && terraform init"
    echo "3. Run: terraform plan"
    echo "4. Run: terraform apply"
    echo "5. After deployment, get the bastion IP: terraform output bastion_public_ip"
    echo "6. Connect to bastion: ssh -i ~/.ssh/norwoodspice-bastion-key ec2-user@BASTION_IP"
    echo "7. From bastion, access your app using the internal ALB DNS name"
    log_info ""
    log_warning "Your application will only be accessible from IP: ${PUBLIC_IP_CIDR%/*}"
    log_warning "Keep your SSH private key secure!"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --region|-r)
            AWS_REGION="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Setup script for private AWS deployment"
            echo ""
            echo "Options:"
            echo "  -r, --region REGION    AWS region (default: us-east-1)"
            echo "  -h, --help             Show this help message"
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            exit 1
            ;;
    esac
done

main "$@"
