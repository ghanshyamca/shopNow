#!/bin/bash

###############################################################################
# ShopNow - Docker Build and Push Script
# Purpose: Build all Docker images and push to AWS ECR
# Usage: ./build-and-push.sh [component] [tag]
#   component: backend|frontend|admin|all (default: all)
#   tag: image tag (default: latest)
###############################################################################

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration - REPLACE THESE
AWS_REGION="${AWS_REGION:-us-east-1}"
AWS_ACCOUNT_ID="${AWS_ACCOUNT_ID:-975050024946}"
ECR_BASE="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/shopnow"

# Parse arguments
COMPONENT="${1:-all}"
TAG="${2:-latest}"

###############################################################################
# Helper Functions
###############################################################################

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_prerequisites() {
    log_info "Checking prerequisites..."
    
    if ! command -v docker &> /dev/null; then
        log_error "Docker is not installed"
        exit 1
    fi
    
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI is not installed"
        exit 1
    fi
    
    if [ "${AWS_ACCOUNT_ID}" == "975050024946" ]; then
        log_error "Please configure AWS_ACCOUNT_ID in the script or environment"
        exit 1
    fi
    
    log_info "Prerequisites check passed"
}

ecr_login() {
    log_info "Logging into AWS ECR..."
    aws ecr get-login-password --region ${AWS_REGION} | \
        docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
    log_info "ECR login successful"
}

build_and_push() {
    local component=$1
    local context_dir="./${component}"
    local dockerfile="${context_dir}/Dockerfile"
    local repo="${ECR_BASE}/${component}"
    
    log_info "=========================================="
    log_info "Building ${component}"
    log_info "=========================================="
    
    if [ ! -f "${dockerfile}" ]; then
        log_error "Dockerfile not found: ${dockerfile}"
        return 1
    fi
    
    # Build
    log_info "Building image: ${repo}:${TAG}"
    docker build \
        -t ${repo}:${TAG} \
        -t ${repo}:latest \
        -f ${dockerfile} \
        ${context_dir}
    
    # Push
    log_info "Pushing image: ${repo}:${TAG}"
    docker push ${repo}:${TAG}
    docker push ${repo}:latest
    
    log_info "✓ ${component} build and push completed"
}

###############################################################################
# Main Execution
###############################################################################

main() {
    log_info "ShopNow Docker Build and Push Script"
    log_info "Component: ${COMPONENT}"
    log_info "Tag: ${TAG}"
    log_info "ECR Base: ${ECR_BASE}"
    
    check_prerequisites
    ecr_login
    
    case ${COMPONENT} in
        backend)
            build_and_push "backend"
            ;;
        frontend)
            build_and_push "frontend"
            ;;
        admin)
            build_and_push "admin"
            ;;
        all)
            build_and_push "backend"
            build_and_push "frontend"
            build_and_push "admin"
            ;;
        *)
            log_error "Invalid component: ${COMPONENT}"
            log_info "Usage: $0 [backend|frontend|admin|all] [tag]"
            exit 1
            ;;
    esac
    
    log_info "=========================================="
    log_info "✓ All builds completed successfully!"
    log_info "=========================================="
    
    # Display pushed images
    log_info "Pushed images:"
    case ${COMPONENT} in
        all)
            echo "  - ${ECR_BASE}/backend:${TAG}"
            echo "  - ${ECR_BASE}/frontend:${TAG}"
            echo "  - ${ECR_BASE}/admin:${TAG}"
            ;;
        *)
            echo "  - ${ECR_BASE}/${COMPONENT}:${TAG}"
            ;;
    esac
}

main "$@"
