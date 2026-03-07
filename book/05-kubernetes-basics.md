# Chapter 5: Kubernetes Basics - Your First Deployment

*Deploy your application to a production-ready Kubernetes cluster using declarative manifests*

---

## What You'll Learn
- Create and manage a local Kubernetes cluster with k3d
- Deploy multi-service applications using Kubernetes manifests
- Configure persistent storage for databases
- Implement health checks and resource management
- Use Kustomize for configuration management

## Time Required: 60 minutes

## Prerequisites: [Chapter 4: Local Multi-Container Development](04-local-compose.md)

---

## Why This Matters

Kubernetes is the industry standard for deploying applications at scale. Companies like Netflix, Airbnb, and GitHub use Kubernetes to manage thousands of services serving millions of users. Learning Kubernetes deployment patterns is essential for any DevOps engineer.

**Career Impact**: Kubernetes skills are in high demand. DevOps engineers with Kubernetes experience earn 20-30% more than those without it, and 88% of enterprises use Kubernetes for container orchestration.

**💡 Pro Tip**: Kubernetes is like a smart manager for your applications. It automatically handles scaling, health checks, and updates while ensuring your services stay running reliably.

## Understanding Kubernetes vs Docker Compose

Before deploying, understand the key differences:

| Aspect | Docker Compose | Kubernetes |
|--------|----------------|------------|
| **Scope** | Single machine | Multi-machine cluster |
| **Networking** | Bridge networks | Pod networking + Services |
| **Storage** | Bind mounts/volumes | Persistent Volumes |
| **Scaling** | Manual | Automatic with HPA |
| **Health Checks** | Basic health checks | Liveness/Readiness probes |
| **Configuration** | Environment files | ConfigMaps and Secrets |

## Create Kubernetes Cluster

### Step 1: Create Local k3d Cluster

# 🎯 Create k3d Kubernetes Cluster
# Set up a production-like local cluster with load balancer

```bash
# Create a production-like cluster with load balancer
k3d cluster create dev-cluster \
  --servers 1 \
  --agents 2 \
  --port "8080:80@loadbalancer" \
  --port "8090:443@loadbalancer"
```

**Expected Output:**

# ✅ k3d Cluster Creation Output
# Successful cluster creation with network and load balancer setup

```bash
INFO[0000] Prep: Network                                
INFO[0001] Created network 'k3d-dev-cluster'           
INFO[0001] Created image volume k3d-dev-cluster-images  
INFO[0001] Starting cluster 'dev-cluster'                
INFO[0001] Starting servers...                          
INFO[0002] Starting agents...                            
INFO[0008] Updating the default kubeconfig with a new context for cluster "dev-cluster"
INFO[0008] You can now use it like this:                
kubectl cluster-info
```

**📚 Editor Note**: The port mappings allow external access: 8080 for HTTP traffic and 8090 for HTTPS/management interfaces.

### Step 2: Verify Cluster Health

# ☸️ Cluster Node Verification
# Check that all cluster nodes are running and ready

```bash
# Check cluster nodes
kubectl get nodes
```

**Expected Output:**

# 📊 Cluster Nodes Status
# Confirmation of 3-node cluster with control plane and worker nodes

```bash
NAME                       STATUS   ROLES                  AGE   VERSION
k3d-dev-cluster-server-0   Ready    control-plane,master   2m    v1.28.2+k3s1
k3d-dev-cluster-agent-0    Ready    <none>                 2m    v1.28.2+k3s1
k3d-dev-cluster-agent-1    Ready    <none>                 2m    v1.28.2+k3s1
```

# 🔍 Cluster Components Check
# Verify all essential Kubernetes components are running

```bash
# Verify cluster components
kubectl cluster-info
```

**Expected Output:**

# 📋 Cluster Components Status
# Confirmation of control plane, DNS, and metrics server

```bash
Kubernetes control plane is running at https://0.0.0.0:6443
CoreDNS is running at https://0.0.0.0:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://0.0.0.0:6443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy
```

[[ADD IMAGE: kubectl get nodes output showing 3-node cluster]]

## Build and Load Container Images

### Step 1: Build Application Images

Since k3d doesn't have access to Docker Hub images we haven't pushed, build locally:

