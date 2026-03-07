# Chapter 9: GitOps - Automated Deployments

*Implement production-grade GitOps workflows with ArgoCD for reliable, auditable deployments*

---

## What You'll Learn
- Set up ArgoCD for GitOps automation
- Configure proper GitOps repository structure with Kustomize
- Implement automated image updates in CI/CD pipeline
- Demonstrate drift detection and self-healing capabilities
- Build a complete GitOps workflow from commit to deployment

## Time Required: 60 minutes

## Prerequisites: [Chapter 8: Observability](08-observability.md)

---

## Why This Matters

GitOps is how modern companies deploy at scale. Instead of manual `kubectl apply` commands, your Git repository becomes the single source of truth for your infrastructure. When you commit changes, they automatically deploy. When someone makes manual changes, GitOps detects and corrects them.

**Professional Context**: Companies like Weave, Intuit, and CNCF recommend GitOps because it provides audit trails, consistency, and reliability that manual deployments can't match.

**💡 Pro Tip**: GitOps means "If you want to deploy something, commit it to Git. If you want to rollback, revert the commit." This simple principle revolutionizes deployment reliability.

## Understanding GitOps Workflow

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Developer     │    │   Git Repo      │    │   ArgoCD        │
│   Commits       │───▶│   Source of     │───▶│   Watches &     │
│   Changes       │    │   Truth         │    │   Syncs         │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                        │
                                                        ▼
                                              ┌─────────────────┐
                                              │   Kubernetes    │
                                              │   Cluster       │
                                              │   Updates       │
                                              └─────────────────┘
```

### Current Implementation Issues

Before we fix them, let's understand what's wrong with your current setup:

1. **Empty argocd-application-local.yaml** - No configuration
2. **Incomplete kustomize overlays** - Missing resources  
3. **CI/CD pushes directly to cluster** - Bypasses GitOps
4. **No image update mechanism** - Manual image tag updates required

## Fix and Enhance ArgoCD Implementation

### Step 1: Install ArgoCD

```bash
# Create ArgoCD namespace
kubectl create namespace argocd

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for ArgoCD to be ready
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s
```

**Expected Output:**
```bash
namespace/argocd created
customresourcedefinition.apiextensions.k8s.io/applications.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/applicationsets.argoproj.io created
# ... many more resources
pod/argocd-application-controller-0 condition met
pod/argocd-dex-server-xxx condition met
pod/argocd-redis-xxx condition met
pod/argocd-repo-server-xxx condition met
pod/argocd-server-xxx condition met
```

### Step 2: Access ArgoCD UI

```bash
# Get initial admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo  # Add newline
```

**Expected Output:**
```bash
Xy9K8mNpQrS4vZ2E
```

```bash
# Port-forward to ArgoCD server
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
```

**Access ArgoCD:**
- URL: `https://localhost:8080`
- Username: `admin`  
- Password: (from previous command)
- **⚠️ Accept the self-signed certificate warning**

[[ADD IMAGE: ArgoCD login screen with admin credentials]]

### Step 3: Create GitOps Project

```bash
# Apply the ArgoCD project configuration
kubectl apply -f gitops-safe/argocd-project.yaml
```

**Expected Output:**
```bash
appproject.argoproj.io/humor-game-safe created
```

**What this does:**
- Creates a restricted project for your application
- Limits which repositories and clusters ArgoCD can access
- Defines resource whitelists for security
- Prevents accidental cluster-wide changes

### Step 4: Deploy GitOps Application (Local Development)

```bash
# Apply the local ArgoCD application
kubectl apply -f gitops-safe/argocd-application-local.yaml
```

**Expected Output:**
```bash
application.argoproj.io/humor-game-local created
```

### Step 5: Verify ArgoCD Application

```bash
# Check ArgoCD application status
kubectl get applications -n argocd
```

**Expected Output:**
```bash
NAME                SYNC STATUS   HEALTH STATUS   REVISION   PROJECT
humor-game-local    OutOfSync     Healthy         HEAD       humor-game-safe
```

**💡 Pro Tip**: "OutOfSync" is expected initially because ArgoCD detects differences between Git and your current cluster state.

## Understanding the GitOps Repository Structure

### Current Structure Analysis

```bash
# Examine your gitops-safe directory structure
tree gitops-safe/
```

