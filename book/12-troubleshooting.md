# Chapter 12: Troubleshooting Production Issues

*Master systematic troubleshooting techniques for complex Kubernetes and application problems*

---

## What You'll Learn
- Develop systematic troubleshooting methodologies
- Use kubectl and monitoring tools for diagnosis
- Debug common Kubernetes and application issues
- Build troubleshooting runbooks and documentation
- Practice incident response procedures

## Time Required: 45 minutes

## Prerequisites: [Chapter 11: Deployment Strategies](11-deployment-strategies.md)

---

## Why This Matters

Production systems fail in complex ways. The ability to quickly diagnose and resolve issues is what separates experienced engineers from beginners. This chapter teaches you the systematic approach that professionals use to handle production incidents.

**Professional Context**: Mean Time To Recovery (MTTR) is a key SRE metric. Companies measure engineer effectiveness by how quickly they can diagnose and fix production issues.

**💡 Pro Tip**: Good troubleshooting is about following a systematic methodology, not just trying random fixes. Professionals gather information first, then form hypotheses.

## Systematic Troubleshooting Methodology

### The OODA Loop for Troubleshooting

```
Observe → Orient → Decide → Act
    ↑                        ↓
    ←――――――――――――――――――――――――――
```

1. **Observe**: Gather symptoms and data
2. **Orient**: Form hypotheses based on evidence
3. **Decide**: Choose the most likely cause to investigate
4. **Act**: Test the hypothesis and gather more data

## Essential Troubleshooting Commands

### Step 1: Master Core Diagnostic Commands

```bash
# Cluster health overview
kubectl get nodes
kubectl get pods --all-namespaces
kubectl get events --sort-by=.metadata.creationTimestamp

# Application health
kubectl get pods -n humor-game
kubectl describe pods -n humor-game
kubectl logs -l app=backend -n humor-game --tail=50

# Service connectivity
kubectl get svc -n humor-game
kubectl get endpoints -n humor-game
kubectl describe ingress -n humor-game
```

### Step 2: Create Troubleshooting Toolkit

```bash
# Create troubleshooting script
cat > troubleshoot.sh << 'EOF'
#!/bin/bash

echo "=== Kubernetes Troubleshooting Toolkit ==="
echo

echo "1. Cluster Status:"
kubectl get nodes -o wide
echo

echo "2. Application Pods:"
kubectl get pods -n humor-game -o wide
echo

echo "3. Recent Events:"
kubectl get events -n humor-game --sort-by=.metadata.creationTimestamp | tail -10
echo

echo "4. Service Endpoints:"
kubectl get endpoints -n humor-game
echo

echo "5. Resource Usage:"
kubectl top pods -n humor-game 2>/dev/null || echo "Metrics server not available"
echo

echo "6. Ingress Status:"
kubectl describe ingress -n humor-game | grep -A 5 "Rules\|Events"
EOF

chmod +x troubleshoot.sh
```

## Common Issue Categories and Solutions

### Category 1: Pod Issues

#### Issue: Pods Stuck in Pending

**Symptoms:**
```bash
NAME                        READY   STATUS    RESTARTS   AGE
backend-7c8b9d4f6d-xyz12    0/1     Pending   0          5m
```

**Diagnostic Commands:**
```bash
# Check pod events
kubectl describe pod backend-7c8b9d4f6d-xyz12 -n humor-game

# Check node resources
kubectl describe nodes
kubectl top nodes
```

**Common Causes & Fixes:**

```bash
# 1. Insufficient resources
kubectl describe nodes | grep -A 5 "Allocated resources"

# Fix: Scale down other workloads or add nodes
kubectl scale deployment backend --replicas=1 -n humor-game

# 2. Node selector issues
kubectl describe pod backend-7c8b9d4f6d-xyz12 -n humor-game | grep "Node-Selectors"

# Fix: Remove invalid node selectors or label nodes correctly

# 3. PVC binding issues
kubectl get pvc -n humor-game
kubectl describe pvc postgres-pvc -n humor-game
```

