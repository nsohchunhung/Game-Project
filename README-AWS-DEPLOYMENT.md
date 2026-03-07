# AWS Deployment - Complete Guide

## 🚀 Quick Start

### 1. Initialize Terraform Backend

```bash
# Auto-creates S3 bucket, DynamoDB table, KMS key, and detects your IP
./scripts/terraform/init-backend.sh
```

This automatically:
- ✅ Creates S3 bucket for state
- ✅ Creates DynamoDB table for locking
- ✅ Creates KMS key for encryption
- ✅ **Detects your IP** and updates terraform.tfvars
- ✅ Creates backend-config.hcl files
- ✅ Creates AWS key pair

### 2. Deploy Infrastructure

```bash
cd terraform/environments/prod

# Initialize with backend
terraform init -backend-config=backend-config.hcl

# Plan
terraform plan

# Apply
terraform apply
```

### 3. Import Grafana Dashboard

```bash
# Dashboard is automatically imported via ConfigMap
# Or manually:
./scripts/import-grafana-dashboard.sh
```

## 📊 Observability Dashboard

The Grafana dashboard is **automatically imported** when you deploy the observability stack. It includes:

- **Request Rate**: Real-time HTTP request metrics
- **Error Rate**: Error tracking with thresholds
- **Response Time**: p50, p95, p99 percentiles
- **Active Games**: Current game sessions
- **Database Metrics**: Query duration, connections
- **Redis Metrics**: Cache hit rate, connections
- **Application Health**: Service status

**Access**: Port-forward from bastion → `http://localhost:3000`

## 🔐 Secrets Management

Secrets are **automatically generated** and stored in AWS Secrets Manager:

- ✅ **DB_PASSWORD**: Auto-generated 32-char password
- ✅ **REDIS_PASSWORD**: Auto-generated 32-char password  
- ✅ **JWT_SECRET**: Auto-generated 64-char secret
- ✅ **Automatic sync** to Kubernetes via External Secrets Operator
- ✅ **No manual input** required!

## 🏗️ Infrastructure Components

### Networking
- **Hub VPC**: Bastion, GitHub runner
- **Spoke VPC**: EKS cluster (isolated)
- **VPC Peering**: Hub ↔ Spoke connectivity
- **VPC Endpoints**: Private AWS service access

### Compute
- **EKS Cluster**: Private endpoint, bastion-only access
- **Node Groups**: System (on-demand) + Application (spot)
- **Bastion Host**: Secure access point
- **GitHub Runner**: Self-hosted CI/CD

### Security
- **AWS Secrets Manager**: Automatic secret generation
- **External Secrets Operator**: Auto-sync to Kubernetes
- **IRSA**: IAM Roles for Service Accounts
- **Network Policies**: Pod-to-pod security

### Observability
- **Prometheus**: Metrics collection
- **Grafana**: Visualization (dashboard auto-imported)
- **CloudWatch**: AWS service metrics

## 🔧 EKS Deployment Issues - Fixed

All identified issues have been fixed:

1. ✅ **VPC Peering Routes**: Added to ALL route tables (multi-AZ)
2. ✅ **OIDC Provider**: Handles existing or creates new
3. ✅ **Node Group Remote Access**: Conditional (only if key provided)
4. ✅ **EKS Addon Versions**: Optional (AWS auto-selects compatible)
5. ✅ **VPC Endpoints**: Routes added to all route tables
6. ✅ **IRSA Dependencies**: Proper dependency chain
7. ✅ **Grafana Dashboard**: Auto-imported via ConfigMap

See [docs/eks-deployment-issues-fixed.md](docs/eks-deployment-issues-fixed.md) for details.

## 📁 File Structure

```
terraform/
├── main.tf                    # Root module
├── modules/                   # Reusable modules
│   ├── vpc/
│   ├── eks/
│   ├── secrets-manager/       # Auto-generates secrets
│   ├── external-secrets/      # Auto-syncs to K8s
│   └── observability/         # Prometheus + Grafana
├── environments/
│   ├── dev/                   # Dev environment
│   └── prod/                  # Prod environment
└── backend-config.hcl         # Auto-generated

scripts/
├── terraform/
│   └── init-backend.sh        # Auto-setup backend + IP detection
└── import-grafana-dashboard.sh # Auto-import dashboard

k8s/
└── grafana-dashboard-humor-game.json  # Dashboard definition
```

## 🎯 Key Features

### Automatic IP Detection
The init script automatically:
- Detects your public IP
- Updates `bastion_allowed_cidr_blocks` in terraform.tfvars
- No manual editing needed!

### Automatic Secret Generation
- Secrets auto-generated if not provided
- Stored in AWS Secrets Manager
- Auto-synced to Kubernetes
- No manual input required!

### Automatic Dashboard Import
- Dashboard defined in ConfigMap
- Grafana auto-imports on deployment
- Real-time metrics ready immediately

### VPC Peering
- Hub ↔ Spoke connectivity
- Routes added to ALL route tables
- Multi-AZ support
- Bastion can access EKS cluster

## 📚 Documentation

- [AWS Deployment Guide](docs/aws-deployment-guide.md)
- [AWS Architecture](docs/aws-architecture.md)
- [Secrets Manager Setup](docs/aws-secrets-manager-setup.md)
- [EKS Issues Fixed](docs/eks-deployment-issues-fixed.md)
- [Terraform Backend Setup](docs/terraform-backend-setup.md)
- [GitHub Runner Access](docs/github-runner-access.md)
- [Kustomize Overlays](docs/kustomize-overlays.md)

## ✅ Verification Checklist

After deployment:

- [ ] Terraform state in S3
- [ ] EKS cluster accessible via bastion
- [ ] Secrets in AWS Secrets Manager
- [ ] Secrets synced to Kubernetes
- [ ] Grafana dashboard visible
- [ ] Prometheus scraping metrics
- [ ] VPC peering routes working
- [ ] GitHub runner online
- [ ] ArgoCD syncing applications

## 🆘 Troubleshooting

### Backend Issues
See [Terraform Backend Setup](docs/terraform-backend-setup.md)

### EKS Issues
See [EKS Deployment Issues Fixed](docs/eks-deployment-issues-fixed.md)

### Secrets Issues
See [Secrets Manager Setup](docs/aws-secrets-manager-setup.md)

### Dashboard Issues
```bash
# Check dashboard ConfigMap
kubectl get configmap humor-game-dashboard -n monitoring

# Check Grafana logs
kubectl logs -n monitoring -l app.kubernetes.io/name=grafana
```

## 🎉 Summary

Everything is automated:
- ✅ **Backend**: Auto-created with IP detection
- ✅ **Secrets**: Auto-generated and synced
- ✅ **Dashboard**: Auto-imported to Grafana
- ✅ **VPC Peering**: Properly configured
- ✅ **EKS Issues**: All fixed

Just run the scripts and deploy! 🚀