**Expected Output:**
```bash
gitops-safe/
├── argocd-application-local.yaml
├── argocd-application.yaml
├── argocd-project.yaml
├── base/
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── configmap.yaml
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── kustomization.yaml
│   ├── postgres-deployment.yaml
│   ├── postgres-service.yaml
│   ├── pvc.yaml
│   ├── redis-deployment.yaml
│   └── redis-service.yaml
└── overlays/
    └── dev/
        └── kustomization.yaml
```

### Step 6: Test Kustomize Configuration

```bash
# Build the base configuration
kubectl kustomize gitops-safe/base/ | head -20
```

**Expected Output:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  annotations:
    gitops.argoproj.io/description: Base configuration for Humor Game
    gitops.argoproj.io/version: 1.0.0
  name: humor-game-config
  namespace: humor-game
data:
  API_PORT: "3001"
  DB_NAME: humor_memory_game
  DB_USER: gameuser
  NODE_ENV: production
  REDIS_HOST: redis
```

```bash
# Build the dev overlay configuration
kubectl kustomize gitops-safe/overlays/dev/ | head -20
```

**Expected Output:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  annotations:
    argocd.argoproj.io/tracking-id: humor-game-monitor:/kustomization.yaml
    gitops.argoproj.io/description: Base configuration for Humor Game
    gitops.argoproj.io/version: 1.0.0
  labels:
    app.kubernetes.io/instance: dev
    app.kubernetes.io/managed-by: argocd
    app.kubernetes.io/name: humor-game
    app.kubernetes.io/part-of: gitops-demo
  name: humor-game-config
  namespace: humor-game
```

## Demonstrate GitOps in Action

### Step 7: Sync Application in ArgoCD

**In ArgoCD UI:**
1. Click on the `humor-game-local` application
2. Click "SYNC" button
3. Select "SYNCHRONIZE" to apply changes

[[ADD IMAGE: ArgoCD sync process showing the sync button and confirmation]]

**Or via CLI:**
```bash
# Install ArgoCD CLI (optional)
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Login to ArgoCD CLI
argocd login localhost:8080 --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure

# Sync the application
argocd app sync humor-game-local
```

**Expected Output:**
```bash
TIMESTAMP                  GROUP        KIND   NAMESPACE                  NAME    STATUS    HEALTH        HOOK  MESSAGE
2025-01-15T10:30:00+00:00            ConfigMap  humor-game        humor-game-config    Synced  Healthy              
2025-01-15T10:30:01+00:00   apps  Deployment  humor-game              backend    Synced  Healthy              
2025-01-15T10:30:02+00:00   apps  Deployment  humor-game             frontend    Synced  Healthy              
2025-01-15T10:30:03+00:00   apps  Deployment  humor-game             postgres    Synced  Healthy              
2025-01-15T10:30:04+00:00   apps  Deployment  humor-game                redis    Synced  Healthy
```

### Step 8: Demonstrate Drift Detection

Now let's show ArgoCD's most powerful feature - drift detection:

```bash
# Manually change something in the cluster (simulate drift)
kubectl scale deployment backend --replicas=3 -n humor-game

# Check what happened
kubectl get deployments -n humor-game
```

**Expected Output:**
```bash
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
backend    3/3     3            3           5m
frontend   1/1     1            1           5m
postgres   1/1     1            1           5m
redis      1/1     1            1           5m
```

**In ArgoCD UI:**
- The application will show "OutOfSync" status
- You'll see the difference between Git (1 replica) and cluster (3 replicas)
- ArgoCD detects this drift automatically

[[ADD IMAGE: ArgoCD showing OutOfSync status with drift details]]

### Step 9: Test Self-Healing (Optional)

```bash
# Enable auto-sync for demonstration
kubectl patch application humor-game-local -n argocd --type='merge' -p='{"spec":{"syncPolicy":{"automated":{"prune":false,"selfHeal":true}}}}'

# Wait and watch ArgoCD automatically fix the drift
kubectl get deployments -n humor-game -w
```

**Expected Output:**
```bash
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
backend    3/3     3            3           5m
backend    3/1     1            3           5m    # ArgoCD starts correcting
backend    1/1     1            1           5m    # Back to desired state
```

**💡 Pro Tip**: In production, you might disable self-healing for critical applications and only enable it for non-critical workloads.

## Implement Complete CI/CD GitOps Workflow

### Step 10: Fix CI/CD Pipeline

Your current CI/CD pipeline has issues. I've created a fixed version in `.github/workflows/ci.yml`:

**Key Improvements:**
1. **Uses GitHub Container Registry** (free for public repos)
2. **Updates GitOps manifests** instead of direct deployment
3. **Proper image tagging** with commit SHA
4. **Security scanning** with Trivy
5. **Automated GitOps updates** after successful builds

