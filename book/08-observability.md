# Chapter 8: Observability - Monitoring and Logging

*Implement production-grade monitoring with Prometheus and Grafana for complete system visibility*

---

## What You'll Learn
- Deploy Prometheus for metrics collection and alerting
- Configure Grafana with custom dashboards and visualizations
- Implement application metrics and business KPIs
- Set up logging aggregation and analysis
- Build production monitoring strategies

## Time Required: 90 minutes

## Prerequisites: [Chapter 7: CI/CD Pipeline Implementation](07-ci-cd.md)

---

## Why This Matters

You can't manage what you can't measure. Observability is what separates amateur deployments from production systems. When something breaks at 3 AM, monitoring tells you what went wrong, where, and how to fix it.

**Professional Context**: Site Reliability Engineers (SREs) at Google, Netflix, and other tech giants rely on comprehensive observability to maintain 99.99% uptime. These same patterns are now standard across the industry.

**💡 Pro Tip**: The three pillars of observability are metrics (what happened), logs (detailed context), and traces (request flow). This chapter focuses on metrics and logs.

## Understanding Observability Architecture

# 📊 Observability Architecture Overview
# Complete monitoring stack with metrics collection and visualization

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Application   │───▶│   Prometheus    │───▶│    Grafana      │
│   Metrics       │    │   Scrapes &     │    │   Dashboards    │
│   (/metrics)    │    │   Stores        │    │   & Alerts      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                        │                        │
         ▼                        ▼                        ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Node Metrics  │    │   Alert Rules   │    │   Notification  │
│   (CPU, Memory) │    │   & Thresholds  │    │   Channels      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Deploy Prometheus Monitoring Stack

### Step 1: Create Monitoring Namespace

# 📁 Create Monitoring Namespace
# Set up dedicated namespace for monitoring components

```bash
# Create dedicated monitoring namespace
kubectl create namespace monitoring
```

**Expected Output:**

# ✅ Monitoring Namespace Created
# Confirmation of monitoring namespace creation

```bash
namespace/monitoring created
```

### Step 2: Deploy Prometheus

# 🚀 Deploy Prometheus Configuration
# Apply Prometheus monitoring stack to the cluster

```bash
# Apply Prometheus configuration
kubectl apply -f k8s/monitoring.yaml
```

**Expected Output:**

# ✅ Prometheus Resources Created
# Confirmation of Prometheus deployment components

```bash
configmap/prometheus-config created
deployment.apps/prometheus created
service/prometheus created
persistentvolumeclaim/prometheus-pvc created
```

# ⏳ Wait for Prometheus Readiness
# Ensure Prometheus pod is fully initialized

```bash
# Wait for Prometheus to be ready
kubectl wait --for=condition=Ready pods -l app=prometheus -n monitoring --timeout=300s
```

**Expected Output:**

# ✅ Prometheus Pod Ready
# Confirmation that Prometheus is running and ready

```bash
pod/prometheus-7c8b9d4f6d-xyz12 condition met
```

### Step 3: Verify Prometheus Deployment

# 📊 Check Prometheus Pod Status
# Verify Prometheus deployment is healthy

```bash
# Check Prometheus pod status
kubectl get pods -n monitoring
```

**Expected Output:**

# 📊 Prometheus Pod Status
# Confirmation of healthy Prometheus deployment

```bash
NAME                          READY   STATUS    RESTARTS   AGE
prometheus-7c8b9d4f6d-xyz12   1/1     Running   0          2m
```

# 🌐 Access Prometheus Web UI
# Port-forward to Prometheus for web interface access

```bash
# Access Prometheus UI
kubectl port-forward svc/prometheus -n monitoring 9090:9090 &
```

**Access Prometheus:**
- URL: `http://localhost:9090`
- Check Status → Targets to see discovered services

[[ADD IMAGE: Prometheus UI showing discovered targets and service discovery]]

## Deploy Grafana Dashboard Platform