#### Issue: CrashLoopBackOff

**Symptoms:**
```bash
NAME                        READY   STATUS             RESTARTS   AGE
backend-7c8b9d4f6d-xyz12    0/1     CrashLoopBackOff   5          10m
```

**Diagnostic Commands:**
```bash
# Check container logs
kubectl logs backend-7c8b9d4f6d-xyz12 -n humor-game
kubectl logs backend-7c8b9d4f6d-xyz12 -n humor-game --previous

# Check container exit codes
kubectl describe pod backend-7c8b9d4f6d-xyz12 -n humor-game | grep "Exit Code"
```

**Common Causes & Fixes:**

```bash
# 1. Application startup failure
kubectl logs backend-7c8b9d4f6d-xyz12 -n humor-game | grep -i error

# Fix: Check environment variables and dependencies
kubectl describe pod backend-7c8b9d4f6d-xyz12 -n humor-game | grep -A 10 "Environment"

# 2. Database connection issues
kubectl logs backend-7c8b9d4f6d-xyz12 -n humor-game | grep -i "database\|postgres"

# Fix: Verify database pod and service
kubectl get pods -l app=postgres -n humor-game
kubectl get svc postgres -n humor-game

# 3. Missing secrets or config
kubectl get secrets -n humor-game
kubectl get configmap -n humor-game
```

### Category 2: Networking Issues

#### Issue: Service Not Accessible

**Symptoms:** Cannot reach application via ingress or service

**Diagnostic Commands:**
```bash
# Test service connectivity
kubectl run debug-pod --image=busybox --rm -it -- sh

# Inside debug pod:
# wget -qO- --timeout=5 http://backend.humor-game.svc.cluster.local:3001/api/health
# nslookup backend.humor-game.svc.cluster.local
```

**Common Causes & Fixes:**

```bash
# 1. Service selector mismatch
kubectl describe svc backend -n humor-game | grep "Selector"
kubectl get pods -n humor-game --show-labels | grep backend

# Fix: Update service selector to match pod labels

# 2. Endpoints not ready
kubectl get endpoints backend -n humor-game

# Fix: Check pod readiness probes
kubectl describe pods -l app=backend -n humor-game | grep -A 5 "Readiness"

# 3. Network policy blocking traffic
kubectl get networkpolicy -n humor-game
kubectl describe networkpolicy -n humor-game
```

#### Issue: Ingress Not Working

**Symptoms:** 404 or connection refused from external access

**Diagnostic Commands:**
```bash
# Check ingress controller
kubectl get pods -n ingress-nginx
kubectl logs -l app.kubernetes.io/name=ingress-nginx -n ingress-nginx

# Check ingress resource
kubectl describe ingress humor-game-ingress -n humor-game
```

**Fixes:**
```bash
# 1. Verify ingress controller is running
kubectl get svc -n ingress-nginx

# 2. Check ingress rules
kubectl get ingress -n humor-game -o yaml

# 3. Test with port-forward as bypass
kubectl port-forward svc/frontend -n humor-game 8080:80
curl http://localhost:8080
```

### Category 3: Storage Issues

#### Issue: PVC Stuck in Pending

**Symptoms:**
```bash
NAME           STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
postgres-pvc   Pending                                      local-path     5m
```

**Diagnostic Commands:**
```bash
# Check PVC events
kubectl describe pvc postgres-pvc -n humor-game

# Check storage class
kubectl get storageclass
kubectl describe storageclass local-path
```

**Fixes:**
```bash
# 1. Check if storage provisioner is running
kubectl get pods -n kube-system | grep local-path

# 2. Verify PVC specification
kubectl get pvc postgres-pvc -n humor-game -o yaml

# 3. Check node disk space
kubectl describe nodes | grep -A 5 "System Info"
```

### Category 4: Performance Issues

#### Issue: High Response Times

**Symptoms:** Application responds slowly

