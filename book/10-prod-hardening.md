# Chapter 10: Production Hardening and Security

*Secure your application for production deployment with enterprise-grade security practices*

---

## What You'll Learn
- Implement Kubernetes security contexts and resource limits
- Configure network policies for micro-segmentation
- Set up horizontal pod autoscaling (HPA) for reliability
- Apply security best practices and vulnerability management
- Build production-ready security configurations

## Time Required: 45 minutes

## Prerequisites: [Chapter 9: GitOps - Automated Deployments](09-gitops.md)

---

## Why This Matters

Security isn't optional in production. This chapter teaches you the security hardening practices used by companies handling sensitive data. A single security misconfiguration can cost companies millions in breaches and downtime.

**Professional Context**: Security is everyone's responsibility in DevOps. Platform engineers design secure defaults, and understanding these patterns is crucial for any production deployment.

**💡 Pro Tip**: Security hardening is about reducing attack surface and implementing defense-in-depth. Each layer of security makes it harder for attackers to compromise your system.

## Understanding Kubernetes Security Model

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Network       │    │   Pod Security  │    │   Resource      │
│   Policies      │    │   Context       │    │   Limits        │
│   (Network)     │    │   (Runtime)     │    │   (CPU/Memory)  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                        │                        │
         ▼                        ▼                        ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Service       │    │   RBAC          │    │   Image         │
│   Accounts      │    │   Permissions   │    │   Security      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Implement Security Contexts

### Step 1: Apply Security Contexts

```bash
# Apply security contexts to all pods
kubectl apply -f k8s/security-context.yaml
```

**Expected Output:**
```bash
deployment.apps/backend configured
deployment.apps/frontend configured
deployment.apps/postgres configured
deployment.apps/redis configured
```

### Step 2: Examine Security Context Configuration

```bash
# Check applied security contexts
kubectl describe deployment backend -n humor-game | grep -A 10 "Security Context"
```

**Expected Output:**
```bash
    Security Context:
      runAsNonRoot:             true
      runAsUser:                1001
      runAsGroup:               1001
      readOnlyRootFilesystem:   true
      allowPrivilegeEscalation: false
      capabilities:
        drop:
        - ALL
```

### Step 3: Verify Security Settings

```bash
# Test that containers run as non-root
kubectl exec deployment/backend -n humor-game -- id
```

**Expected Output:**
```bash
uid=1001 gid=1001 groups=1001
```

```bash
# Verify read-only filesystem
kubectl exec deployment/backend -n humor-game -- touch /test-file || echo "Good: Read-only filesystem working"
```

**Expected Output:**
```bash
touch: cannot touch '/test-file': Read-only file system
Good: Read-only filesystem working
```

## Configure Network Policies

### Step 4: Apply Network Policies

```bash
# Apply network micro-segmentation
kubectl apply -f k8s/network-policies.yaml
```

**Expected Output:**
```bash
networkpolicy.networking.k8s.io/deny-all created
networkpolicy.networking.k8s.io/allow-frontend-to-backend created
networkpolicy.networking.k8s.io/allow-backend-to-database created
networkpolicy.networking.k8s.io/allow-backend-to-redis created
networkpolicy.networking.k8s.io/allow-ingress-to-frontend created
networkpolicy.networking.k8s.io/allow-monitoring created
```

### Step 5: Test Network Isolation

```bash
# Test that network policies are working
# This should fail (blocked by network policy)
kubectl run test-pod --image=busybox --rm -it -- sh -c "wget -qO- --timeout=5 http://postgres.humor-game.svc.cluster.local:5432 || echo 'Connection blocked by network policy'"
```

**Expected Output:**
```bash
Connection blocked by network policy
pod "test-pod" deleted
```

```bash
# Test that legitimate traffic works
kubectl exec deployment/backend -n humor-game -- curl -s http://postgres:5432 > /dev/null && echo "Backend can reach database"
```

**Expected Output:**
```bash
Backend can reach database
```

## Set Up Resource Limits and Quotas

### Step 6: Apply Resource Limits

```bash
# Check current resource limits
kubectl describe deployment backend -n humor-game | grep -A 10 "Limits\|Requests"
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

### Step 7: Create Resource Quotas

```bash
# Create namespace resource quotas
cat > k8s/resource-quota.yaml << 'EOF'
apiVersion: v1
kind: ResourceQuota
metadata:
  name: humor-game-quota
  namespace: humor-game
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 4Gi
    limits.cpu: "4"
    limits.memory: 8Gi
    pods: "10"
    persistentvolumeclaims: "4"
    services: "5"