### Step 4: Deploy Grafana

# 🔍 Check Grafana Configuration
# Verify if Grafana is included in monitoring setup

```bash
# Check if Grafana is included in monitoring.yaml
grep -A 10 "name: grafana" k8s/monitoring.yaml
```

If Grafana isn't included, add it:

# 📊 Add Grafana Deployment Configuration
# Complete Grafana setup with persistent storage

```bash
# Add Grafana deployment to monitoring.yaml or create separate file
cat >> k8s/monitoring.yaml << 'EOF'
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
  namespace: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - name: grafana
        image: grafana/grafana:10.2.0
        ports:
        - containerPort: 3000
        env:
        - name: GF_SECURITY_ADMIN_PASSWORD
          value: "admin"
        - name: GF_USERS_ALLOW_SIGN_UP
          value: "false"
        volumeMounts:
        - name: grafana-storage
          mountPath: /var/lib/grafana
      volumes:
      - name: grafana-storage
        persistentVolumeClaim:
          claimName: grafana-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: grafana
  namespace: monitoring
spec:
  selector:
    app: grafana
  ports:
  - port: 3000
    targetPort: 3000
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: grafana-pvc
  namespace: monitoring
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
EOF
```

# 🚀 Apply Updated Monitoring Configuration
# Deploy Grafana with the updated monitoring setup

```bash
# Apply updated monitoring configuration
kubectl apply -f k8s/monitoring.yaml
```

### Step 5: Access Grafana

# 🌐 Access Grafana Web Interface
# Wait for Grafana readiness and set up port-forwarding

```bash
# Wait for Grafana to be ready
kubectl wait --for=condition=Ready pods -l app=grafana -n monitoring --timeout=300s

# Port-forward to Grafana
kubectl port-forward svc/grafana -n monitoring 3000:3000 &
```

**Access Grafana:**
- URL: `http://localhost:3000`
- Username: `admin`
- Password: `admin`

[[ADD IMAGE: Grafana login screen and initial dashboard]]

## Configure Prometheus Data Sources

### Step 6: Add Prometheus Data Source to Grafana

**In Grafana UI:**
1. Go to Configuration → Data Sources
2. Click "Add data source"
3. Select "Prometheus"
4. Set URL: `http://prometheus:9090`
5. Click "Save & Test"

**Expected Result:** "Data source is working" message

### Step 7: Verify Metrics Collection

**In Prometheus UI** (`http://localhost:9090`):

# 🔍 Prometheus Query Examples
# Test metrics collection with sample queries

```bash
# Query application metrics
up{job="humor-game-backend"}

# Query node metrics
node_cpu_seconds_total

# Query Kubernetes metrics
kube_pod_info
```

**Expected Results:**
- Backend health metrics should show `1` (up)
- Node metrics should show CPU usage data
- Kubernetes metrics should show pod information

## Create Application Dashboards

### Step 8: Import Kubernetes Dashboard

**In Grafana UI:**
1. Click "+" → Import
2. Enter Dashboard ID: `15757` (Kubernetes cluster monitoring)
3. Click "Load"
4. Select Prometheus data source
5. Click "Import"

[[ADD IMAGE: Grafana Kubernetes dashboard showing cluster metrics]]

### Step 9: Create Custom Application Dashboard

**In Grafana UI:**
1. Click "+" → Create → Dashboard
2. Add Panel → Query

**Key Metrics to Add:**

# 📊 Prometheus Query Language Examples
# Key metrics for application monitoring

```promql
# Request Rate
rate(http_requests_total[5m])

# Error Rate  
rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m])

# Response Time
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))

# Active Users (if implemented)
game_active_sessions

# Database Connections
postgres_connections_active
```

### Step 10: Configure Application Metrics

Check if your application exposes metrics:

# 🧪 Test Application Metrics Endpoint
# Verify if application exposes Prometheus metrics

```bash
# Test metrics endpoint
curl http://localhost:8080/metrics
```