# 🏗️ Build Application Images
# Create container images for backend and frontend services

```bash
# Build backend image
docker build -t humor-game-backend:latest ./backend

# Build frontend image  
docker build -t humor-game-frontend:latest ./frontend
```

**Expected Output:**

# 🏗️ Docker Build Process
# Successful build of backend container image

```bash
[+] Building 23.1s (12/12) FINISHED
 => [internal] load build definition from Dockerfile               0.1s
 => [1/7] FROM docker.io/library/node:18-alpine@sha256:...         2.1s
 => [2/7] WORKDIR /app                                             0.1s
 => [3/7] COPY package*.json ./                                    0.1s
 => [4/7] RUN npm ci --only=production                            15.2s
 => [5/7] COPY . .                                                 0.3s
 => [6/7] EXPOSE 3001                                              0.1s
 => [7/7] CMD ["npm", "start"]                                     0.1s
 => => naming to docker.io/library/humor-game-backend:latest      0.0s
```

### Step 2: Load Images into k3d

# 📦 Import Images to k3d Cluster
# Load locally built images into the Kubernetes cluster

```bash
# Load images into k3d cluster
k3d image import humor-game-backend:latest -c dev-cluster
k3d image import humor-game-frontend:latest -c dev-cluster
```

**Expected Output:**

# ✅ Image Import Success
# Confirmation that both images are available in the cluster

```bash
INFO[0000] Importing image 'humor-game-backend:latest' into cluster 'dev-cluster'...
INFO[0002] Image 'humor-game-backend:latest' imported into cluster 'dev-cluster'
INFO[0002] Importing image 'humor-game-frontend:latest' into cluster 'dev-cluster'...
INFO[0004] Image 'humor-game-frontend:latest' imported into cluster 'dev-cluster'
```

## Deploy Application Using Kubernetes Manifests

### Step 1: Create Namespace and Configuration

# 📁 Create Application Namespace
# Set up dedicated namespace for the humor game application

```bash
# Create dedicated namespace for application
kubectl apply -f k8s/namespace.yaml
```

**Expected Output:**

# ✅ Namespace Creation
# Confirmation of humor-game namespace creation

```bash
namespace/humor-game created
```

# ⚙️ Deploy Configuration and Secrets
# Apply ConfigMaps and Secrets for application configuration

```bash
# Deploy configuration and secrets
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secrets.yaml
```

**Expected Output:**

# ✅ Configuration Resources Created
# Confirmation of ConfigMaps and Secrets deployment

```bash
configmap/humor-game-config created
configmap/frontend-config created
secret/humor-game-secrets created
```

**⚠️ Important**: Ensure your `k8s/secrets.yaml` has been created from the template with real values. This file contains database passwords and should not be committed to Git in production.

### Step 2: Deploy Database Layer

# 🗄️ Deploy PostgreSQL Database
# Deploy PostgreSQL with persistent volume for data storage

```bash
# Deploy PostgreSQL with persistent storage
kubectl apply -f k8s/postgres.yaml
```

**Expected Output:**

# ✅ PostgreSQL Resources Created
# Confirmation of PVC, Deployment, and Service creation

```bash
persistentvolumeclaim/postgres-pvc created
deployment.apps/postgres created
service/postgres created
```

# 🔴 Deploy Redis Cache
# Deploy Redis with persistent storage for caching

```bash
# Deploy Redis cache
kubectl apply -f k8s/redis.yaml
```

**Expected Output:**

# ✅ Redis Resources Created
# Confirmation of Redis PVC, Deployment, and Service

```bash
persistentvolumeclaim/redis-pvc created
deployment.apps/redis created
service/redis created
```

# ⏳ Wait for Database Readiness
# Ensure PostgreSQL and Redis are fully initialized before proceeding

```bash
# Wait for databases to be ready
echo "Waiting for databases to initialize..."
kubectl wait --for=condition=Ready pods -l app=postgres -n humor-game --timeout=300s
kubectl wait --for=condition=Ready pods -l app=redis -n humor-game --timeout=300s
```

**Expected Output:**

# ✅ Database Pods Ready
# Confirmation that PostgreSQL and Redis pods are running

