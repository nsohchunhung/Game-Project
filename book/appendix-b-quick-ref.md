# Appendix B: Quick Reference Commands

*Essential commands and shortcuts for daily DevOps operations*

---

## Cluster Management

### k3d Cluster Operations
```bash
# Create cluster
k3d cluster create dev-cluster --port "8080:80@loadbalancer" --port "8090:443@loadbalancer"

# List clusters
k3d cluster list

# Start/stop cluster
k3d cluster start dev-cluster
k3d cluster stop dev-cluster

# Delete cluster
k3d cluster delete dev-cluster

# Load images into cluster
k3d image import image-name:tag -c dev-cluster
```

### kubectl Context and Configuration
```bash
# Check current context
kubectl config current-context

# List contexts
kubectl config get-contexts

# Switch context
kubectl config use-context dev-cluster

# View cluster info
kubectl cluster-info
kubectl get nodes -o wide
```

## Pod Management

### Basic Pod Operations
```bash
# List pods in all namespaces
kubectl get pods --all-namespaces

# List pods in specific namespace
kubectl get pods -n humor-game

# Describe pod (detailed info)
kubectl describe pod <pod-name> -n humor-game

# Get pod logs
kubectl logs <pod-name> -n humor-game
kubectl logs <pod-name> -n humor-game --previous
kubectl logs -l app=backend -n humor-game --tail=50

# Execute into pod
kubectl exec -it <pod-name> -n humor-game -- /bin/sh
kubectl exec -it deployment/backend -n humor-game -- /bin/bash

# Port forward to pod
kubectl port-forward pod/<pod-name> 8080:3001 -n humor-game
kubectl port-forward deployment/backend 3001:3001 -n humor-game
```

### Pod Debugging
```bash
# Watch pods in real-time
kubectl get pods -n humor-game -w

# Get pod events
kubectl get events -n humor-game --sort-by=.metadata.creationTimestamp

# Check resource usage
kubectl top pods -n humor-game
kubectl top nodes

# Debug networking
kubectl run debug-pod --image=busybox --rm -it -- sh
kubectl run netdebug --image=nicolaka/netshoot --rm -it -- bash
```

## Service and Networking

### Service Operations
```bash
# List services
kubectl get svc -n humor-game

# Describe service
kubectl describe svc <service-name> -n humor-game

# Check service endpoints
kubectl get endpoints -n humor-game

# Port forward to service
kubectl port-forward svc/<service-name> 8080:80 -n humor-game
```

### Ingress Operations
```bash
# List ingress resources
kubectl get ingress -n humor-game

# Describe ingress
kubectl describe ingress <ingress-name> -n humor-game

# Check ingress controller
kubectl get pods -n ingress-nginx
kubectl logs -l app.kubernetes.io/name=ingress-nginx -n ingress-nginx
```

### Network Policies
```bash
# List network policies
kubectl get networkpolicy -n humor-game

# Describe network policy
kubectl describe networkpolicy <policy-name> -n humor-game

# Test connectivity
kubectl exec -it deployment/backend -n humor-game -- curl http://postgres:5432
```

## Deployment Management

### Deployment Operations
```bash
# List deployments
kubectl get deployments -n humor-game

# Describe deployment
kubectl describe deployment <deployment-name> -n humor-game

# Scale deployment
kubectl scale deployment <deployment-name> --replicas=3 -n humor-game

# Restart deployment
kubectl rollout restart deployment/<deployment-name> -n humor-game

# Check rollout status
kubectl rollout status deployment/<deployment-name> -n humor-game

# View rollout history
kubectl rollout history deployment/<deployment-name> -n humor-game

# Rollback deployment
kubectl rollout undo deployment/<deployment-name> -n humor-game
```

