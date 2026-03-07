# Kustomize Overlays Guide

This guide explains how the Kustomize overlays work and how to use them for different environments.

## Overview

We use Kustomize overlays to maintain separate configurations for different environments without duplicating base manifests:

```
gitops-safe/
├── base/                    # Base manifests (shared across all environments)
│   ├── backend-deployment.yaml
│   ├── frontend-deployment.yaml
│   └── ...
├── overlays/
│   ├── dev/                 # Local/Dev environment (uses GHCR)
│   │   └── kustomization.yaml
│   └── aws/                 # AWS production (uses ECR)
│       ├── kustomization.yaml
│       └── image-pull-secret.yaml
```

## Base Configuration

The `base/` directory contains the core Kubernetes manifests that are shared across all environments:
- Deployments (backend, frontend, postgres, redis)
- Services
- ConfigMaps
- PVCs
- Security contexts

**Important**: Never modify base files directly for environment-specific changes!

## Overlays

### Dev Overlay (`overlays/dev/`)

**Purpose**: Local development and testing

**Changes**:
- Uses GHCR images: `ghcr.io/osomudeya/devops-home-lab-2025-backend:latest`
- No image pull secrets (public registry)
- Minimal resource requirements

**Usage**:
```bash
# From gitops-safe/overlays/dev
kubectl kustomize . | kubectl apply -f -
```

**ArgoCD**: Configured to use this for local development

### AWS Overlay (`overlays/aws/`)

**Purpose**: AWS EKS production deployment

**Changes**:
- **Image replacement**: GHCR → ECR
  - `ghcr.io/osomudeya/devops-home-lab-2025-backend` → `${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/devops-home-lab-backend`
- **Image pull secrets**: Adds ECR authentication
- **Image pull policy**: Always (for production)

**Usage**:
```bash
# Set environment variables
export AWS_ACCOUNT_ID=123456789012
export AWS_REGION=us-east-1

# Build and apply
kubectl kustomize . | envsubst | kubectl apply -f -
```

**ArgoCD**: Configured to use this for AWS production

## How It Works

### Image Replacement

The AWS overlay uses Kustomize's `images` field to replace image names:

```yaml
images:
  - name: ghcr.io/osomudeya/devops-home-lab-2025-backend
    newName: ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/devops-home-lab-backend
    newTag: latest
```

This means:
- Base files keep GHCR images (unchanged)
- AWS overlay automatically replaces them with ECR images
- CI/CD updates the tags automatically

### Patches

The overlay uses JSON patches to add AWS-specific configurations:

```yaml
patches:
  - target:
      kind: Deployment
      name: backend
    patch: |-
      - op: add
        path: /spec/template/spec/imagePullSecrets
        value:
          - name: ecr-registry-secret
```

## CI/CD Integration

The GitHub Actions workflow automatically updates image tags:

1. **Build images** → Push to ECR with tag `${GITHUB_SHA::7}`
2. **Update GitOps** → Modify `overlays/aws/kustomization.yaml`:
   ```yaml
   images:
     - name: ghcr.io/osomudeya/devops-home-lab-2025-backend
       newName: ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/devops-home-lab-backend
       newTag: abc1234  # Updated by CI/CD
   ```
3. **ArgoCD syncs** → Automatically deploys new images

## Creating New Overlays

To create a new environment overlay (e.g., staging):

1. **Create overlay directory**:
   ```bash
   mkdir -p gitops-safe/overlays/staging
   ```

2. **Create kustomization.yaml**:
   ```yaml
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization
   
   resources:
   - ../../base
   
   images:
     - name: ghcr.io/osomudeya/devops-home-lab-2025-backend
       newName: ${STAGING_REGISTRY}/devops-home-lab-backend
       newTag: latest
   
   commonLabels:
     environment: staging
   ```

3. **Configure ArgoCD** to use the new overlay

## Best Practices

1. **Never modify base files** for environment-specific changes
2. **Use overlays** for all environment differences
3. **Keep base simple** - only shared configurations
4. **Document overlays** - explain what each one does
5. **Test overlays** - use `kubectl kustomize` to preview changes

## Troubleshooting

### Images Not Updating

Check if ArgoCD is using the correct overlay:
```bash
kubectl get application -n argocd
kubectl describe application <app-name> -n argocd
```

### Image Pull Errors

Verify ECR secret exists:
```bash
kubectl get secret ecr-registry-secret -n humor-game
```

### Overlay Not Working

Preview what Kustomize will generate:
```bash
cd gitops-safe/overlays/aws
kubectl kustomize . | envsubst
```

## Summary

- ✅ **Base**: Shared manifests (never modify for env-specific changes)
- ✅ **Dev Overlay**: Local development (GHCR images)
- ✅ **AWS Overlay**: Production (ECR images, pull secrets)
- ✅ **CI/CD**: Automatically updates image tags
- ✅ **ArgoCD**: Uses appropriate overlay per environment

This approach keeps your local configs intact while supporting multiple deployment targets!

