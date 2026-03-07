# Chapter 7: CI/CD Pipeline Implementation

*Build a production-ready continuous integration and deployment pipeline with GitOps integration*

---

## What You'll Learn
- Design and implement CI/CD pipelines with GitHub Actions
- Set up automated testing, security scanning, and quality gates
- Configure container registry integration and image management
- Implement GitOps-native deployment workflows
- Build proper CI/CD security and secrets management

## Time Required: 30 minutes

## Prerequisites: [Chapter 6: Production Networking and Ingress](06-ingress-networking.md)

---

## Why This Matters

Manual deployments don't scale and create consistency problems. Professional software teams deploy multiple times per day using automated pipelines that ensure quality, security, and reliability. Learning to build these pipelines is essential for any DevOps engineer.

**Career Impact**: Companies look for engineers who understand the full software delivery lifecycle. CI/CD pipeline knowledge is fundamental for DevOps, Platform Engineering, and SRE roles.

**💡 Pro Tip**: Good CI/CD pipelines catch problems before they reach production, saving teams hours of debugging and customer-facing issues.

## Understanding CI/CD vs GitOps

Your implementation combines traditional CI/CD with GitOps for the best of both worlds:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Code Change   │    │   CI/CD Tests   │    │   GitOps Repo   │
│   (Git Push)    │───▶│   Build Images  │───▶│   Update Tags   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                        │
                                                        ▼
                                              ┌─────────────────┐
                                              │   ArgoCD Sync   │
                                              │   to Cluster    │
                                              └─────────────────┘
```

**Traditional CI/CD**: Tests → Build → Deploy directly to cluster
**GitOps CI/CD**: Tests → Build → Update Git → GitOps tool deploys

## Current Implementation Analysis

### ✅ Production-Ready Pipeline Status

Your CI/CD pipeline is now **fully functional and production-ready**. Here's what it accomplishes:

**✅ Current Capabilities:**
1. **GitHub Container Registry**: Uses `ghcr.io` for secure image storage
2. **GitOps Integration**: Updates manifests and triggers ArgoCD deployment
3. **Security Scanning**: Trivy vulnerability scanning with SARIF upload
4. **Smart Image Tagging**: Uses commit SHA for precise versioning
5. **Database Integration**: Properly configures database connections via ConfigMaps and Secrets
6. **Multi-Environment Support**: Works with local k3d and production clusters

### Pipeline Scope and Limitations

**✅ What CI/CD Pipeline DOES:**
- **Builds and pushes** container images to GitHub Container Registry
- **Updates GitOps manifests** with new image tags
- **Triggers ArgoCD** to deploy to Kubernetes cluster
- **Runs security scans** and quality checks
- **Deploys to Kubernetes** cluster level

**❌ What CI/CD Pipeline DOES NOT Do:**
- **No Cloudflare Integration**: Requires manual tunnel setup
- **No Global Access**: Only deploys to cluster, not globally accessible
- **No External DNS**: DNS routing must be configured separately

## Database Connection in CI/CD Pipeline

### How Database Integration Works

Your CI/CD pipeline properly handles database connections through Kubernetes configuration:

**🔌 Database Connection Flow:**
```
CI/CD Pipeline → Build Images → Update Manifests → ArgoCD Deploy → Kubernetes Pods
                                                                    ↓
                                                              Environment Variables
                                                                    ↓
                                                              ConfigMap + Secrets
                                                                    ↓
                                                              Database Connection Pool
                                                                    ↓
                                                              PostgreSQL Service
```

**📋 Database Configuration in Pipeline:**

# 🗄️ Database Configuration in CI/CD
# How database connections are managed through the pipeline

```yaml
# Backend deployment gets these environment variables
env:
  - name: DB_HOST
    value: "postgres"  # Kubernetes service name
  - name: DB_NAME
    valueFrom:
      configMapKeyRef:
        name: humor-game-config
        key: DB_NAME
  - name: DB_USER
    valueFrom:
      configMapKeyRef:
        name: humor-game-config
        key: DB_USER
  - name: DB_PASSWORD
    valueFrom:
      secretKeyRef:
        name: humor-game-secrets
        key: DB_PASSWORD
