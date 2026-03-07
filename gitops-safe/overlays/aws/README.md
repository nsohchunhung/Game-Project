# AWS Overlay for Kustomize

This overlay patches the base Kubernetes manifests for AWS EKS deployment.

## What This Overlay Does

1. **Image Replacement**: Changes image registry from GHCR to ECR
   - `ghcr.io/osomudeya/devops-home-lab-2025-backend` → `${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/devops-home-lab-backend`
   - `ghcr.io/osomudeya/devops-home-lab-2025-frontend` → `${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/devops-home-lab-frontend`

2. **Image Pull Secrets**: Adds ECR registry secret for authentication

3. **Image Pull Policy**: Sets to `Always` for production

## Usage

### With ArgoCD

ArgoCD will automatically use this overlay when configured with:
```yaml
source:
  path: gitops-safe/overlays/aws
```

### Manual Deployment

```bash
# Set environment variables
export AWS_ACCOUNT_ID=123456789012
export AWS_REGION=us-east-1

# Build kustomize
kubectl kustomize . | envsubst | kubectl apply -f -
```

## Image Pull Secret Setup

Before deploying, create the ECR image pull secret:

```bash
# Get ECR login token
aws ecr get-login-password --region ${AWS_REGION} | \
  docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# Create Kubernetes secret
kubectl create secret docker-registry ecr-registry-secret \
  --docker-server=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --region ${AWS_REGION}) \
  --namespace=humor-game
```

## CI/CD Integration

The CI/CD pipeline automatically updates image tags in this overlay:
- Backend: `${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/devops-home-lab-backend:${GITHUB_SHA::7}`
- Frontend: `${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/devops-home-lab-frontend:${GITHUB_SHA::7}`

## Differences from Base/Dev

| Feature | Base/Dev | AWS Overlay |
|---------|----------|-------------|
| Image Registry | GHCR | ECR |
| Image Pull Secret | None | ECR secret required |
| Image Pull Policy | Always | Always |
| Environment | Local/Dev | AWS Production |

## Notes

- Base configurations remain unchanged
- This overlay only patches what's needed for AWS
- Local development continues to use base/dev overlays