If metrics aren't available, add them to your backend:

**[TODO]** Add application metrics implementation guide for Node.js backend with prom-client library.

## Set Up Logging

### Step 11: Deploy Logging Stack (Optional)

For production logging, you might deploy the ELK stack or similar:

# 📝 Logging Stack Configuration Example
# Production logging setup with ELK or Loki stack

```bash
# Example logging configuration (not included in basic setup)
# This would typically include Elasticsearch, Logstash, and Kibana
# or alternatives like Loki, Promtail, and Grafana
```

### Step 12: View Application Logs

# 📋 View Application Logs
# Access and monitor application logs from Kubernetes

```bash
# View backend logs
kubectl logs -l app=backend -n humor-game --tail=50

# Follow logs in real-time
kubectl logs -l app=backend -n humor-game -f

# View logs from all pods
kubectl logs -l app.kubernetes.io/name=humor-game -n humor-game --all-containers=true
```

## Configure Alerting

### Step 13: Create Alert Rules

Create Prometheus alert rules:

# 🚨 Create Prometheus Alert Rules
# Configure alerting rules for critical system events

```bash
cat > k8s/alert-rules.yaml << 'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-alert-rules
  namespace: monitoring
data:
  alert.rules: |
    groups:
    - name: humor-game.rules
      rules:
      - alert: HighErrorRate
        expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.1
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: High error rate detected
          description: "Error rate is {{ $value }} errors per second"
      
      - alert: PodCrashLooping
        expr: rate(kube_pod_container_status_restarts_total[5m]) > 0
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: Pod is crash looping
          description: "Pod {{ $labels.pod }} is restarting frequently"
      
      - alert: HighMemoryUsage
        expr: container_memory_usage_bytes / container_spec_memory_limit_bytes > 0.8
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: High memory usage
          description: "Container memory usage is above 80%"
EOF

# 🚀 Apply Alert Rules Configuration
# Deploy Prometheus alert rules to the cluster

```bash
# Apply alert rules
kubectl apply -f k8s/alert-rules.yaml
```

### Step 14: Configure Alertmanager (Optional)

# 📧 Configure Alertmanager for Notifications
# Set up email and webhook alerting with Alertmanager

```bash
# Example Alertmanager configuration
cat > k8s/alertmanager.yaml << 'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: alertmanager-config
  namespace: monitoring
data:
  alertmanager.yml: |
    global:
      smtp_smarthost: 'localhost:587'
      smtp_from: 'alertmanager@yourdomain.com'
    route:
      group_by: ['alertname']
      group_wait: 10s
      group_interval: 10s
      repeat_interval: 1h
      receiver: 'web.hook'
    receivers:
    - name: 'web.hook'
      email_configs:
      - to: 'admin@yourdomain.com'
        subject: 'Alert: {{ .GroupLabels.alertname }}'
        body: 'Alert details: {{ range .Alerts }}{{ .Annotations.description }}{{ end }}'
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: alertmanager
  namespace: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      app: alertmanager
  template:
    metadata:
      labels:
        app: alertmanager
    spec:
      containers:
      - name: alertmanager
        image: prom/alertmanager:v0.26.0
        ports:
        - containerPort: 9093
        volumeMounts:
        - name: config
          mountPath: /etc/alertmanager
      volumes:
      - name: config
        configMap:
          name: alertmanager-config
EOF
```

## Monitor Application Performance

### Step 15: Create Performance Dashboard

**Key Performance Indicators to Monitor:**

# 📊 Performance Monitoring Queries
# Key metrics for application performance monitoring

```promql
# Application Health
up{job="humor-game-backend"}

# Request Volume
sum(rate(http_requests_total[5m])) by (method, status)

# Latency Percentiles
histogram_quantile(0.50, rate(http_request_duration_seconds_bucket[5m]))
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))
histogram_quantile(0.99, rate(http_request_duration_seconds_bucket[5m]))