```bash
pod/postgres-7c8b9d4f6d-xyz12 condition met
pod/redis-849d7b8c5f-abc34 condition met
```

### Step 3: Deploy Application Layer

# 🚀 Deploy Backend API
# Deploy the Node.js backend service

```bash
# Deploy backend API
kubectl apply -f k8s/backend.yaml
```

**Expected Output:**

# ✅ Backend Resources Created
# Confirmation of backend Deployment and Service

```bash
deployment.apps/backend created
service/backend created
```

# 🌐 Deploy Frontend Application
# Deploy the nginx frontend service

```bash
# Deploy frontend
kubectl apply -f k8s/frontend.yaml
```

**Expected Output:**

# ✅ Frontend Resources Created
# Confirmation of frontend Deployment and Service

```bash
deployment.apps/frontend created
service/frontend created
```

# ⏳ Wait for Application Readiness
# Ensure backend and frontend pods are fully ready

```bash
# Wait for application pods to be ready
kubectl wait --for=condition=Ready pods -l app=backend -n humor-game --timeout=300s
kubectl wait --for=condition=Ready pods -l app=frontend -n humor-game --timeout=300s
```

## Verify Deployment

### Step 1: Check Pod Status

# 📊 Check Pod Status
# Verify all application pods are running successfully

```bash
# Check all pods in the namespace
kubectl get pods -n humor-game
```

**Expected Output:**

# 📊 Pod Status Overview
# All application pods running with healthy status

```bash
NAME                        READY   STATUS    RESTARTS   AGE
postgres-7c8b9d4f6d-xyz12   1/1     Running   0          5m
redis-849d7b8c5f-abc34      1/1     Running   0          5m
backend-6d7f8b9c4e-def56    1/1     Running   0          3m
frontend-5a6b7c8d9e-ghi78   1/1     Running   0          3m
```

**✅ Success Criteria**: All pods show `1/1 Running` status with 0 or minimal restarts.

### Step 2: Check Services

# 🔗 Check Service Status
# Verify all services are created and have ClusterIP addresses

```bash
# Verify services are created
kubectl get services -n humor-game
```

**Expected Output:**

# 🔗 Service Status Overview
# All services created with ClusterIP addresses for internal communication

```bash
NAME       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
postgres   ClusterIP   10.43.123.45    <none>        5432/TCP   5m
redis      ClusterIP   10.43.234.56    <none>        6379/TCP   5m
backend    ClusterIP   10.43.345.67    <none>        3001/TCP   3m
frontend   ClusterIP   10.43.456.78    <none>        80/TCP     3m
```

### Step 3: Check Persistent Storage

# 💾 Check Persistent Storage
# Verify PVCs are bound to persistent volumes

```bash
# Verify persistent volumes are bound
kubectl get pvc -n humor-game
```

**Expected Output:**

# 💾 Persistent Volume Claims Status
# Confirmation that PVCs are bound to local-path storage

```bash
NAME           STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
postgres-pvc   Bound    pvc-12345678-abcd-efgh-ijkl-123456789012   5Gi        RWO            local-path     5m
redis-pvc      Bound    pvc-87654321-zyxw-vutr-qpon-098765432109   1Gi        RWO            local-path     5m
```

## Test Application Functionality

### Step 1: Test Backend Health

# 🏥 Test Backend Health Endpoint
# Port-forward to backend and test health check

```bash
# Port-forward to backend service
kubectl port-forward svc/backend -n humor-game 3001:3001 &

# Test health endpoint
curl -s http://localhost:3001/api/health | jq .
```

**Expected Output:**

# ✅ Backend Health Response
# JSON response confirming all services are healthy

```json
{
  "status": "healthy",
  "services": {
    "database": "connected",
    "redis": "connected"
  },
  "timestamp": "2025-01-15T10:30:00.000Z",
  "uptime": "00:03:45"
}
```

**💡 Pro Tip**: The health endpoint validates both database and Redis connectivity, which is crucial for Kubernetes readiness probes.

### Step 2: Test Database Connectivity

# 🗄️ Test PostgreSQL Connection
# Verify database connectivity from within the cluster

```bash
# Test PostgreSQL connection
kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -d humor_memory_game -c "SELECT version();"
```

**Expected Output:**

