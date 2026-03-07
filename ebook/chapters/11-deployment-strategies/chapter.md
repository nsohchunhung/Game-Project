# Chapter 11: Deployment Strategies

*Implement zero-downtime deployment patterns for reliable production releases*

---

## What You'll Learn
- Understand different deployment strategies and their use cases
- Implement rolling updates with Kubernetes
- Configure readiness and liveness probes for safe deployments
- Test deployment rollback procedures
- Design deployment strategies for different application types

## Time Required: 30 minutes

## Prerequisites: [Chapter 10: Production Hardening and Security](10-prod-hardening.md)

---

## Why This Matters

How you deploy applications determines whether your users experience downtime during updates. Professional deployment strategies ensure continuous availability while reducing the risk of introducing bugs to production.

**Professional Context**: Companies like Netflix deploy thousands of times per day using sophisticated deployment strategies. Understanding these patterns is essential for any production system.

**💡 Pro Tip**: The best deployment strategy depends on your application architecture, user tolerance for downtime, and rollback requirements.

## Understanding Deployment Strategies

### Deployment Strategy Comparison

| Strategy | Downtime | Resource Usage | Rollback Speed | Risk | Use Case |
|----------|----------|----------------|----------------|------|----------|
| **Recreate** | High | Low | Fast | High | Development |
| **Rolling Update** | None | Medium | Medium | Medium | Most applications |
| **Blue-Green** | None | High | Instant | Low | Critical systems |
| **Canary** | None | Medium | Medium | Low | Risk-averse |

### Current Implementation

Your Kubernetes deployment already uses **Rolling Updates** by default:

```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 25%
    maxSurge: 25%
```

## Examine Current Rolling Update Strategy

### Step 1: Check Current Deployment Strategy

```bash
# Check current deployment strategy
kubectl describe deployment backend -n humor-game | grep -A 5 "StrategyType"
```

**Expected Output:**
```bash
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
```

```bash
# Check rollout history
kubectl rollout history deployment/backend -n humor-game
```

**Expected Output:**
```bash
deployment.apps/backend 
REVISION  CHANGE-CAUSE
1         <none>
```

### Step 2: Examine Health Checks

```bash
# Check readiness and liveness probes
kubectl describe deployment backend -n humor-game | grep -A 10 "Liveness\|Readiness"
```

**Expected Output:**
```bash
    Liveness:     http-get http://:3001/api/health delay=30s timeout=5s period=10s #success=1 #failure=3
    Readiness:    http-get http://:3001/api/health delay=10s timeout=5s period=5s #success=1 #failure=3
```

## Test Rolling Update Deployment

### Step 3: Trigger a Rolling Update

```bash
# Update backend with a new environment variable to trigger rolling update
kubectl patch deployment backend -n humor-game -p='{"spec":{"template":{"metadata":{"annotations":{"deployment.kubernetes.io/revision":"2"}}}}}'
```

**Expected Output:**
```bash
deployment.apps/backend patched
```

```bash
# Watch the rolling update in real-time
kubectl rollout status deployment/backend -n humor-game -w
```

**Expected Output:**
```bash
Waiting for deployment "backend" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "backend" rollout to finish: 1 old replicas are pending termination...
deployment "backend" successfully rolled out
```

### Step 4: Monitor Pod Transitions

```bash
# In another terminal, watch pods during rollout
kubectl get pods -n humor-game -l app=backend -w
```

**Expected to see:**
```bash
NAME                       READY   STATUS    RESTARTS   AGE
backend-7c8b9d4f6d-old12   1/1     Running   0          5m
backend-9f2c4e8a1b-new34   0/1     Pending   0          0s
backend-9f2c4e8a1b-new34   0/1     ContainerCreating   0          1s
backend-9f2c4e8a1b-new34   1/1     Running   0          15s
backend-7c8b9d4f6d-old12   1/1     Terminating   0          5m
```

**💡 Pro Tip**: Notice how the new pod becomes ready before the old pod terminates. This ensures zero downtime.

## Implement Advanced Health Checks

### Step 5: Configure Startup Probes

```bash
# Add startup probe for slow-starting applications
cat > startup-probe-patch.yaml << 'EOF'
spec:
  template:
    spec:
      containers:
      - name: backend
        startupProbe:
          httpGet:
            path: /api/health
            port: 3001
          initialDelaySeconds: 10
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 10
EOF

kubectl patch deployment backend -n humor-game --patch-file startup-probe-patch.yaml
```

### Step 6: Test Health Check Behavior

```bash
# Simulate an unhealthy application
kubectl exec deployment/backend -n humor-game -- kill -STOP 1

# Watch how Kubernetes handles the unhealthy pod
kubectl get pods -n humor-game -l app=backend -w
```

**Expected behavior:** Kubernetes will mark the pod as not ready and eventually restart it.

```bash
# Restore the application
kubectl exec deployment/backend -n humor-game -- kill -CONT 1
```

## Configure Blue-Green Deployment (Simulation)