# Error Rate
sum(rate(http_requests_total{status=~"5.."}[5m])) / sum(rate(http_requests_total[5m]))

# Infrastructure Metrics
rate(container_cpu_usage_seconds_total[5m])
container_memory_usage_bytes
```

### Step 16: Create Business Metrics Dashboard

**Business KPIs to Track:**

```promql
# Game Sessions (if implemented)
game_sessions_total
game_sessions_completed_total
game_sessions_duration_seconds

# User Activity
game_users_active
game_users_registered_total

# Performance Metrics
database_query_duration_seconds
cache_hit_rate
```

## Production Monitoring Best Practices

### Step 17: Implement SLI/SLO Monitoring

**Service Level Indicators (SLIs):**
- Availability: `up` metric
- Latency: 95th percentile response time
- Error Rate: 5xx responses / total requests
- Throughput: Requests per second

**Service Level Objectives (SLOs):**
- 99.9% availability
- 95% of requests < 200ms
- Error rate < 0.1%
- Handle 1000 RPS

### Step 18: Set Up Monitoring Runbooks

Create documentation for common issues:

```bash
# Example runbook entry
# Alert: HighErrorRate
# Severity: Critical
# Investigation Steps:
# 1. Check application logs: kubectl logs -l app=backend -n humor-game
# 2. Verify database connectivity: kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -c "SELECT 1"
# 3. Check service endpoints: kubectl get endpoints -n humor-game
# 4. Review recent deployments: kubectl rollout history deployment/backend -n humor-game
```

## ✅ Checkpoint

Your observability stack is working when:
- ✅ Prometheus UI shows all application targets as "UP"
- ✅ Grafana displays metrics from Prometheus data source
- ✅ Kubernetes cluster dashboard shows accurate cluster metrics
- ✅ Application logs are accessible via kubectl commands
- ✅ Custom dashboards display application-specific metrics
- ✅ Alert rules are configured and firing appropriately
- ✅ Memory and storage usage are within reasonable limits

## Troubleshooting Monitoring Issues

### Issue: Prometheus Can't Scrape Targets

**Symptom:** Targets show as "DOWN" in Prometheus

**Diagnosis:**
```bash
# Check if application metrics endpoint exists
kubectl port-forward svc/backend -n humor-game 3001:3001 &
curl http://localhost:3001/metrics

# Check Prometheus configuration
kubectl describe configmap prometheus-config -n monitoring
```

**Fix:**
```bash
# Ensure application exposes metrics endpoint
# Check service discovery configuration
# Verify network policies allow Prometheus access
```

### Issue: Grafana Shows "No Data"

**Symptom:** Dashboards display but show no metrics

**Diagnosis:**
```bash
# Test Prometheus data source connection
# Check Prometheus UI for available metrics
# Verify query syntax in Grafana panels
```

**Fix:**
```bash
# Correct data source URL in Grafana
# Update dashboard queries to match available metrics
# Check time range in dashboard
```

### Issue: High Storage Usage

**Symptom:** Prometheus consuming excessive disk space

**Diagnosis:**
```bash
# Check Prometheus storage usage
kubectl exec -it deployment/prometheus -n monitoring -- du -sh /prometheus

# Check retention policies
kubectl describe deployment prometheus -n monitoring
```

**Fix:**
```bash
# Configure retention policy
# Add storage limits to deployment
# Implement metric filtering to reduce cardinality
```

## Advanced Monitoring Access

### Step 17: Set Up Monitoring Ingress

**Access monitoring services via ingress (no port-forwarding needed):**

```bash
# Apply monitoring ingress
kubectl apply -f k8s/monitoring-ingress.yaml

# Check ingress status
kubectl get ingress -n monitoring
```

**Expected Output:**
```bash
NAME                    CLASS   HOSTS                              ADDRESS      PORTS   AGE
monitoring-ingress      nginx   prometheus.gameapp.local,grafana.gameapp.local   172.18.0.2   80      1m
```

**Access URLs:**
- Prometheus: `http://prometheus.gameapp.local:8080`
- Grafana: `http://grafana.gameapp.local:8080`