# 📊 PostgreSQL Version Check
# Confirmation of database version and connectivity

```bash
                                                             version
----------------------------------------------------------------------------------------------------------------
 PostgreSQL 15.4 on x86_64-pc-linux-gnu, compiled by gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924, 64-bit
(1 row)
```

# 📋 Verify Database Schema
# Check that all required tables exist in PostgreSQL

```bash
# Verify database schema
kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -d humor_memory_game -c "\dt"
```

**Expected Output:**

# 📊 Database Tables List
# Confirmation of all application tables in PostgreSQL

```bash
               List of relations
 Schema |     Name      | Type  |  Owner
--------+---------------+-------+----------
 public | game_sessions | table | gameuser
 public | leaderboard   | table | gameuser
 public | users         | table | gameuser
(3 rows)
```

### Step 3: Test Frontend Access

# 🌐 Test Frontend Access
# Port-forward to frontend and verify HTML content

```bash
# Kill previous port-forward and start frontend
pkill -f "port-forward.*3001"
kubectl port-forward svc/frontend -n humor-game 3000:80 &

# Test frontend content
curl -s http://localhost:3000 | grep -o "<title>.*</title>"
```

**Expected Output:**

# 📄 Frontend HTML Title
# Confirmation that frontend is serving the correct HTML

```html
<title>Humor Memory Game</title>
```

[[ADD IMAGE: Browser screenshot showing game interface via port-forward]]

## Understanding Kubernetes Configuration with Kustomize

### Step 1: Examine Kustomize Structure

Your project uses Kustomize for configuration management:

# 📋 Examine Kustomize Configuration
# Review the base Kustomize configuration structure

```bash
# View the base kustomization
cat gitops-safe/base/kustomization.yaml
```

**Expected Output:**

# 📋 Kustomize Base Configuration
# Complete base configuration with all application resources

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

metadata:
  name: humor-game-base
  namespace: humor-game

resources:
- configmap.yaml
- pvc.yaml
- postgres-deployment.yaml
- postgres-service.yaml
- redis-deployment.yaml
- redis-service.yaml
- backend-deployment.yaml
- backend-service.yaml
- frontend-deployment.yaml
- frontend-service.yaml
```

### Step 2: Test Kustomize Build

# 🔧 Test Kustomize Build
# Build the complete configuration using Kustomize

```bash
# Build configuration with kustomize
kubectl kustomize gitops-safe/base/
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
# ... more resources
```

**📚 Editor Note**: Kustomize allows you to build different configurations for different environments (dev, staging, prod) from the same base manifests, which is more maintainable than using Helm templates.

## Resource Management and Scaling

### Step 1: Check Resource Usage

```bash
# Monitor resource consumption
kubectl top pods -n humor-game
```

**Expected Output:**
```bash
NAME                        CPU(cores)   MEMORY(bytes)
backend-6d7f8b9c4e-def56    15m          45Mi
frontend-5a6b7c8d9e-ghi78   1m           8Mi
postgres-7c8b9d4f6d-xyz12   25m          35Mi
redis-849d7b8c5f-abc34      5m           12Mi
```

### Step 2: Examine Resource Limits

```bash
# Check resource limits and requests
kubectl describe pod -l app=backend -n humor-game | grep -A 5 "Limits:\|Requests:"
```

**Expected Output:**
```bash
    Limits:
      cpu:     500m
      memory:  512Mi
    Requests:
      cpu:     100m
      memory:  128Mi
```

### Step 3: Test Manual Scaling

```bash
# Scale backend to 2 replicas
kubectl scale deployment backend --replicas=2 -n humor-game

# Verify scaling
kubectl get pods -l app=backend -n humor-game
```

**Expected Output:**
```bash
NAME                        READY   STATUS    RESTARTS   AGE
backend-6d7f8b9c4e-def56    1/1     Running   0          10m
backend-6d7f8b9c4e-new789   1/1     Running   0          30s
```

## ✅ Checkpoint

Your Kubernetes deployment is successful when:
- ✅ All 4 pods show `Running` status with `1/1` ready
- ✅ All services have `ClusterIP` assignments  
- ✅ Persistent volumes are `Bound` and have storage allocated
- ✅ Backend health check returns `{"status": "healthy"}`
- ✅ Database contains expected schema (users, game_sessions, leaderboard)
- ✅ Frontend serves HTML content with correct title
- ✅ Resource usage is reasonable (< 100MB per service)

## Troubleshooting Common Issues

### Issue: Pods Stuck in Pending

**Symptom:**
```bash
NAME                        READY   STATUS    RESTARTS   AGE
backend-6d7f8b9c4e-def56    0/1     Pending   0          5m
```

**Diagnosis:**
```bash
# Check pod events
kubectl describe pod -l app=backend -n humor-game