### Step 7: Simulate Blue-Green Strategy

```bash
# Create a "green" version of your deployment
kubectl get deployment backend -n humor-game -o yaml > backend-green.yaml

# Edit the green deployment
sed -i 's/name: backend/name: backend-green/g' backend-green.yaml
sed -i 's/app: backend/app: backend-green/g' backend-green.yaml

# Deploy green version
kubectl apply -f backend-green.yaml
```

### Step 8: Test Blue-Green Switch

```bash
# Check both versions are running
kubectl get pods -n humor-game -l app=backend
kubectl get pods -n humor-game -l app=backend-green
```

```bash
# Switch traffic by updating service selector
kubectl patch service backend -n humor-game -p='{"spec":{"selector":{"app":"backend-green"}}}'

# Test the switch
curl -H "Host: localhost" http://localhost:8080/api/health
```

```bash
# Switch back to blue (original)
kubectl patch service backend -n humor-game -p='{"spec":{"selector":{"app":"backend"}}}'

# Clean up green deployment
kubectl delete deployment backend-green -n humor-game
```

## Implement Canary Deployment Pattern

### Step 9: Set Up Canary Deployment

```bash
# Scale down main deployment
kubectl scale deployment backend --replicas=2 -n humor-game

# Create canary deployment (1 replica with new version)
cat > backend-canary.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend-canary
  namespace: humor-game
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
      version: canary
  template:
    metadata:
      labels:
        app: backend
        version: canary
    spec:
      containers:
      - name: backend
        image: humor-game-backend:latest
        env:
        - name: CANARY_VERSION
          value: "true"
        # ... rest of container spec similar to main deployment
EOF

kubectl apply -f backend-canary.yaml
```

### Step 10: Test Canary Traffic Distribution

```bash
# Check traffic distribution (should be ~33% canary, 67% main)
for i in {1..10}; do
  kubectl exec deployment/backend -n humor-game -- curl -s http://backend:3001/api/health | grep -o '"version":"[^"]*"' || echo "main"
done
```

**Expected:** Mix of main and canary responses

## Configure Deployment Rollback

### Step 11: Test Deployment Rollback

```bash
# Check rollout history
kubectl rollout history deployment/backend -n humor-game
```

```bash
# Simulate a bad deployment
kubectl set image deployment/backend backend=nginx:alpine -n humor-game

# Watch it fail
kubectl rollout status deployment/backend -n humor-game --timeout=60s
```

**Expected:** Deployment will hang because nginx doesn't pass health checks

```bash
# Rollback to previous version
kubectl rollout undo deployment/backend -n humor-game

# Verify rollback
kubectl rollout status deployment/backend -n humor-game
```

**Expected Output:**
```bash
deployment "backend" successfully rolled out
```

### Step 12: Automated Rollback with Health Checks

```bash
# Configure automatic rollback on failed health checks
kubectl patch deployment backend -n humor-game -p='{"spec":{"progressDeadlineSeconds":300}}'
```

## Implement Deployment Validation

### Step 13: Create Deployment Tests

```bash
# Create smoke test script
cat > deployment-smoke-test.sh << 'EOF'
#!/bin/bash
set -e

echo "Running deployment smoke tests..."

# Test health endpoint
HEALTH_RESPONSE=$(curl -s -w "%{http_code}" http://localhost:8080/api/health -o /tmp/health_response)
if [ "$HEALTH_RESPONSE" != "200" ]; then
    echo "Health check failed with status: $HEALTH_RESPONSE"
    exit 1
fi

# Test frontend
FRONTEND_RESPONSE=$(curl -s -w "%{http_code}" http://localhost:8080 -o /tmp/frontend_response)
if [ "$FRONTEND_RESPONSE" != "200" ]; then
    echo "Frontend check failed with status: $FRONTEND_RESPONSE"
    exit 1
fi

# Test API functionality
API_RESPONSE=$(curl -s -w "%{http_code}" http://localhost:8080/api/leaderboard -o /tmp/api_response)
if [ "$API_RESPONSE" != "200" ]; then
    echo "API check failed with status: $API_RESPONSE"
    exit 1
fi

echo "All smoke tests passed!"
EOF

chmod +x deployment-smoke-test.sh
```

### Step 14: Run Deployment Validation

```bash
# Run smoke tests
./deployment-smoke-test.sh
```

**Expected Output:**
```bash
Running deployment smoke tests...
All smoke tests passed!
```

## Monitoring Deployment Health

### Step 15: Monitor Deployment Metrics

```bash
# Check deployment health in Prometheus
kubectl port-forward svc/prometheus -n monitoring 9090:9090 &

# Query deployment success rate
curl -s 'http://localhost:9090/api/v1/query?query=kube_deployment_status_replicas_available{deployment="backend"}' | jq .
```

### Step 16: Set Up Deployment Alerts