EOF

kubectl apply -f k8s/resource-quota.yaml
```

**Expected Output:**
```bash
resourcequota/humor-game-quota created
```

```bash
# Verify quota is applied
kubectl describe quota humor-game-quota -n humor-game
```

**Expected Output:**
```bash
Name:                   humor-game-quota
Namespace:              humor-game
Resource                Used  Hard
--------                ----  ----
limits.cpu              2     4
limits.memory           1280Mi 8Gi
pods                    4     10
requests.cpu            400m  2
requests.memory         512Mi 4Gi
```

## Implement Horizontal Pod Autoscaling

### Step 8: Deploy HPA

```bash
# Apply horizontal pod autoscaler
kubectl apply -f k8s/hpa.yaml
```

**Expected Output:**
```bash
horizontalpodautoscaler.autoscaling/backend-hpa created
horizontalpodautoscaler.autoscaling/frontend-hpa created
```

### Step 9: Verify HPA Configuration

```bash
# Check HPA status
kubectl get hpa -n humor-game
```

**Expected Output:**
```bash
NAME           REFERENCE            TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
backend-hpa    Deployment/backend   <unknown>/70%   2         10        1          1m
frontend-hpa   Deployment/frontend  <unknown>/70%   2         5         1          1m
```

**💡 Pro Tip**: `<unknown>` is normal initially. HPA needs metrics-server data which takes a few minutes to populate.

### Step 10: Test Autoscaling

```bash
# Generate load to test autoscaling (optional)
kubectl run load-generator --image=busybox --rm -it -- sh -c "while true; do wget -q -O- http://frontend.humor-game.svc.cluster.local; done"
```

**After a few minutes, check scaling:**
```bash
kubectl get hpa -n humor-game
kubectl get pods -n humor-game
```

**Expected to see additional replicas if load is high enough.**

## Secrets Management

### Step 11: Rotate Secrets

```bash
# Generate new database password
NEW_DB_PASSWORD=$(openssl rand -base64 32)

# Update secret (in production, use external secret management)
kubectl patch secret humor-game-secrets -n humor-game -p="{\"data\":{\"DB_PASSWORD\":\"$(echo -n $NEW_DB_PASSWORD | base64)\"}}"

# Restart deployments to pick up new secret
kubectl rollout restart deployment/backend -n humor-game
kubectl rollout restart deployment/postgres -n humor-game
```

### Step 12: Implement Secret Scanning

```bash
# Scan repository for leaked secrets (example with truffleHog)
# docker run --rm -v "$(pwd):/pwd" trufflesecurity/trufflehog:latest filesystem /pwd
echo "Run secret scanning in CI/CD pipeline"
```

## Image Security

### Step 13: Scan Container Images

```bash
# Scan images for vulnerabilities (example with Trivy)
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image humor-game-backend:latest

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image humor-game-frontend:latest
```

### Step 14: Implement Image Policy

```bash
# Example Pod Security Policy (deprecated) or Pod Security Standards
cat > k8s/pod-security-policy.yaml << 'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: humor-game
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
EOF

kubectl apply -f k8s/pod-security-policy.yaml
```

## Monitoring Security Events

### Step 15: Add Security Monitoring

```bash
# Add security-related Prometheus alerts
cat > k8s/security-alerts.yaml << 'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: security-alert-rules
  namespace: monitoring
data:
  security.rules: |
    groups:
    - name: security.rules
      rules:
      - alert: PodSecurityViolation
        expr: increase(pod_security_violations_total[5m]) > 0
        for: 0m
        labels:
          severity: warning
        annotations:
          summary: Pod security policy violation detected
          
      - alert: HighPrivilegedPodCount
        expr: kube_pod_container_info{container_id!="",security_context_privileged="true"} > 0
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: Privileged pod detected
          
      - alert: RootUserDetected
        expr: kube_pod_container_info{container_id!="",security_context_run_as_user="0"} > 0
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: Container running as root user detected
EOF

kubectl apply -f k8s/security-alerts.yaml
```

## Backup and Disaster Recovery

### Step 16: Implement Database Backups

```bash
# Create backup job for PostgreSQL
cat > k8s/backup-job.yaml << 'EOF'
apiVersion: batch/v1
kind: CronJob
metadata:
  name: postgres-backup
  namespace: humor-game
