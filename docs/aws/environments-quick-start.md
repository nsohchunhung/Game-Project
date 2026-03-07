# Environments Quick Start Guide

## Overview

The infrastructure now supports multiple environments (dev and prod) with separate Terraform configurations and Kustomize overlays.

## Directory Structure

```
terraform/
├── main.tf                    # Root module (used by environments)
├── modules/                   # Reusable modules
└── environments/
    ├── dev/                   # Dev environment
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── terraform.tfvars.example
    └── prod/                  # Prod environment
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── terraform.tfvars.example

gitops-safe/
├── base/                      # Base manifests (unchanged)
└── overlays/
    ├── dev/                   # Dev overlay (GHCR images)
    └── aws/                   # AWS overlay (ECR images)
```

## Deploying Dev Environment

```bash
cd terraform/environments/dev

# Copy and configure variables
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values

# Initialize and deploy
terraform init
terraform plan
terraform apply
```

**Dev Environment Features**:
- Smaller node groups (t3.small, 1-2 nodes)
- Uses `gitops-safe/overlays/dev` (GHCR images)
- Optional GitHub runner
- Lower cost (~$50-100/month)

## Deploying Prod Environment

```bash
cd terraform/environments/prod

# Copy and configure variables
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values

# Initialize and deploy
terraform init
terraform plan
terraform apply
```

**Prod Environment Features**:
- Larger node groups (t3.medium, 2-10 nodes)
- Uses `gitops-safe/overlays/aws` (ECR images)
- GitHub runner enabled
- Full observability stack
- Estimated cost (~$150-300/month)

## Kustomize Overlays

### How It Works

1. **Base** (`gitops-safe/base/`): Contains all Kubernetes manifests with GHCR images
2. **Dev Overlay** (`gitops-safe/overlays/dev/`): Uses base as-is (GHCR images)
3. **AWS Overlay** (`gitops-safe/overlays/aws/`): Patches images to use ECR

### Image Flow

**Local/Dev**:
```
Base → Dev Overlay → GHCR images (ghcr.io/...)
```

**AWS Production**:
```
Base → AWS Overlay → ECR images (123456789012.dkr.ecr.us-east-1.amazonaws.com/...)
```

### CI/CD Updates

The GitHub Actions workflow automatically:
1. Builds images and pushes to ECR
2. Updates `overlays/aws/kustomization.yaml` with new image tags
3. ArgoCD syncs the changes

## Accessing GitHub Runner

### Method 1: AWS Systems Manager (Easiest)

```bash
# Get runner instance ID
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=devops-home-lab-prod-github-runner" \
  --query 'Reservations[0].Instances[0].InstanceId' \
  --output text

# Start session
aws ssm start-session --target <instance-id>
```

### Method 2: Via Bastion

```bash
# SSH to bastion
ssh -i your-key.pem ec2-user@<bastion-ip>

# From bastion, SSH to runner
ssh ec2-user@<runner-private-ip>
```

See [GitHub Runner Access Guide](github-runner-access.md) for detailed instructions.

## Verifying Deployment

### Check EKS Cluster

```bash
# Configure kubectl
aws eks update-kubeconfig --region us-east-1 --name devops-home-lab-prod-eks

# Verify nodes
kubectl get nodes

# Check pods
kubectl get pods -n humor-game
```

### Check ArgoCD

```bash
# Port-forward ArgoCD (from bastion)
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Access: https://localhost:8080
# Username: admin
# Password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

### Verify Images

```bash
# Check which images are being used
kubectl get deployment backend -n humor-game -o jsonpath='{.spec.template.spec.containers[0].image}'

# Should show ECR images in prod, GHCR in dev
```

## Environment Differences

| Feature | Dev | Prod |
|---------|-----|------|
| Node Size | t3.small | t3.medium |
| Node Count | 1-2 nodes | 2-10 nodes |
| GitHub Runner | Optional | Enabled |
| Image Registry | GHCR | ECR |
| ArgoCD Overlay | `overlays/dev` | `overlays/aws` |
| Estimated Cost | $50-100/mo | $150-300/mo |

## Troubleshooting

### Images Not Pulling

1. **Check image pull secret exists**:
   ```bash
   kubectl get secret ecr-registry-secret -n humor-game
   ```

2. **Create secret if missing**:
   ```bash
   aws ecr get-login-password --region us-east-1 | \
     kubectl create secret docker-registry ecr-registry-secret \
     --docker-server=${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com \
     --docker-username=AWS \
     --docker-password=$(aws ecr get-login-password --region us-east-1) \
     --namespace=humor-game
   ```

### ArgoCD Using Wrong Overlay

Check ArgoCD application:
```bash
kubectl get application -n argocd
kubectl describe application <app-name> -n argocd
```

Verify `spec.source.path` points to correct overlay.

## Next Steps

1. ✅ Deploy dev environment for testing
2. ✅ Deploy prod environment for production
3. ✅ Configure ECR image pull secrets
4. ✅ Set up CI/CD pipeline
5. ✅ Monitor deployments via ArgoCD

For more details, see:
- [GitHub Runner Access Guide](github-runner-access.md)
- [Kustomize Overlays Guide](kustomize-overlays.md)
- [AWS Deployment Guide](aws-deployment-guide.md)