### ConfigMaps and Secrets
```bash
# List configmaps
kubectl get configmap -n humor-game

# View configmap content
kubectl get configmap <configmap-name> -n humor-game -o yaml

# List secrets
kubectl get secrets -n humor-game

# View secret content (base64 encoded)
kubectl get secret <secret-name> -n humor-game -o yaml

# Decode secret
kubectl get secret <secret-name> -n humor-game -o jsonpath="{.data.password}" | base64 -d
```

## Storage Operations

### Persistent Volumes
```bash
# List PVCs
kubectl get pvc -n humor-game

# Describe PVC
kubectl describe pvc <pvc-name> -n humor-game

# List PVs
kubectl get pv

# Check storage classes
kubectl get storageclass
```

## Monitoring and Observability

### Prometheus Operations
```bash
# Port forward to Prometheus
kubectl port-forward svc/prometheus -n monitoring 9090:9090

# Common Prometheus queries
# up{job="humor-game-backend"}
# rate(http_requests_total[5m])
# container_memory_usage_bytes
```

### Grafana Operations
```bash
# Port forward to Grafana
kubectl port-forward svc/grafana -n monitoring 3000:3000

# Get Grafana admin password
kubectl get secret grafana-admin -n monitoring -o jsonpath="{.data.password}" | base64 -d
```

### Application Health Checks
```bash
# Test backend health
curl http://localhost:8080/api/health

# Test frontend
curl http://localhost:8080

# Test with custom host header
curl -H "Host: gameapp.local" http://localhost:8080/api/health
```

## GitOps Operations

### ArgoCD Operations
```bash
# Port forward to ArgoCD
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get ArgoCD admin password
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d

# ArgoCD CLI commands (if installed)
argocd login localhost:8080 --insecure
argocd app list
argocd app sync <app-name>
argocd app get <app-name>
```

### Kustomize Operations
```bash
# Build kustomize configuration
kubectl kustomize gitops-safe/base/
kubectl kustomize gitops-safe/overlays/dev/

# Apply kustomize build
kubectl apply -k gitops-safe/base/
kubectl apply -k gitops-safe/overlays/dev/
```

## CI/CD and Images

### Docker Operations
```bash
# Build images
docker build -t humor-game-backend:latest ./backend
docker build -t humor-game-frontend:latest ./frontend

# Tag for registry
docker tag humor-game-backend:latest ghcr.io/username/humor-game-backend:latest

# Push to registry
docker push ghcr.io/username/humor-game-backend:latest

# Load into k3d
k3d image import humor-game-backend:latest -c dev-cluster
```

### Image Management
```bash
# Update deployment image
kubectl set image deployment/backend backend=new-image:tag -n humor-game

# Check image pull status
kubectl describe pod <pod-name> -n humor-game | grep -A 5 "Events"
```

## Resource Management

### Resource Monitoring
```bash
# Check resource usage
kubectl top nodes
kubectl top pods -n humor-game

# Check resource quotas
kubectl get resourcequota -n humor-game
kubectl describe resourcequota -n humor-game

# Check HPA status
kubectl get hpa -n humor-game
kubectl describe hpa <hpa-name> -n humor-game
```

### Namespace Operations
```bash
# List namespaces
kubectl get namespaces

# Create namespace
kubectl create namespace <namespace-name>

# Delete namespace
kubectl delete namespace <namespace-name>

# Get all resources in namespace
kubectl get all -n humor-game
```

## Troubleshooting Commands

### Quick Diagnostics
```bash
# All-in-one cluster health check
kubectl get nodes && kubectl get pods --all-namespaces && kubectl get svc --all-namespaces

# Application specific health check
kubectl get pods -n humor-game && kubectl get svc -n humor-game && kubectl get ingress -n humor-game

# Recent events
kubectl get events --sort-by=.metadata.creationTimestamp | tail -10

# Resource constraints
kubectl describe nodes | grep -A 5 "Allocated resources"
```

### Log Aggregation
```bash
# Multiple pod logs
kubectl logs -l app=backend -n humor-game --tail=20
kubectl logs -l app=frontend -n humor-game --tail=20

# Follow logs
kubectl logs -f deployment/backend -n humor-game

# Logs from previous container
kubectl logs <pod-name> -n humor-game --previous
```

