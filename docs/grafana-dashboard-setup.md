# Grafana Dashboard Setup Guide

## Overview

The observability stack includes a **production-ready Grafana dashboard** that is **automatically imported** when you deploy the infrastructure.

## Automatic Import

The dashboard is automatically imported via ConfigMap with the label `grafana_dashboard=1`. Grafana's sidecar automatically discovers and imports it.

### How It Works

1. **Terraform creates ConfigMap** with dashboard JSON
2. **ConfigMap has label** `grafana_dashboard=1`
3. **Grafana sidecar** watches for ConfigMaps with this label
4. **Dashboard appears** in Grafana automatically

## Dashboard Features

### Real-time Metrics (10s refresh)

- **Request Rate**: HTTP requests per second
- **Error Rate**: Error tracking with color thresholds
- **Active Games**: Current game sessions
- **Response Time**: p95 percentile

### Time Series Panels

- **Request Rate Over Time**: Historical request patterns
- **Response Time Percentiles**: p50, p95, p99
- **Game Scores**: Score submission rates
- **Database Query Duration**: Query performance
- **Redis Cache Hit Rate**: Cache effectiveness
- **Database Connections**: Connection pool usage
- **Redis Connections**: Redis connection pool
- **Application Health**: Service status (0=down, 1=up)

## Accessing the Dashboard

### From Bastion Host

```bash
# SSH to bastion
ssh -i devops-home-lab-bastion.pem ec2-user@<bastion-ip>

# Port-forward Grafana
kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80

# Access in browser
# http://localhost:3000
# Username: admin
# Password: admin (change on first login)
```

### Dashboard Location

Once in Grafana:
- Navigate to **Dashboards** → **Browse**
- Look for: **"Humor Memory Game - Production Dashboard"**
- Or search for tag: `humor-game`

## Manual Import (If Needed)

If automatic import doesn't work:

```bash
# Port-forward Grafana
kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80

# Import dashboard
./scripts/import-grafana-dashboard.sh
```

## Customizing the Dashboard

### Option 1: Edit ConfigMap

```bash
# Edit the ConfigMap
kubectl edit configmap humor-game-dashboard -n monitoring

# Grafana will auto-reload changes
```

### Option 2: Export from Grafana UI

1. Open dashboard in Grafana
2. Click **Settings** → **JSON Model**
3. Copy JSON
4. Update ConfigMap

### Option 3: Update Terraform

Edit `terraform/modules/observability/grafana-dashboard.json` and re-apply.

## Troubleshooting

### Dashboard Not Appearing

1. **Check ConfigMap exists:**
   ```bash
   kubectl get configmap humor-game-dashboard -n monitoring
   ```

2. **Check Grafana sidecar logs:**
   ```bash
   kubectl logs -n monitoring -l app.kubernetes.io/name=grafana -c grafana-sc-dashboard
   ```

3. **Check ConfigMap label:**
   ```bash
   kubectl get configmap humor-game-dashboard -n monitoring -o yaml | grep grafana_dashboard
   # Should show: grafana_dashboard: "1"
   ```

4. **Restart Grafana pod:**
   ```bash
   kubectl rollout restart deployment/prometheus-grafana -n monitoring
   ```

### Metrics Not Showing

1. **Check Prometheus is scraping:**
   ```bash
   kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 9090:9090
   # Visit http://localhost:9090/targets
   ```

2. **Check backend metrics endpoint:**
   ```bash
   kubectl port-forward svc/backend -n humor-game 3001:3001
   curl http://localhost:3001/metrics
   ```

3. **Verify ServiceMonitor:**
   ```bash
   kubectl get servicemonitor -n humor-game
   ```

## Dashboard JSON Location

- **Terraform**: `terraform/modules/observability/grafana-dashboard.json`
- **Kubernetes**: `k8s/grafana-dashboard-humor-game.json`
- **ConfigMap**: Created automatically by Terraform

## Next Steps

1. ✅ Dashboard auto-imports on deployment
2. ✅ Access via port-forward from bastion
3. ✅ Customize as needed
4. ✅ Set up alerts based on metrics

For more details, see:
- [Observability Setup](docs/05-observability.md)
- [Custom Dashboard Guide](docs/custom-dashboard-guide.md)