```

**💡 Key Points:**
- **ConfigMap**: Contains non-sensitive database configuration
- **Secrets**: Contains sensitive data like passwords
- **Service Discovery**: Uses Kubernetes service name `postgres`
- **Connection Pooling**: Handles multiple concurrent connections
- **Automatic Schema**: Database initializes with proper schema on startup

## Implement the Production CI/CD Pipeline

### Step 1: Examine the Pipeline Structure

# 📋 Examine CI/CD Pipeline Structure
# Review the new GitHub Actions workflow configuration

```bash
# Check the new CI/CD pipeline
cat .github/workflows/ci.yml | head -20
```

**Expected Output:**

# 📄 CI/CD Pipeline Configuration
# GitHub Actions workflow with container registry and triggers

```yaml
name: 🔄 Continuous Integration

on:
  push:
    branches: [ main, develop, feature/* ]
  pull_request:
    branches: [ main, develop ]
  workflow_dispatch:

env:
  # Use GitHub Container Registry (free for public repos)
  REGISTRY: ghcr.io
  IMAGE_NAME_BACKEND: ${{ github.repository }}-backend
  IMAGE_NAME_FRONTEND: ${{ github.repository }}-frontend
```

### Step 2: Understand Pipeline Stages

The pipeline has 5 main stages:

# 🔍 View Pipeline Job Structure
# Examine the different stages of the CI/CD pipeline

```bash
# View the job structure
grep -A 2 "jobs:" .github/workflows/ci.yml
```

**Expected Output:**

# 📊 CI/CD Pipeline Jobs Overview
# Five main stages of the automated pipeline

```yaml
jobs:
  test:
    name: 🧪 Test Application
  
  security-scan:
    name: 🔒 Security Scan
    
  build-and-push:
    name: 🏗️ Build and Push Images
    
  update-gitops:
    name: 🔄 Update GitOps Repository
    
  notify:
    name: 📢 Notify Team
```

### Step 3: Enable GitHub Container Registry

Your repository needs permissions to push to GitHub Container Registry:

**Via GitHub UI:**
1. Go to your repository → Settings → Actions → General
2. Under "Workflow permissions" select "Read and write permissions"
3. Check "Allow GitHub Actions to create and approve pull requests"

[[ADD IMAGE: GitHub repository settings showing workflow permissions]]

**Verify with CLI:**
# 🔐 Verify GitHub Container Registry Access
# Test authentication to GitHub Container Registry

```bash
# Check if you can access the registry
echo ${{ secrets.GITHUB_TOKEN }} | docker login ghcr.io -u ${{ github.actor }} --password-stdin
```

### Step 4: Test the Complete Pipeline

Let's trigger the pipeline and watch it work:

# 🚀 Trigger CI/CD Pipeline Test
# Make a change to test the complete pipeline workflow

```bash
# Make a simple change to trigger the pipeline
echo "<!-- CI/CD test change $(date) -->" >> README.md

# Commit and push to trigger the workflow
git add README.md
git commit -m "test: trigger CI/CD pipeline demonstration"
git push origin main
```

**What happens next:**
1. **GitHub Actions** detects the push and starts the workflow
2. **Test Stage** runs unit tests and linting (parallel with security scan)
3. **Security Scan** runs Trivy vulnerability scanning
4. **Build Stage** creates and pushes images to GitHub Container Registry
5. **GitOps Update** modifies manifests with new image tags and commits changes
6. **ArgoCD Sync** (if configured) detects Git changes and deploys to cluster
7. **Database Connection** is established using ConfigMap and Secret values
8. **Application** becomes available at cluster level (not globally accessible)

### Step 5: Monitor Pipeline Execution

**Watch in GitHub UI:**
1. Go to your repository → Actions tab
2. Click on the running workflow
3. Watch each job complete

[[ADD IMAGE: GitHub Actions workflow running with all stages]]

**Expected Timeline:**

# ⏱️ CI/CD Pipeline Timeline
# Estimated execution times for each pipeline stage

```bash
🧪 Test Application         (2-3 minutes)
🔒 Security Scan            (1-2 minutes, parallel with test)
🏗️ Build and Push Images    (3-5 minutes)
🔄 Update GitOps Repository (30 seconds)
📢 Notify Team              (10 seconds)
```

## Understanding Each Pipeline Stage

### Stage 1: Test Application

# 🧪 Test Application Stage Configuration
# GitHub Actions job for running tests and linting

```yaml
test:
  name: 🧪 Test Application
  runs-on: ubuntu-latest
  
  steps:
    - name: 📥 Checkout code
      uses: actions/checkout@v4
      
    - name: 🟢 Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'
```

**What it does:**
- Runs unit tests for both frontend and backend
- Lints code for consistency
- Fails fast if basic quality checks don't pass
- Uses npm cache for faster builds

### Stage 2: Security Scanning

# 🔒 Security Scanning Stage Configuration
# Trivy vulnerability scanner integration

```yaml
security-scan:
  name: 🔒 Security Scan
  runs-on: ubuntu-latest
  
  steps:
    - name: 🔒 Run Trivy vulnerability scanner
      uses: aquasecurity/trivy-action@master
      with:
        scan-type: 'fs'
        scan-ref: '.'
```

**What it does:**
- Scans your code for known vulnerabilities
- Checks dependencies for security issues
- Creates security reports in GitHub
- Blocks deployment if critical vulnerabilities found

### Stage 3: Build and Push Images

# 🏗️ Build and Push Images Stage Configuration
# Docker image building and registry push

```yaml
build-and-push:
  name: 🏗️ Build and Push Images
  runs-on: ubuntu-latest
  needs: [test, security-scan]
  if: github.event_name == 'push' && (github.ref == 'refs/heads/main' || github.ref == 'refs/heads/develop')
```

**What it does:**
- Only runs on main/develop branches (not PRs)
- Builds Docker images for frontend and backend
- Tags images with branch name and commit SHA
- Pushes to GitHub Container Registry
- Uses layer caching for faster builds

**Image Tagging Strategy:**

# 🏷️ Docker Image Tagging Strategy
# Multiple tags for different deployment scenarios

```bash
# Images get multiple tags:
ghcr.io/your-username/repo-backend:main-a1b2c3d    # Branch + short SHA
ghcr.io/your-username/repo-backend:main           # Latest for branch
ghcr.io/your-username/repo-backend:latest         # Latest for default branch
```

### Stage 4: Update GitOps Repository

# 🔄 Update GitOps Repository Stage Configuration
# Automated GitOps manifest updates for deployment

```yaml
update-gitops:
  name: 🔄 Update GitOps Repository
  runs-on: ubuntu-latest
  needs: build-and-push
  if: github.ref == 'refs/heads/main'
```

**What it does:**
- Updates image tags in GitOps manifests
- Changes `imagePullPolicy` to `Always` for production
- Commits changes back to the repository
- Triggers ArgoCD to deploy new images

**Key Innovation:**

# 🔧 GitOps Manifest Update Process
# Automated image tag updates using yq

```bash
# Updates actual image references in GitOps files:
yq eval '.spec.template.spec.containers[0].image = "ghcr.io/repo-backend:main-a1b2c3d"' -i gitops-safe/base/backend-deployment.yaml
```

## Configure GitHub Repository Settings

### Step 6: Set Up Repository Permissions

**Required Settings:**

# ⚙️ GitHub Repository Permissions
# Automatic configuration for CI/CD workflow access

```bash
# These are automatically configured when you enable workflow permissions:
# - GITHUB_TOKEN with write access to packages
# - Permission to commit back to repository
# - Access to GitHub Container Registry
```

**Verify Settings:**
1. Repository → Settings → Actions → General
2. Workflow permissions: "Read and write permissions" ✅
3. "Allow GitHub Actions to create and approve pull requests" ✅

### Step 7: Optional - Add Custom Secrets

For production deployments, you might add:

# 🔐 Optional Custom Secrets Configuration
# Additional secrets for production deployments

```bash
# Add repository secrets (optional):
# Settings → Secrets and variables → Actions → New repository secret

SLACK_WEBHOOK_URL=https://hooks.slack.com/services/...
CUSTOM_REGISTRY_TOKEN=your-private-registry-token
DEPLOYMENT_SSH_KEY=ssh-private-key-for-deployments
```

## Test the Complete Workflow

### Step 8: Create a Feature Branch Workflow

# 🌿 Create Feature Branch Workflow
# Test CI/CD pipeline with feature branch development

```bash
# Create a feature branch
git checkout -b feature/test-pipeline

# Make a code change
echo "console.log('Pipeline test');" >> backend/server.js

# Commit and push
git add backend/server.js
git commit -m "feat: add pipeline test logging"
git push origin feature/test-pipeline
```

**Expected Behavior:**
- Tests run ✅
- Security scan runs ✅
- Images do NOT build (only main/develop builds images)
- No GitOps update (feature branches don't deploy)

### Step 9: Create a Pull Request

# 🔀 Create Pull Request
# Test CI/CD pipeline with pull request workflow

```bash
# Create PR via GitHub UI or CLI
gh pr create --title "Test: Pipeline demonstration" --body "Testing the complete CI/CD workflow"
```

**Expected Behavior:**
- Tests run on PR ✅
- Security scan runs ✅  
- Shows status checks in PR
- Blocks merge if tests fail

### Step 10: Merge and Deploy

```bash
# Merge the PR (via GitHub UI or CLI)
gh pr merge --merge

# Switch back to main
git checkout main
git pull origin main
```

**Expected Behavior:**
- Full pipeline runs ✅
- Images build and push ✅
- GitOps manifests update ✅
- ArgoCD syncs changes ✅

## Monitor and Verify Deployment

### Step 11: Check Container Registry

```bash
# View your pushed images
# Go to: github.com/YOUR_USERNAME/YOUR_REPO/packages

# Or check locally
docker pull ghcr.io/YOUR_USERNAME/devops-home-lab-2025-backend:latest
```

### Step 12: Verify GitOps Updates

```bash
# Check that GitOps manifests were updated
git log --oneline -n 5
```

**Expected Output:**
```bash
a1b2c3d 🚀 Deploy: Update images to a1b2c3d
e4f5g6h feat: add pipeline test logging
i7j8k9l test: trigger CI/CD pipeline demonstration
```

```bash
# Check the actual image tags in manifests
grep "image:" gitops-safe/base/backend-deployment.yaml
grep "image:" gitops-safe/base/frontend-deployment.yaml
```

**Expected Output:**
```yaml
image: ghcr.io/your-username/devops-home-lab-2025-backend:main-a1b2c3d
image: ghcr.io/your-username/devops-home-lab-2025-frontend:main-a1b2c3d
```

### Step 13: Verify Cluster Deployment

```bash
# Check if ArgoCD deployed the new images
kubectl describe deployment backend -n humor-game | grep Image
kubectl describe deployment frontend -n humor-game | grep Image
```

**Expected Output:**
```bash
    Image:      ghcr.io/your-username/devops-home-lab-2025-backend:main-a1b2c3d
    Image:      ghcr.io/your-username/devops-home-lab-2025-frontend:main-a1b2c3d
```

## ✅ Checkpoint

Your CI/CD pipeline is working correctly when:
- ✅ **Tests run automatically** on every push and PR
- ✅ **Security scanning** completes without blocking issues
- ✅ **Images build and push** to GitHub Container Registry on main/develop
- ✅ **GitOps manifests update** with new image tags automatically
- ✅ **ArgoCD detects changes** and syncs to cluster
- ✅ **Application pods restart** with new container images
- ✅ **Database connections** work properly with ConfigMap/Secret values
- ✅ **Pipeline provides clear feedback** on success/failure

## Understanding Pipeline Scope

### What Your CI/CD Pipeline Achieves

**✅ Complete Application Deployment:**
- **Container Images**: Built and stored in GitHub Container Registry
- **Kubernetes Deployment**: Automated via GitOps and ArgoCD
- **Database Integration**: Proper connection configuration
- **Service Discovery**: Uses Kubernetes service names
- **Configuration Management**: ConfigMaps and Secrets
- **Health Checks**: Application health monitoring

**❌ What Requires Manual Setup:**
- **Global Access**: Cloudflare tunnel setup (see Chapter 6)
- **External DNS**: Domain configuration in Cloudflare
- **SSL Certificates**: Handled by Cloudflare automatically
- **Production Monitoring**: Requires additional setup

## Troubleshooting CI/CD Issues

### Issue: Permission Denied to GitHub Container Registry

**Symptom:**
```bash
Error: failed to solve: failed to push ghcr.io/username/repo:tag: unexpected status: 403 Forbidden
```

**Fix:**
```bash
# 1. Check repository workflow permissions
# Go to Settings → Actions → General → Workflow permissions
# Select "Read and write permissions"

# 2. Ensure package exists or can be created
# Go to repository → Packages tab
# Verify no conflicting package permissions
```

### Issue: GitOps Update Fails

**Symptom:**
```bash
Error: nothing to commit, working tree clean
```

**Cause:** No actual changes in image tags

**Fix:**
```bash
# Check if image actually changed
git log --oneline | grep "Deploy:"

# Verify new images were built
# Check GitHub Packages for new tags
```

### Issue: Tests Fail in CI but Pass Locally

**Symptom:** Tests pass on your machine but fail in GitHub Actions

**Diagnosis:**
```bash
# Check test logs in GitHub Actions
# Look for environment differences:
# - Node.js version differences
# - Missing environment variables
# - Database connection issues
```

**Fix:**
```bash
# Ensure test dependencies are in package.json
cd backend && npm test

# Add test database setup if needed
# Check environment variable requirements
```

### Issue: ArgoCD Doesn't Sync New Images

**Symptom:** GitOps manifests update but ArgoCD doesn't deploy

**Diagnosis:**
```bash
# Check ArgoCD application status
kubectl get applications -n argocd

# Check if ArgoCD is polling repository
argocd app get humor-game-local --refresh
```

**Fix:**
```bash
# Manual sync if needed
argocd app sync humor-game-local

# Or enable auto-sync
kubectl patch application humor-game-local -n argocd --type='merge' -p='{"spec":{"syncPolicy":{"automated":{"selfHeal":false,"prune":false}}}}'
```

### Issue: Database Connection Fails After Deployment

**Symptom:** Application pods start but can't connect to database

**Diagnosis:**
```bash
# Check if PostgreSQL pod is running
kubectl get pods -n humor-game | grep postgres

# Check database logs
kubectl logs -n humor-game deployment/postgres

# Check backend logs for connection errors
kubectl logs -n humor-game deployment/backend
```

**Fix:**
```bash
# Verify ConfigMap and Secret exist
kubectl get configmap humor-game-config -n humor-game
kubectl get secret humor-game-secrets -n humor-game

# Check if database service is accessible
kubectl exec -n humor-game deployment/backend -- nslookup postgres

# Test database connection manually
kubectl exec -n humor-game deployment/backend -- node -e "
const { Pool } = require('pg');
const pool = new Pool({
  host: 'postgres',
  database: 'humor_memory_game',
  user: 'gameuser',
  password: 'gamepass123'
});
pool.query('SELECT NOW()').then(res => console.log('✅ DB Connected:', res.rows[0])).catch(err => console.error('❌ DB Error:', err));
"
```

## Advanced CI/CD Patterns

### Multi-Environment Deployment

```yaml
# Add staging deployment stage
deploy-staging:
  name: 🎭 Deploy to Staging
  runs-on: ubuntu-latest
  needs: build-and-push
  if: github.ref == 'refs/heads/develop'
  
  steps:
    - name: 📝 Update staging manifests
      run: |
        yq eval '.spec.template.spec.containers[0].image = "${{ env.REGISTRY }}/${{ env.IMAGE_NAME_BACKEND }}:develop-${{ steps.short-sha.outputs.sha }}"' -i gitops-safe/overlays/staging/backend-patch.yaml
```

### Deployment Approval Gates

```yaml
production-deploy:
  name: 🚀 Production Deployment
  runs-on: ubuntu-latest
  needs: deploy-staging
  environment: production  # Requires manual approval
  
  steps:
    - name: 🚀 Deploy to production
      run: |
        echo "Deploying to production..."
```

### Rollback Automation

```yaml
rollback:
  name: 🔄 Rollback on Failure
  runs-on: ubuntu-latest
  if: failure()
  
  steps:
    - name: 🔄 Revert GitOps changes
      run: |
        git revert HEAD --no-edit
        git push origin main
```

## What You Learned

You've implemented a production-grade CI/CD pipeline:

**CI/CD Fundamentals:**
- **Automated Testing**: Unit tests, linting, and quality gates
- **Security Integration**: Vulnerability scanning and compliance checks
- **Container Management**: Building, tagging, and distributing images
- **GitOps Integration**: Updating infrastructure as code automatically
- **Monitoring and Notifications**: Pipeline visibility and team communication

**Production Patterns:**
- **Branch-based Workflows**: Different behavior for feature/main/develop branches
- **Image Tagging Strategy**: Semantic versioning with commit traceability
- **Security by Default**: Automated scanning and secure credential management
- **Fail-fast Principles**: Early detection of issues before deployment
- **Audit Trails**: Complete history of deployments through Git commits

**Advanced Concepts:**
- **Multi-stage Pipelines**: Parallel execution for efficiency
- **Conditional Deployment**: Environment-specific deployment logic
- **Infrastructure as Code**: Treating deployment configuration as versioned code
- **Container Registry Management**: Secure image distribution and lifecycle

**Career-Ready Skills:**
- **DevOps Engineering**: Complete understanding of software delivery pipelines
- **Platform Engineering**: Building developer-friendly deployment experiences
- **Site Reliability**: Implementing reliable, repeatable deployment processes
- **Security Engineering**: Integrating security throughout the software lifecycle

This CI/CD implementation follows industry best practices and scales to enterprise requirements. You now understand how modern software teams deliver features safely and reliably to production.

---

**Next**: [Chapter 8: Observability](08-observability.md) - Monitor and alert on your application's health and performance
**Previous**: [Chapter 6: Production Networking and Ingress](06-ingress-networking.md) - Making your application accessible from the internet