**Diagnostic Commands:**
```bash
# Check resource usage
kubectl top pods -n humor-game
kubectl top nodes

# Check application metrics
curl http://localhost:8080/api/health
curl http://localhost:8080/metrics
```

**Investigation Steps:**
```bash
# 1. Database performance
kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -d humor_memory_game -c "SELECT * FROM pg_stat_activity;"

# 2. Cache hit rates
kubectl exec -it deployment/redis -n humor-game -- redis-cli info stats

# 3. Application logs for slow queries
kubectl logs -l app=backend -n humor-game | grep -i "slow\|timeout"
```

## Incident Response Procedures

### Step 3: Create Incident Response Runbook

```bash
cat > incident-response.md << 'EOF'
# Incident Response Runbook

## Severity Levels

### Critical (P1)
- Application completely down
- Data loss or corruption
- Security breach

### High (P2)
- Significant feature degradation
- Performance issues affecting users
- Failed deployments

### Medium (P3)
- Minor feature issues
- Monitoring alerts
- Capacity concerns

## Response Procedures

### Initial Response (First 5 minutes)
1. **Acknowledge incident** in monitoring system
2. **Gather initial symptoms** using troubleshooting toolkit
3. **Check recent changes** (deployments, config changes)
4. **Establish communication channel** (Slack, incident room)

### Investigation Phase (5-30 minutes)
1. **Run systematic diagnostics**
2. **Form hypotheses** based on evidence
3. **Test hypotheses** with minimal changes
4. **Document findings** for team awareness

### Resolution Phase
1. **Implement fix** with approval if needed
2. **Verify resolution** with monitoring and tests
3. **Monitor for regression** for 30 minutes
4. **Update incident status**

### Post-Incident
1. **Document timeline** and root cause
2. **Identify prevention measures**
3. **Update runbooks** with new learnings
4. **Schedule post-mortem** if critical
EOF
```

### Step 4: Practice Common Scenarios

#### Scenario 1: Database Connection Lost

```bash
# Simulate database issue
kubectl scale deployment postgres --replicas=0 -n humor-game

# Observe impact
kubectl get pods -n humor-game
curl http://localhost:8080/api/health

# Diagnose and fix
kubectl logs -l app=backend -n humor-game --tail=10
kubectl scale deployment postgres --replicas=1 -n humor-game
kubectl wait --for=condition=Ready pods -l app=postgres -n humor-game --timeout=300s
```

#### Scenario 2: Memory Pressure

```bash
# Simulate memory pressure (careful in production!)
kubectl run memory-hog --image=progrium/stress --rm -it -- --vm 1 --vm-bytes 2G --timeout 60s

# Monitor impact
kubectl top nodes
kubectl get pods -n humor-game
```

#### Scenario 3: Image Pull Failure

```bash
# Simulate bad image
kubectl set image deployment/backend backend=nonexistent:latest -n humor-game

# Observe and rollback
kubectl get pods -n humor-game -w
kubectl rollout undo deployment/backend -n humor-game
```

## Advanced Debugging Techniques

### Step 5: Debug Pod Filesystem

```bash
# Access pod filesystem for debugging
kubectl exec -it deployment/backend -n humor-game -- sh

# Inside pod:
# ps aux                    # Check running processes
# netstat -tulpn           # Check listening ports
# df -h                    # Check disk usage
# cat /proc/meminfo        # Check memory usage
# env                      # Check environment variables
```

## GitOps Troubleshooting

### Issue: ArgoCD Application Stuck in "OutOfSync"

**Symptom:**
```bash
# ArgoCD shows application as OutOfSync
kubectl get applications -n argocd
```

**Diagnosis:**
```bash
# Check ArgoCD application status
kubectl describe application humor-game-app -n argocd

# Check sync status
kubectl get application humor-game-app -n argocd -o yaml | grep -A 10 "status"
```

**Common Causes & Fixes:**

