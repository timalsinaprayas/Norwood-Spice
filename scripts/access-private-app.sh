#!/bin/bash

# Script to access privately deployed NorwoodSpice application

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
AWS_REGION="${AWS_REGION:-us-east-2}"

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

# Get deployment outputs
get_outputs() {
    log_info "Getting deployment information..."

    cd "$INFRA_DIR"

    # Check if terraform state exists
    if [[ ! -f ".terraform/terraform.tfstate" ]]; then
        log_error "Terraform state not found. Have you deployed the infrastructure?"
        log_info "Run: ./scripts/setup-private-deployment.sh && cd infrastructure/terraform && terraform apply"
        exit 1
    fi

    # Get outputs
    BASTION_IP=$(terraform output -raw bastion_public_ip 2>/dev/null || echo "")
    ALB_DNS=$(terraform output -raw alb_dns_name 2>/dev/null || echo "")

    if [[ -z "$BASTION_IP" ]] || [[ -z "$ALB_DNS" ]]; then
        log_error "Could not get deployment outputs. Make sure deployment completed successfully."
        exit 1
    fi

    log_success "Bastion IP: $BASTION_IP"
    log_success "ALB DNS: $ALB_DNS"
}

# Test connectivity
test_connectivity() {
    local bastion_ip="$1"

    log_info "Testing connectivity to bastion host..."

    if ! ping -c 3 "$bastion_ip" >/dev/null 2>&1; then
        log_error "Cannot reach bastion host at $bastion_ip"
        log_info "Make sure:"
        echo "1. The deployment completed successfully"
        echo "2. Your IP address hasn't changed (run setup script again if it did)"
        echo "3. Security groups are configured correctly"
        exit 1
    fi

    log_success "Bastion host is reachable"
}

# Setup SSH tunnel
setup_ssh_tunnel() {
    local bastion_ip="$1"
    local alb_dns="$2"

    log_info "Setting up SSH tunnel to access the application..."

    # Check if SSH key exists
    SSH_KEY="$HOME/.ssh/norwoodspice-bastion-key"
    if [[ ! -f "$SSH_KEY" ]]; then
        log_error "SSH key not found at $SSH_KEY"
        log_info "Run the setup script first: ./scripts/setup-private-deployment.sh"
        exit 1
    fi

    # Kill any existing tunnels
    pkill -f "ssh.*$bastion_ip.*8080\|ssh.*$bastion_ip.*3000" || true

    log_info "Creating SSH tunnels..."
    log_info "Frontend (port 3000) -> http://localhost:3000"
    log_info "Backend (port 8080) -> http://localhost:8080"

    # Create SSH tunnel for both ports
    ssh -i "$SSH_KEY" \
        -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -N \
        -L 3000:"$alb_dns":80 \
        -L 8080:"$alb_dns":8080 \
        ec2-user@"$bastion_ip" &

    # Wait for tunnel to establish
    sleep 3

    # Test tunnels
    if curl -s --max-time 5 http://localhost:3000 >/dev/null 2>&1; then
        log_success "Frontend tunnel established: http://localhost:3000"
    else
        log_error "Frontend tunnel failed"
    fi

    if curl -s --max-time 5 http://localhost:8080/actuator/health >/dev/null 2>&1; then
        log_success "Backend tunnel established: http://localhost:8080"
    else
        log_error "Backend tunnel failed"
    fi

    log_info ""
    log_success "SSH tunnels are active!"
    log_info "You can now access your application at:"
    echo "  Frontend: http://localhost:3000"
    echo "  Backend:  http://localhost:8080"
    echo "  Health:   http://localhost:8080/actuator/health"
    log_info ""
    log_warning "Press Ctrl+C to stop the tunnels"
    log_info "The tunnels will remain active until you stop this script"

    # Wait for user to stop
    wait
}

# Main function
main() {
    log_info "Setting up access to your private NorwoodSpice deployment"

    get_outputs
    test_connectivity "$BASTION_IP"
    setup_ssh_tunnel "$BASTION_IP" "$ALB_DNS"
}

# Cleanup function
cleanup() {
    log_info "Cleaning up SSH tunnels..."
    pkill -f "ssh.*$BASTION_IP.*8080\|ssh.*$BASTION_IP.*3000" || true
    log_success "Cleanup completed"
}

# Set trap for cleanup
trap cleanup EXIT

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --help|-h)
            echo "Usage: $0"
            echo ""
            echo "Access script for private NorwoodSpice deployment"
            echo ""
            echo "This script sets up SSH tunnels to access your privately deployed application."
            echo "Make sure you have run the setup and deployment scripts first."
            echo ""
            echo "Requirements:"
            echo "  - Terraform deployment completed"
            echo "  - SSH key from setup script"
            echo "  - Bastion host running"
            echo ""
            echo "After running this script, access your app at:"
            echo "  Frontend: http://localhost:3000"
            echo "  Backend:  http://localhost:8080"
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            exit 1
            ;;
    esac
done

main "$@"