### Network Debugging
```bash
# DNS resolution test
kubectl run dns-test --image=busybox --rm -it -- nslookup kubernetes.default

# Service connectivity test
kubectl run connectivity-test --image=busybox --rm -it -- wget -qO- http://backend.humor-game.svc.cluster.local:3001/api/health

# Port connectivity test
kubectl run port-test --image=busybox --rm -it -- telnet backend.humor-game.svc.cluster.local 3001
```

## Makefile Shortcuts

### Project-Specific Commands
```bash
# Complete deployment
make deploy-all

# Individual components
make deploy-app
make deploy-monitoring
make deploy-gitops

# Verification
make verify
make test-endpoints

# Cleanup
make clean-app
make clean-monitoring
make clean-all

# Port forwarding
make port-forward-grafana
make port-forward-prometheus
make port-forward-argocd

# Debugging
make logs-app
make debug-pods
make status
```

## Automation Scripts

### Application Management
```bash
# Deploy with secrets
./scripts/deploy-with-secrets.sh

# Deploy environment
./scripts/deploy-env.sh

# Validate environment
./scripts/validate-env.sh

# Verify deployment
./scripts/verify.sh
```

### Monitoring and Testing
```bash
# Access monitoring services
./scripts/access-monitoring.sh

# Setup monitoring ingress
./scripts/setup-monitoring-ingress.sh

# Test metrics
./scripts/test-metrics.sh

# Test traffic
./scripts/test-traffic.sh

# Production metrics test
./scripts/production-metrics-test.sh

# Production metrics test with ingress
./scripts/production-metrics-test-ingress.sh

# Populate game metrics
./scripts/populate-game-metrics.sh
```

### GitHub Repository Setup
```bash
# Configure GitHub repository
./scripts/configure-github-repo.sh

# Regression guards
./scripts/regression-guards.sh
```

## Emergency Procedures

### Quick Recovery
```bash
# Nuclear option - restart everything
kubectl delete pods --all -n humor-game

# Rollback deployment
kubectl rollout undo deployment/<deployment-name> -n humor-game

# Scale down/up to force restart
kubectl scale deployment <deployment-name> --replicas=0 -n humor-game
kubectl scale deployment <deployment-name> --replicas=1 -n humor-game

# Cluster reset
k3d cluster delete dev-cluster
k3d cluster create dev-cluster --port "8080:80@loadbalancer"
```

### Resource Cleanup
```bash
# Clean up failed pods
kubectl delete pods --field-selector=status.phase=Failed --all-namespaces

# Clean up completed jobs
kubectl delete jobs --field-selector=status.successful=1 --all-namespaces

# Force delete stuck resources
kubectl delete pod <pod-name> --grace-period=0 --force -n humor-game
```

## Useful Aliases

Add these to your shell profile for faster operations:

```bash
# kubectl aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kdp='kubectl describe pod'
alias kl='kubectl logs'
alias kex='kubectl exec -it'
alias kpf='kubectl port-forward'

# namespace shortcuts
alias kgpn='kubectl get pods -n humor-game'
alias kgpm='kubectl get pods -n monitoring'
alias kgpa='kubectl get pods -n argocd'

# monitoring shortcuts
alias grafana='kubectl port-forward svc/grafana -n monitoring 3000:3000'
alias prometheus='kubectl port-forward svc/prometheus -n monitoring 9090:9090'
alias argocd='kubectl port-forward svc/argocd-server -n argocd 8080:443'
```

## Environment Variables

Set these for convenience:

```bash
export NAMESPACE=humor-game
export KUBECONFIG=~/.kube/config
export KUBE_EDITOR=vim
```

---

This quick reference provides the most commonly used commands for managing your DevOps environment. Bookmark this page for quick access during daily operations and troubleshooting sessions.