```bash
# 1. Git repository access issues
# Check repository connectivity
kubectl logs -l app.kubernetes.io/name=argocd-server -n argocd | grep -i "repository"

# Fix: Verify Git repository URL and credentials
kubectl get secret argocd-repo -n argocd -o yaml

# 2. Kustomize build failures
# Check Kustomize build
kubectl kustomize gitops-safe/base/

# Fix: Verify Kustomize configuration
kubectl describe application humor-game-app -n argocd | grep -A 5 "source"

# 3. Resource conflicts
# Check for conflicting resources
kubectl get all -n humor-game
kubectl describe pods -n humor-game

# Fix: Resolve resource conflicts
kubectl delete pod <conflicting-pod> -n humor-game
```

### Issue: ArgoCD Sync Fails

**Symptom:** ArgoCD shows sync failures

**Diagnosis:**
```bash
# Check sync logs
kubectl logs -l app.kubernetes.io/name=argocd-server -n argocd | grep -i "sync"

# Check application events
kubectl get events -n argocd --sort-by=.metadata.creationTimestamp
```

**Fixes:**
```bash
# 1. Force sync
kubectl patch application humor-game-app -n argocd --type='merge' -p='{"operation":{"sync":{"syncOptions":["Prune=false"]}}}'

# 2. Reset application
kubectl delete application humor-game-app -n argocd
kubectl apply -f gitops-safe/argocd-application.yaml

# 3. Check Git repository
git log --oneline -5
git status
```

### Issue: Cloudflare Tunnel Connection Issues

**Symptom:** Tunnel shows connection errors

**Diagnosis:**
```bash
# Check tunnel status
cloudflared tunnel list

# Check tunnel logs
cloudflared tunnel run gameapp-tunnel --loglevel debug
```

**Fixes:**
```bash
# 1. Recreate tunnel
cloudflared tunnel delete gameapp-tunnel
cloudflared tunnel create gameapp-tunnel

# 2. Update DNS records
cloudflared tunnel route dns gameapp-tunnel app.gameapp.games

# 3. Check configuration
cat ~/.cloudflared/config.yml
```

### Issue: Monitoring Data Missing

**Symptom:** Prometheus shows no targets or Grafana shows no data

**Diagnosis:**
```bash
# Check Prometheus targets
kubectl port-forward svc/prometheus -n monitoring 9090:9090 &
curl http://localhost:9090/api/v1/targets

# Check service discovery
kubectl get pods -n humor-game --show-labels
kubectl get svc -n humor-game
```

**Fixes:**
```bash
# 1. Restart Prometheus
kubectl rollout restart deployment/prometheus -n monitoring

# 2. Check service annotations
kubectl describe svc backend -n humor-game | grep -A 5 "Annotations"

# 3. Verify metrics endpoint
kubectl exec -it deployment/backend -n humor-game -- curl localhost:3001/metrics
```

### Step 6: Network Debugging

```bash
# Create debugging pod with network tools
kubectl run netdebug --image=nicolaka/netshoot --rm -it -- bash

# Inside netdebug pod:
# nslookup backend.humor-game.svc.cluster.local
# telnet backend.humor-game.svc.cluster.local 3001
# curl -v http://backend.humor-game.svc.cluster.local:3001/api/health
```

### Step 7: Resource Debugging

```bash
# Check resource limits and usage
kubectl describe pods -n humor-game | grep -A 5 "Limits\|Requests"

# Check HPA behavior
kubectl describe hpa -n humor-game

# Check events for resource issues
kubectl get events -n humor-game | grep -i "insufficient\|evicted\|oom"
```

## Monitoring Integration

### Step 8: Use Prometheus for Troubleshooting

```bash
# Access Prometheus for metrics investigation
kubectl port-forward svc/prometheus -n monitoring 9090:9090 &

# Key queries for troubleshooting:
# up{job="humor-game-backend"}                    # Service availability
# rate(http_requests_total[5m])                   # Request rate
# container_memory_usage_bytes                    # Memory usage
# kube_pod_container_status_restarts_total        # Restart count
```