```bash
# Add deployment monitoring alerts
cat > deployment-alerts.yaml << 'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: deployment-alert-rules
  namespace: monitoring
data:
  deployment.rules: |
    groups:
    - name: deployment.rules
      rules:
      - alert: DeploymentReplicasMismatch
        expr: kube_deployment_spec_replicas != kube_deployment_status_replicas_available
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: Deployment has mismatched replicas
          description: "Deployment {{ $labels.deployment }} has {{ $value }} available replicas, expected {{ $labels.spec_replicas }}"
      
      - alert: DeploymentRolloutStuck
        expr: kube_deployment_status_condition{condition="Progressing",status="false"} == 1
        for: 10m
        labels:
          severity: critical
        annotations:
          summary: Deployment rollout is stuck
          description: "Deployment {{ $labels.deployment }} rollout is not progressing"
EOF

kubectl apply -f deployment-alerts.yaml
```

## ✅ Checkpoint

Your deployment strategy is production-ready when:
- ✅ Rolling updates complete without downtime
- ✅ Health checks prevent bad deployments from receiving traffic
- ✅ Rollback procedures work quickly and reliably
- ✅ Deployment validation tests pass consistently
- ✅ Canary deployments can route percentage-based traffic
- ✅ Monitoring alerts fire for deployment issues
- ✅ Documentation covers all deployment procedures

## Troubleshooting Deployment Issues

### Issue: Rolling Update Hangs

**Symptom:** Deployment shows "Waiting for deployment rollout to finish"

**Diagnosis:**
```bash
# Check deployment events
kubectl describe deployment backend -n humor-game

# Check pod events
kubectl describe pods -l app=backend -n humor-game
```

**Common Causes:**
- Readiness probe failures
- Resource constraints
- Image pull errors

**Fix:**
```bash
# Check resource availability
kubectl top nodes

# Verify health check endpoints
kubectl logs -l app=backend -n humor-game

# Rollback if necessary
kubectl rollout undo deployment/backend -n humor-game
```

### Issue: Health Checks Fail After Deployment

**Symptom:** Pods restart frequently or show not ready

**Diagnosis:**
```bash
# Check probe configuration
kubectl describe deployment backend -n humor-game | grep -A 5 "Liveness\|Readiness"

# Check application logs
kubectl logs -l app=backend -n humor-game --previous
```

**Fix:**
```bash
# Adjust probe timing if application needs more startup time
# Verify health check endpoint works correctly
# Update application to handle health checks properly
```

### Issue: Slow Rollbacks

**Symptom:** Rollback takes too long during incidents

**Diagnosis:**
```bash
# Check rollout history size
kubectl rollout history deployment/backend -n humor-game

# Check deployment strategy settings
kubectl describe deployment backend -n humor-game | grep Strategy
```

**Fix:**
```bash
# Optimize rolling update settings
# Implement blue-green for critical applications
# Pre-position rollback versions
```

## Advanced Deployment Patterns

### Feature Flags

```bash
# Example using environment variables for feature flags
kubectl patch deployment backend -n humor-game -p='{"spec":{"template":{"spec":{"containers":[{"name":"backend","env":[{"name":"FEATURE_NEW_GAME_MODE","value":"enabled"}]}]}}}}'
```

### Multi-Region Deployments

```bash
# Example multi-region deployment coordination
# Deploy to staging region first
# Validate with automated tests
# Deploy to production regions with staggered rollout
```

### Database Migration Coordination

```bash
# Example database migration strategy
# 1. Deploy backward-compatible schema changes
# 2. Deploy application code
# 3. Remove old schema elements in next release
```

## What You Learned

You've implemented professional deployment strategies:

**Deployment Fundamentals:**
- **Rolling Updates**: Zero-downtime deployments with gradual replacement
- **Health Checks**: Preventing bad deployments from receiving traffic
- **Rollback Procedures**: Quick recovery from failed deployments
- **Deployment Validation**: Automated testing of deployment success

**Advanced Patterns:**
- **Blue-Green Deployments**: Instant traffic switching for critical systems
- **Canary Releases**: Risk mitigation through gradual rollouts
- **Feature Flags**: Decoupling deployment from feature activation
- **Multi-Environment Coordination**: Staged deployment across environments

**Operational Excellence:**
- **Monitoring and Alerting**: Visibility into deployment health
- **Automated Validation**: Smoke tests and health verification
- **Documentation**: Runbooks for deployment procedures
- **Incident Response**: Quick rollback and recovery procedures

**Career-Ready Skills:**
- **Release Engineering**: Managing complex deployment pipelines
- **Site Reliability**: Maintaining service availability during deployments
- **Risk Management**: Balancing deployment speed with reliability
- **Operational Excellence**: Building repeatable, reliable deployment processes

These deployment strategies enable you to release software safely and efficiently, maintaining high availability while minimizing risk to production systems.

---

**Next**: [Chapter 12: Troubleshooting Production Issues](12-troubleshooting.md) - Diagnose and resolve complex system problems
**Previous**: [Chapter 10: Production Hardening and Security](10-prod-hardening.md) - Securing applications for production