### Step 18: Configure Monitoring Authentication

**Set up basic authentication for monitoring services:**

```bash
# Create monitoring auth secret
kubectl create secret generic monitoring-auth \
  --from-literal=username=admin \
  --from-literal=password=admin123 \
  -n monitoring

# Apply monitoring auth configuration
kubectl apply -f k8s/monitoring-auth.yaml
```

### Step 19: Advanced Dashboard Configuration

**Import comprehensive dashboards:**

```bash
# Import advanced dashboard
kubectl port-forward svc/grafana -n monitoring 3000:3000 &

# In Grafana UI:
# 1. Go to + → Import
# 2. Upload: k8s/advanced-custom-dashboard.json
# 3. Select Prometheus data source
# 4. Click Import
```

**Key dashboard panels:**
- Application performance metrics
- Infrastructure resource usage
- Business KPIs (game sessions, user activity)
- Error rate trends
- Response time percentiles

### Step 20: Production Monitoring Setup

**Configure monitoring for production access:**

```bash
# Apply tunnel ingress for global access
kubectl apply -f k8s/monitoring-tunnel-ingress.yaml

# Configure Cloudflare tunnel for monitoring
cat >> ~/.cloudflared/config.yml << EOF
  - hostname: prometheus.app.gameapp.games
    service: http://localhost:9090
  - hostname: grafana.app.gameapp.games
    service: http://localhost:3000
EOF
```

## Advanced Monitoring Patterns

### Distributed Tracing

For microservices tracing:

```bash
# Example Jaeger deployment (not included in basic setup)
# This would add distributed tracing capabilities
# kubectl apply -f https://github.com/jaegertracing/jaeger/releases/download/v1.50.0/jaeger.yaml
```

### Log Aggregation

```bash
# Example Loki + Promtail setup
# Provides centralized logging with Grafana integration
# kubectl apply -f https://raw.githubusercontent.com/grafana/loki/main/production/kustomize/loki.yaml
```

### Prometheus RBAC Configuration

**Set up proper RBAC for Prometheus:**

```bash
# Apply Prometheus RBAC
kubectl apply -f k8s/prometheus-rbac.yaml

# Verify service account permissions
kubectl get clusterrole prometheus -o yaml
kubectl get clusterrolebinding prometheus -o yaml
```

## What You Learned

You've implemented comprehensive observability:

**Monitoring Fundamentals:**
- **Metrics Collection**: Prometheus scraping and storage
- **Visualization**: Grafana dashboards and panel configuration
- **Alerting**: Alert rules and notification channels
- **Service Discovery**: Automatic target discovery in Kubernetes

**Production Patterns:**
- **SLI/SLO Monitoring**: Service level indicators and objectives
- **Business Metrics**: KPIs and user behavior tracking
- **Infrastructure Monitoring**: Resource usage and capacity planning
- **Log Management**: Centralized logging and analysis

**Operational Skills:**
- **Dashboard Design**: Creating meaningful visualizations
- **Alert Configuration**: Setting up actionable alerts
- **Troubleshooting**: Using metrics to diagnose issues
- **Capacity Planning**: Understanding resource trends and growth

**Career-Ready Capabilities:**
- **Site Reliability Engineering**: Production monitoring and alerting
- **DevOps Operations**: Complete observability implementation
- **Performance Engineering**: Application and infrastructure optimization
- **Incident Response**: Using observability data for faster resolution

This monitoring setup provides the visibility needed for production operations. You now understand how to maintain system reliability and quickly identify and resolve issues.

---

**Next**: [Chapter 9: GitOps - Automated Deployments](09-gitops.md) - Implement GitOps workflows with ArgoCD
**Previous**: [Chapter 7: CI/CD Pipeline Implementation](07-ci-cd.md) - Building automated deployment pipelines