### Step 11: Test the Complete Workflow

**Make a code change:**

```bash
# Make a simple change to test the workflow
echo "<!-- GitOps test change -->" >> frontend/src/index.html

# Commit and push
git add frontend/src/index.html
git commit -m "test: GitOps workflow demonstration"
git push origin main
```

**What happens:**
1. **GitHub Actions runs** CI/CD pipeline
2. **Tests execute** and security scanning runs
3. **Docker images build** and push to GitHub Container Registry
4. **GitOps manifests update** with new image tags
5. **ArgoCD detects** the Git changes
6. **ArgoCD syncs** new images to cluster

### Step 12: Monitor the Deployment

**Watch the GitHub Actions:**
- Go to your repository → Actions tab
- Watch the workflow execute through all stages

**Watch ArgoCD:**
- ArgoCD UI will show the application syncing
- New image tags will appear in the deployment

**Verify in cluster:**
```bash
# Check that new images are deployed
kubectl describe deployment backend -n humor-game | grep Image
kubectl describe deployment frontend -n humor-game | grep Image
```

## Production GitOps Configuration

### Step 13: Configure Production Application

For production, use the separate application configuration:

```bash
# Review the production configuration
cat gitops-safe/argocd-application.yaml
```

**Key Differences:**
- Points to `main` branch (more stable)
- Uses dev overlay for environment-specific configuration
- More restrictive sync policies
- Better suited for production workflows

### Step 14: Environment-Specific Configuration

```bash
# Create production overlay (example)
mkdir -p gitops-safe/overlays/prod

# Production-specific kustomization
cat > gitops-safe/overlays/prod/kustomization.yaml << EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../../base

commonLabels:
  app.kubernetes.io/name: humor-game
  app.kubernetes.io/instance: prod
  app.kubernetes.io/part-of: gitops-demo
  app.kubernetes.io/managed-by: argocd
  environment: production

patchesStrategicMerge:
- replica-patch.yaml

images:
- name: humor-game-backend
  newTag: main-1.0.0
- name: humor-game-frontend  
  newTag: main-1.0.0
EOF

# Production replica configuration
cat > gitops-safe/overlays/prod/replica-patch.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 3
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 2
EOF
```

## ✅ Checkpoint

Your GitOps implementation is working when:
- ✅ ArgoCD UI shows `humor-game-local` application as "Synced" and "Healthy"
- ✅ Manual cluster changes are detected as "OutOfSync"
- ✅ Kustomize builds produce valid Kubernetes manifests
- ✅ CI/CD pipeline successfully updates GitOps manifests
- ✅ ArgoCD automatically syncs new image tags from Git
- ✅ Application pods restart with new images after CI/CD runs
- ✅ All configuration is version-controlled in Git

## Troubleshooting GitOps Issues

### Issue: ArgoCD Application Shows "Unknown" Health

**Symptom:**
```bash
NAME                SYNC STATUS   HEALTH STATUS   REVISION
humor-game-local    Synced        Unknown         HEAD
```

**Diagnosis:**
```bash
# Check ArgoCD application details
kubectl describe application humor-game-local -n argocd

# Check ArgoCD server logs
kubectl logs deployment/argocd-server -n argocd
```

**Fix:**
```bash
# Refresh the application
argocd app get humor-game-local --refresh

# Or delete and recreate
kubectl delete application humor-game-local -n argocd
kubectl apply -f gitops-safe/argocd-application-local.yaml
```

### Issue: Kustomize Build Fails

**Symptom:**
```bash
Error: accumulating resources: accumulation err='merging resources from 'backend-deployment.yaml': may not add resource with an already registered id
```

**Diagnosis:**
```bash
# Check for duplicate resources in kustomization.yaml
kubectl kustomize gitops-safe/base/ --dry-run
```

**Fix:**
```bash
# Ensure no duplicate resource names in kustomization.yaml
# Remove any duplicate entries in the resources list
```

### Issue: CI/CD Pipeline Fails to Push Images

**Symptom:** GitHub Actions shows authentication errors to container registry

**Fix:**
```bash
# Ensure your repository has the necessary permissions
# Go to Settings → Actions → General → Workflow permissions
# Select "Read and write permissions"
# Check "Allow GitHub Actions to create and approve pull requests"
```

### Issue: Image Updates Don't Trigger ArgoCD Sync