spec:
  schedule: "0 2 * * *"  # Daily at 2 AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: postgres-backup
            image: postgres:15-alpine
            command:
            - /bin/bash
            - -c
            - |
              pg_dump -h postgres -U gameuser -d humor_memory_game > /backup/backup-$(date +%Y%m%d-%H%M%S).sql
              # In production, upload to S3/GCS/Azure Storage
            env:
            - name: PGPASSWORD
              valueFrom:
                secretKeyRef:
                  name: humor-game-secrets
                  key: DB_PASSWORD
            volumeMounts:
            - name: backup-storage
              mountPath: /backup
          volumes:
          - name: backup-storage
            persistentVolumeClaim:
              claimName: backup-pvc
          restartPolicy: OnFailure
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: backup-pvc
  namespace: humor-game
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
EOF

kubectl apply -f k8s/backup-job.yaml
```

## Compliance and Auditing

### Step 17: Enable Audit Logging

```bash
# Audit logging is typically configured at the cluster level
# Example audit policy (would be applied to kube-apiserver)
cat > audit-policy.yaml << 'EOF'
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata
  resources:
  - group: ""
    resources: ["secrets", "configmaps"]
- level: Request
  resources:
  - group: ""
    resources: ["pods", "services"]
  namespaces: ["humor-game", "monitoring"]
EOF

echo "In production, configure kube-apiserver with:"
echo "--audit-log-path=/var/log/audit.log"
echo "--audit-policy-file=/etc/kubernetes/audit-policy.yaml"
```

### Step 18: Document Security Configurations

```bash
# Create security documentation
cat > SECURITY.md << 'EOF'
# Security Configuration

## Security Controls Implemented

### Pod Security
- Non-root user execution (UID 1001)
- Read-only root filesystem
- No privilege escalation
- Dropped all capabilities
- Resource limits enforced

### Network Security
- Network policies implementing micro-segmentation
- Ingress-only external access
- Internal service communication restricted

### Resource Management
- CPU and memory limits on all containers
- Namespace resource quotas
- Horizontal pod autoscaling

### Secrets Management
- Kubernetes secrets for sensitive data
- Regular secret rotation procedures
- No hardcoded credentials

### Image Security
- Regular vulnerability scanning
- Non-root base images
- Minimal attack surface

### Monitoring
- Security event monitoring
- Alert rules for policy violations
- Audit logging enabled

## Security Checklist

- [ ] All containers run as non-root
- [ ] Read-only filesystems enabled
- [ ] Network policies applied
- [ ] Resource limits configured
- [ ] Secrets properly managed
- [ ] Images scanned for vulnerabilities
- [ ] Monitoring and alerting active
- [ ] Backup procedures in place
- [ ] Documentation up to date

## Incident Response

In case of security incident:
1. Isolate affected components
2. Check audit logs
3. Review monitoring alerts
4. Follow incident response playbook
5. Document lessons learned
EOF
```

## ✅ Checkpoint

Your production hardening is complete when:
- ✅ All pods run with security contexts (non-root, read-only filesystem)
- ✅ Network policies enforce micro-segmentation
- ✅ Resource limits and quotas are configured
- ✅ HPA is configured and responsive to load
- ✅ Secrets are properly managed and rotated
- ✅ Images pass security scanning
- ✅ Security monitoring and alerting is active
- ✅ Backup procedures are implemented
- ✅ Security documentation is complete

## Troubleshooting Security Issues

### Issue: Pods Fail to Start After Security Context

**Symptom:**
```bash
NAME                        READY   STATUS             RESTARTS   AGE
backend-7c8b9d4f6d-xyz12    0/1     CrashLoopBackOff   3          2m
```

**Diagnosis:**
```bash
# Check pod events
kubectl describe pod -l app=backend -n humor-game

# Check logs
kubectl logs -l app=backend -n humor-game
```

**Common Causes:**
- Application needs write access to specific directories
- Process runs as root in container image
- Required file permissions

**Fix:**
```bash
# Add writable volumes for application needs
# Update Dockerfile to use non-root user
# Adjust security context if absolutely necessary
```

### Issue: Network Policy Blocks Legitimate Traffic

**Symptom:** Application components can't communicate

**Diagnosis:**
```bash
# Test connectivity between pods
kubectl exec deployment/backend -n humor-game -- curl frontend:80

# Check network policy rules
kubectl describe networkpolicy -n humor-game
```

**Fix:**
```bash
# Review and adjust network policy selectors
# Ensure all required traffic flows are allowed
# Test connectivity after changes
```

### Issue: HPA Not Scaling

**Symptom:** High load but no additional replicas

**Diagnosis:**
```bash
# Check HPA events
kubectl describe hpa backend-hpa -n humor-game

