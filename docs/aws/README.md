# AWS Deployment Documentation

This directory contains all documentation related to deploying the application on AWS infrastructure.

## 📚 Documentation Index

### 🚀 Getting Started
- **[AWS Deployment Guide](./aws-deployment-guide.md)** - Complete step-by-step guide to deploy on AWS
- **[AWS Architecture](./aws-architecture.md)** - Detailed architecture overview and design decisions

### ⚙️ Infrastructure Setup
- **[Terraform Backend Setup](./terraform-backend-setup.md)** - Configure S3 backend with encryption and state locking
- **[Environments Quick Start](./environments-quick-start.md)** - Deploy dev and prod environments

### 🔐 Security & Secrets
- **[AWS Secrets Manager Setup](./aws-secrets-manager-setup.md)** - Automatic secret management with External Secrets Operator

### 🔧 Configuration
- **[Kustomize Overlays](./kustomize-overlays.md)** - Environment-specific Kubernetes configurations

### 🏃 CI/CD
- **[GitHub Runner Access](./github-runner-access.md)** - Access and manage self-hosted GitHub Actions runner

### 🔧 Operations
- **[Maintenance Guide](./maintenance-guide.md)** - Maintain, update, and operate AWS infrastructure

## 🎯 Quick Start

1. **Initialize Terraform Backend**:
   ```bash
   ./scripts/terraform/init-backend.sh
   ```

2. **Deploy Infrastructure**:
   ```bash
   cd terraform/environments/prod
   terraform init -backend-config=backend-config.hcl
   terraform apply
   ```

3. **Deploy Application**:
   - ArgoCD will auto-deploy from `gitops-safe/overlays/aws/`
   - Or manually: `kubectl apply -k gitops-safe/overlays/aws/`

## 📋 Prerequisites

- AWS CLI configured
- Terraform >= 1.5.0
- kubectl installed
- Access to AWS account with appropriate permissions

## 🔗 Related Documentation

- **[Local Deployment](../local/README.md)** - Local development and testing
- **[Main Documentation](../README.md)** - Complete documentation hub