# Check node resources
kubectl describe nodes
```

**Common Causes:**
- Insufficient cluster resources
- Image pull failures
- Persistent volume issues

**Fix:**
```bash
# Check available resources
kubectl top nodes

# Restart cluster if needed
k3d cluster stop dev-cluster
k3d cluster start dev-cluster
```

### Issue: CrashLoopBackOff

**Symptom:**
```bash
NAME                        READY   STATUS             RESTARTS   AGE
backend-6d7f8b9c4e-def56    0/1     CrashLoopBackOff   3          5m
```

**Diagnosis:**
```bash
# Check pod logs
kubectl logs deployment/backend -n humor-game

# Check previous container logs
kubectl logs deployment/backend -n humor-game --previous
```

**Common Causes:**
- Database connection failures
- Missing environment variables
- Application startup errors

**Fix:**
```bash
# Verify database is ready
kubectl get pods -l app=postgres -n humor-game

# Check configuration
kubectl get configmap humor-game-config -n humor-game -o yaml

# Restart deployment
kubectl rollout restart deployment/backend -n humor-game
```

### Issue: Service Not Accessible

**Symptom:** Port-forward fails or returns connection errors

**Diagnosis:**
```bash
# Check service endpoints
kubectl get endpoints -n humor-game

# Verify service selector matches pod labels
kubectl get pods -n humor-game --show-labels
kubectl describe svc backend -n humor-game
```

**Fix:**
```bash
# Ensure labels match between service and deployment
# Check k8s/backend.yaml for selector consistency
```

## Clean Up Resources

### Graceful Cleanup

```bash
# Stop port-forwards
pkill -f port-forward

# Delete application resources
kubectl delete namespace humor-game

# Verify cleanup
kubectl get pods -n humor-game
```

**Expected Output:**
```bash
No resources found in humor-game namespace.
```

### Complete Cluster Reset

```bash
# Delete entire cluster if needed
k3d cluster delete dev-cluster

# Recreate for fresh start
k3d cluster create dev-cluster \
  --servers 1 \
  --agents 2 \
  --port "8080:80@loadbalancer" \
  --port "8090:443@loadbalancer"
```

## What You Learned

You've successfully deployed a production-ready application to Kubernetes:

**Kubernetes Fundamentals:**
- **Cluster Management**: Created and managed multi-node k3d cluster
- **Resource Deployment**: Applied manifests for namespaces, deployments, services
- **Persistent Storage**: Configured PVCs for database persistence
- **Configuration Management**: Used ConfigMaps and Secrets for environment variables
- **Networking**: Implemented service discovery and internal communication

**Production Patterns:**
- **Health Checks**: Implemented readiness and liveness probes
- **Resource Limits**: Configured CPU and memory constraints
- **Image Management**: Built and loaded custom application images
- **Scaling**: Manual replica scaling for high availability
- **Security**: Namespace isolation and proper secret handling

**Configuration Management:**
- **Kustomize**: Declarative configuration management for different environments
- **GitOps Ready**: Structure that supports automated deployment workflows
- **Environment Separation**: Base configurations with overlay capabilities

**Operational Skills:**
- **Troubleshooting**: Systematic diagnosis of pod and service issues
- **Monitoring**: Resource usage tracking and performance analysis
- **Debugging**: Log analysis and event inspection techniques

This Kubernetes deployment provides the foundation for production operations. You now understand how applications run in orchestrated environments and can manage complex, multi-service systems reliably.

---

**Next**: [Chapter 6: Production Networking and Ingress](06-ingress-networking.md) - Make your application accessible from the internet
**Previous**: [Chapter 4: Local Multi-Container Development](04-local-compose.md) - Testing your application stack locally