# Verify metrics server
kubectl top pods -n humor-game
```

**Fix:**
```bash
# Ensure metrics-server is installed and working
# Verify resource requests are set on containers
# Check if resource thresholds are appropriate
```

## Global Production Deployment

### Step 19: Multi-Region Deployment Strategy

**Deploy to multiple regions for high availability:**

```bash
# Primary region (East US)
kubectl config use-context east-us-cluster
kubectl apply -k gitops-safe/overlays/prod-primary/

# Secondary region (West US) 
kubectl config use-context west-us-cluster
kubectl apply -k gitops-safe/overlays/prod-secondary/
```

**Configure cross-region replication:**
```bash
# Set up database replication
kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -d humor_memory_game -c "
CREATE PUBLICATION cross_region_replication FOR ALL TABLES;
"

# Configure Redis replication
kubectl exec -it deployment/redis -n humor-game -- redis-cli CONFIG SET replicaof west-us-redis 6379
```

### Step 20: Global Load Balancing

**Configure Azure Front Door for global traffic distribution:**

```bash
# Create Front Door profile
az afd profile create \
  --profile-name gameapp-frontdoor \
  --resource-group production-rg \
  --sku Standard_AzureFrontDoor

# Configure backend pools
az afd endpoint create \
  --endpoint-name gameapp-global \
  --profile-name gameapp-frontdoor \
  --resource-group production-rg \
  --enabled-state Enabled
```

**Health probe configuration:**
```bash
# Configure health probes for automatic failover
az afd origin-group create \
  --origin-group-name gameapp-origins \
  --profile-name gameapp-frontdoor \
  --resource-group production-rg \
  --probe-path /api/health \
  --probe-protocol Http \
  --probe-interval-in-seconds 30
```

### Step 21: Disaster Recovery Testing

**Test failover procedures:**

```bash
# Simulate primary region failure
kubectl scale deployment backend --replicas=0 -n humor-game --context east-us-cluster

# Verify traffic routes to secondary region
curl https://gameapp.games/api/health

# Restore primary region
kubectl scale deployment backend --replicas=2 -n humor-game --context east-us-cluster

# Verify traffic returns to primary
curl https://gameapp.games/api/health
```

## Advanced Security Patterns

### Service Mesh Security

```bash
# Example Istio security policies (not included in basic setup)
# Would provide mutual TLS and fine-grained access control
```

### External Secret Management

```bash
# Example integration with HashiCorp Vault or AWS Secrets Manager
# kubectl apply -f https://raw.githubusercontent.com/external-secrets/external-secrets/main/deploy/crds/bundle.yaml
```

### Policy as Code

```bash
# Example OPA Gatekeeper policies
# Enforce security policies declaratively across the cluster
```

### Global Security Hardening

**Implement global security policies:**

```bash
# Apply global network policies
kubectl apply -f k8s/global-network-policies.yaml

# Configure global RBAC
kubectl apply -f k8s/global-rbac.yaml

# Set up global security scanning
kubectl apply -f k8s/security-scanning.yaml
```

## What You Learned

You've implemented comprehensive production security:

**Security Fundamentals:**
- **Runtime Security**: Security contexts and privilege restrictions
- **Network Security**: Micro-segmentation and traffic control
- **Resource Security**: Limits, quotas, and autoscaling
- **Data Security**: Secrets management and encryption

**Production Patterns:**
- **Defense in Depth**: Multiple layers of security controls
- **Least Privilege**: Minimal permissions and access rights
- **Monitoring and Alerting**: Security event detection
- **Compliance**: Audit logging and documentation

**Operational Security:**
- **Incident Response**: Procedures for security events
- **Vulnerability Management**: Image scanning and patching
- **Backup and Recovery**: Data protection strategies
- **Documentation**: Security runbooks and procedures

**Career-Ready Skills:**
- **Security Engineering**: Implementing enterprise security controls
- **Compliance**: Meeting regulatory and audit requirements
- **Risk Management**: Identifying and mitigating security risks
- **Incident Response**: Handling security events professionally

This security implementation follows industry best practices and prepares your application for production deployment with enterprise-grade security controls.

---

**Next**: [Chapter 11: Deployment Strategies](11-deployment-strategies.md) - Implement zero-downtime deployment patterns
**Previous**: [Chapter 9: GitOps - Automated Deployments](09-gitops.md) - GitOps workflows with ArgoCD