### Step 9: Create Troubleshooting Dashboards

```bash
# Create Grafana dashboard for troubleshooting
# Include panels for:
# - Pod status and restarts
# - Resource usage trends
# - Error rate trends
# - Network connectivity
# - Database performance
```

## ✅ Checkpoint

Your troubleshooting capabilities are ready when:
- ✅ You can systematically diagnose pod, network, and storage issues
- ✅ Troubleshooting toolkit script provides quick cluster overview
- ✅ Incident response runbook covers common scenarios
- ✅ You can use kubectl effectively for debugging
- ✅ Monitoring integration supports troubleshooting workflows
- ✅ You've practiced common failure scenarios
- ✅ Documentation captures tribal knowledge

## Building Troubleshooting Expertise

### Troubleshooting Checklist

```bash
cat > troubleshooting-checklist.md << 'EOF'
# Troubleshooting Checklist

## Before You Start
- [ ] What changed recently? (deployments, config, infrastructure)
- [ ] Is this affecting all users or specific subset?
- [ ] What error messages are users seeing?
- [ ] When did the issue start?

## Basic Health Checks
- [ ] Are all pods running and ready?
- [ ] Are services accessible within cluster?
- [ ] Is ingress routing traffic correctly?
- [ ] Are external dependencies healthy?

## Resource Investigation
- [ ] Check CPU and memory usage
- [ ] Verify storage availability
- [ ] Check network connectivity
- [ ] Review recent resource usage trends

## Application Investigation
- [ ] Check application logs for errors
- [ ] Verify configuration and secrets
- [ ] Test database connectivity
- [ ] Check cache performance

## Infrastructure Investigation
- [ ] Verify Kubernetes cluster health
- [ ] Check node status and resources
- [ ] Review ingress controller status
- [ ] Validate network policies

## Resolution Validation
- [ ] Verify fix resolves symptoms
- [ ] Monitor for 30 minutes post-fix
- [ ] Run smoke tests
- [ ] Update monitoring dashboards
EOF
```

### Common Failure Patterns

1. **Cascading Failures**: One component failure causes others to fail
2. **Resource Exhaustion**: CPU/memory/disk limits reached
3. **Configuration Drift**: Manual changes not reflected in code
4. **Dependency Failures**: External services unavailable
5. **Deployment Issues**: Bad releases causing instability

## What You Learned

You've developed professional troubleshooting skills:

**Troubleshooting Methodology:**
- **Systematic Approach**: OODA loop for structured problem-solving
- **Information Gathering**: Using kubectl and monitoring for diagnosis
- **Hypothesis Testing**: Scientific approach to finding root causes
- **Documentation**: Capturing knowledge for future incidents

**Technical Skills:**
- **Kubernetes Debugging**: Pod, service, and ingress troubleshooting
- **Application Debugging**: Log analysis and performance investigation
- **Network Debugging**: Connectivity and routing problem resolution
- **Resource Debugging**: CPU, memory, and storage issue diagnosis

**Operational Excellence:**
- **Incident Response**: Structured approach to production incidents
- **Runbook Creation**: Documenting procedures for common issues
- **Post-Incident Learning**: Continuous improvement through reflection
- **Team Communication**: Effective incident communication patterns

**Career-Ready Capabilities:**
- **Site Reliability Engineering**: Production system troubleshooting
- **DevOps Operations**: End-to-end system debugging
- **Platform Engineering**: Infrastructure problem resolution
- **Technical Leadership**: Guiding teams through complex incidents

These troubleshooting skills are essential for maintaining production systems and are highly valued by employers looking for experienced engineers who can handle complex technical challenges.

---

**Next**: [Chapter 13: Interview Preparation Guide](13-interview-prep.md) - Leverage your project experience for DevOps engineering interviews
**Previous**: [Chapter 11: Deployment Strategies](11-deployment-strategies.md) - Zero-downtime deployment patterns
