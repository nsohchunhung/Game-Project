# Customization Guide

This guide explains how to customize the application configuration, environment variables, and deployment settings for your specific needs.

## Table of Contents

1. [Application Configuration](#application-configuration)
2. [Environment Variables](#environment-variables)
3. [Kubernetes Resource Limits](#kubernetes-resource-limits)
4. [Database Configuration](#database-configuration)
5. [Redis Configuration](#redis-configuration)
6. [Network Configuration](#network-configuration)
7. [Monitoring Configuration](#monitoring-configuration)
8. [Security Customization](#security-customization)

## Application Configuration

### Backend Configuration

Edit `gitops-safe/base/configmap.yaml` or use Kustomize overlays:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: humor-game-config
  namespace: humor-game
data:
  NODE_ENV: "production"  # Change to: development, production, test
  API_PORT: "3001"        # Backend API port
  CORS_ORIGIN: "https://yourdomain.com"  # Allowed CORS origins
  FRONTEND_URL: "https://yourdomain.com"  # Frontend URL
  API_BASE_URL: "/api"    # API base path
```

### Frontend Configuration

Frontend configuration is built into the image. To customize:

1. Edit `frontend/src/config.js`
2. Rebuild the image
3. Update deployment manifests

## Environment Variables

### Complete Environment Variable Reference

| Variable | Default | Description | Where to Set |
|----------|---------|-------------|--------------|
| `NODE_ENV` | `development` | Node.js environment | ConfigMap |
| `PORT` | `3001` | Backend API port | ConfigMap |
| `DB_HOST` | `postgres` | Database hostname | ConfigMap/Secret |
| `DB_PORT` | `5432` | Database port | ConfigMap/Secret |
| `DB_NAME` | `humor_memory_game` | Database name | ConfigMap/Secret |
| `DB_USER` | `gameuser` | Database username | ConfigMap/Secret |
| `DB_PASSWORD` | - | Database password | Secret |
| `DB_MAX_CONNECTIONS` | `20` | Max DB connections | ConfigMap |
| `DB_IDLE_TIMEOUT` | `30000` | DB idle timeout (ms) | ConfigMap |
| `REDIS_HOST` | `redis` | Redis hostname | ConfigMap |
| `REDIS_PORT` | `6379` | Redis port | ConfigMap |
| `REDIS_PASSWORD` | - | Redis password | Secret |
| `JWT_SECRET` | - | JWT signing secret | Secret |
| `CORS_ORIGIN` | `*` | Allowed CORS origins | ConfigMap |
| `FRONTEND_URL` | `http://localhost:8080` | Frontend URL | ConfigMap |
| `API_BASE_URL` | `/api` | API base path | ConfigMap |

### Setting Environment Variables

#### For Local Development (Docker Compose)

Edit `docker-compose.yml`:

```yaml
services:
  backend:
    environment:
      - NODE_ENV=development
      - DB_HOST=postgres
      - DB_NAME=humor_memory_game
      - DB_USER=gameuser
      - DB_PASSWORD=your_password
```

Or use `.env` file:

```bash
# .env
DB_PASSWORD=your_secure_password
REDIS_PASSWORD=your_redis_password
JWT_SECRET=your_jwt_secret
```

#### For Kubernetes

**Using ConfigMap** (non-sensitive):
```bash
kubectl create configmap humor-game-config \
  --from-literal=NODE_ENV=production \
  --from-literal=API_PORT=3001 \
  -n humor-game
```

**Using Secrets** (sensitive):
```bash
kubectl create secret generic humor-game-secrets \
  --from-literal=DB_PASSWORD=your_password \
  --from-literal=REDIS_PASSWORD=your_redis_password \
  --from-literal=JWT_SECRET=your_jwt_secret \
  -n humor-game
```

## Kubernetes Resource Limits

### Customizing Resource Requests and Limits

Edit `gitops-safe/base/backend-deployment.yaml`:

```yaml
resources:
  requests:
    memory: "256Mi"  # Increase for high traffic
    cpu: "200m"      # Increase for CPU-intensive workloads
  limits:
    memory: "512Mi"  # Maximum memory allowed
    cpu: "1000m"     # Maximum CPU allowed
```

### Recommended Resource Sizes

| Environment | Memory Request | Memory Limit | CPU Request | CPU Limit |
|-------------|---------------|--------------|-------------|-----------|
| Development | 128Mi | 256Mi | 100m | 500m |
| Staging | 256Mi | 512Mi | 200m | 1000m |
| Production | 512Mi | 1Gi | 500m | 2000m |

## Database Configuration

### PostgreSQL Settings

#### Local (Docker Compose)

Edit `docker-compose.yml`:

```yaml
services:
  postgres:
    environment:
      POSTGRES_DB: humor_memory_game
      POSTGRES_USER: gameuser
      POSTGRES_PASSWORD: your_password
    volumes:
      - postgres_data:/var/lib/postgresql/data
```

#### Kubernetes

Edit `gitops-safe/base/postgres-deployment.yaml`:

```yaml
resources:
  requests:
    memory: "512Mi"  # Increase for larger databases
    cpu: "500m"
  limits:
    memory: "2Gi"    # Increase for production
    cpu: "2000m"
```

### Database Connection Pool

Customize in backend environment variables:

```yaml
DB_MAX_CONNECTIONS: "50"        # Increase for high traffic
DB_IDLE_TIMEOUT: "60000"        # 60 seconds
DB_CONNECTION_TIMEOUT: "10000"  # 10 seconds
```

## Redis Configuration

### Redis Settings

#### Local (Docker Compose)

Edit `docker-compose.yml`:

```yaml
services:
  redis:
    command: redis-server --appendonly yes --requirepass ${REDIS_PASSWORD}
    volumes:
      - redis_data:/data
```

#### Kubernetes

Edit `gitops-safe/base/redis-deployment.yaml`:

```yaml
resources:
  requests:
    memory: "128Mi"
    cpu: "100m"
  limits:
    memory: "256Mi"
    cpu: "500m"
```

### Redis TTL Configuration

Set in backend environment (if supported):

```yaml
REDIS_TTL: "3600"  # Cache TTL in seconds
```

## Network Configuration

### Ingress Configuration

Edit `gitops-safe/base/ingress.yaml` or create overlay:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: humor-game-ingress
spec:
  rules:
    - host: yourdomain.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: frontend
                port:
                  number: 80
```

### Service Ports

Customize in `gitops-safe/base/*-service.yaml`:

```yaml
apiVersion: v1
kind: Service
spec:
  ports:
    - port: 80        # External port
      targetPort: 80  # Container port
      protocol: TCP
```

## Monitoring Configuration

### Prometheus Scrape Configuration

Add annotations to deployments:

```yaml
metadata:
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "3001"
    prometheus.io/path: "/metrics"
```

### Grafana Dashboard Customization

1. Access Grafana: `kubectl port-forward svc/grafana -n monitoring 3000:3000`
2. Navigate to Dashboards → Import
3. Upload custom dashboard JSON
4. Or edit existing dashboards via UI

## Security Customization

### Security Contexts

Edit `gitops-safe/base/security-contexts.yaml`:

```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
  fsGroup: 1000
  capabilities:
    drop:
      - ALL
```

### Network Policies

Create custom network policies:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend-policy
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: frontend
      ports:
        - protocol: TCP
          port: 3001
```

## Customization Examples

### Example 1: Production Configuration

```yaml
# configmap.yaml
data:
  NODE_ENV: "production"
  API_PORT: "3001"
  CORS_ORIGIN: "https://yourdomain.com"
  FRONTEND_URL: "https://yourdomain.com"
```

### Example 2: High Traffic Setup

```yaml
# backend-deployment.yaml
resources:
  requests:
    memory: "1Gi"
    cpu: "1000m"
  limits:
    memory: "2Gi"
    cpu: "4000m"
replicas: 3  # Scale horizontally
```

### Example 3: Development Override

Create `gitops-safe/overlays/dev/configmap-patch.yaml`:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: humor-game-config
data:
  NODE_ENV: "development"
  CORS_ORIGIN: "http://localhost:3000,http://localhost:8080"
```

## Best Practices

1. **Never modify base manifests directly** - Use Kustomize overlays
2. **Use Secrets for sensitive data** - Never put passwords in ConfigMaps
3. **Test changes in dev first** - Apply to production only after validation
4. **Document customizations** - Keep notes on why you changed settings
5. **Version control everything** - Commit all configuration changes

## Troubleshooting Customizations

### Configuration Not Applied

```bash
# Check current ConfigMap
kubectl get configmap humor-game-config -n humor-game -o yaml

# Check if pods are using the ConfigMap
kubectl describe pod <pod-name> -n humor-game | grep -A 10 "Environment:"
```

### Environment Variable Issues

```bash
# View environment variables in running pod
kubectl exec -it <pod-name> -n humor-game -- env | grep DB_

# Check if secrets are mounted
kubectl describe pod <pod-name> -n humor-game | grep -A 5 "Mounts:"
```

### Resource Limit Issues

```bash
# Check current resource usage
kubectl top pod <pod-name> -n humor-game

# Check if pod is being throttled
kubectl describe pod <pod-name> -n humor-game | grep -i "throttle\|limit"
```

## Next Steps

- [Deployment Guide](./03-k8s-basics.md) - Deploy with custom configuration
- [Troubleshooting](./08-troubleshooting.md) - Fix customization issues
- [Kustomize Overlays](../aws/kustomize-overlays.md) - Advanced customization patterns