**Symptom:** CI/CD updates manifests but ArgoCD doesn't sync

**Diagnosis:**
```bash
# Check if ArgoCD is polling the repository
argocd app get humor-game-local

# Check repository connection
argocd repo get https://github.com/YOUR_USERNAME/DevOps-Home-Lab-2025.git
```

**Fix:**
```bash
# Manually refresh the repository
argocd app get humor-game-local --refresh

# Or enable webhooks (advanced)
# Configure GitHub webhooks to notify ArgoCD of changes
```

## Advanced GitOps Troubleshooting

### Issue: ArgoCD Application Health Issues

**Symptom:** Application shows "Unknown" or "Degraded" health

**Diagnosis:**
```bash
# Check application health details
kubectl describe application humor-game-local-dev -n argocd

# Check resource health
kubectl get all -n humor-game
kubectl describe pods -n humor-game
```

**Common Fixes:**
```bash
# 1. Refresh application
kubectl patch application humor-game-local-dev -n argocd \
  --type='merge' \
  -p='{"metadata": {"annotations": {"argocd.argoproj.io/refresh": "hard"}}}'

# 2. Force sync with prune disabled
kubectl patch application humor-game-local-dev -n argocd \
  --type='merge' \
  -p='{"operation": {"sync": {"syncOptions": ["Prune=false"]}}}'

# 3. Check Kustomize build
kubectl kustomize gitops-safe/overlays/dev/
```

### Issue: GitOps Repository Access Problems

**Symptom:** ArgoCD can't access Git repository

**Diagnosis:**
```bash
# Check repository connectivity
kubectl logs -l app.kubernetes.io/name=argocd-server -n argocd | grep -i "repository"

# Check Git credentials
kubectl get secret argocd-repo -n argocd -o yaml
```

**Fixes:**
```bash
# 1. Update repository credentials
kubectl create secret generic argocd-repo \
  --from-literal=username=YOUR_GITHUB_USERNAME \
  --from-literal=password=YOUR_GITHUB_TOKEN \
  -n argocd

# 2. Restart ArgoCD server
kubectl rollout restart deployment/argocd-server -n argocd
```

### Issue: Kustomize Build Failures

**Symptom:** ArgoCD shows "Build Error" status

**Diagnosis:**
```bash
# Test Kustomize build locally
kubectl kustomize gitops-safe/overlays/dev/

# Check for YAML syntax errors
kubectl apply --dry-run=client -k gitops-safe/overlays/dev/
```

**Fixes:**
```bash
# 1. Fix YAML syntax errors
# Check each YAML file for indentation and syntax

# 2. Verify resource references
kubectl get configmap -n humor-game
kubectl get secret -n humor-game

# 3. Check resource dependencies
kubectl describe configmap humor-game-config -n humor-game
```

## What You Learned

You've implemented a complete GitOps workflow:

**GitOps Fundamentals:**
- **Declarative Configuration**: Infrastructure defined in Git as code
- **Automated Sync**: ArgoCD watches Git and applies changes automatically
- **Drift Detection**: Identifies manual changes and can auto-correct them
- **Audit Trail**: Complete history of deployments through Git commits
- **Rollback Capability**: Simple git revert to rollback deployments

**Production Patterns:**
- **Environment Separation**: Using Kustomize overlays for different environments
- **Security Controls**: AppProject restrictions and RBAC integration
- **Image Management**: Automated image tag updates in CI/CD pipeline
- **Multi-stage Workflow**: Tests → Build → Update GitOps → Deploy

**Operational Skills:**
- **ArgoCD Management**: Installing, configuring, and operating ArgoCD
- **Kustomize Configuration**: Building flexible, reusable Kubernetes manifests
- **CI/CD Integration**: Connecting traditional pipelines with GitOps workflows
- **Troubleshooting**: Diagnosing and fixing common GitOps issues

**Career-Ready Capabilities:**
- **DevOps Engineering**: Complete understanding of modern deployment workflows
- **Platform Engineering**: Building developer-friendly deployment platforms
- **Site Reliability**: Implementing reliable, auditable deployment processes
- **Security**: Understanding GitOps security implications and controls

This GitOps implementation mirrors what major tech companies use for production deployments. You now understand how to build reliable, auditable, and automated deployment pipelines that scale to serve millions of users.

---

**Next**: [Chapter 10: Production Hardening and Security](10-prod-hardening.md) - Secure your application for production deployment
**Previous**: [Chapter 8: Observability](08-observability.md) - Monitoring and alerting for production systems
