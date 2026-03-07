# Chapter 6: Production Networking and Ingress

*Make your application accessible from the internet with production-grade networking*

---

## What You'll Learn
- Deploy and configure NGINX Ingress Controller
- Set up domain-based routing for your application
- Implement SSL/TLS termination and security headers
- Configure load balancing and traffic management
- Test production networking patterns

## Time Required: 45 minutes

## Prerequisites: [Chapter 5: Kubernetes Basics](05-kubernetes-basics.md)

---

## Why This Matters

Kubernetes services by default are only accessible within the cluster. Ingress controllers act as the gateway that routes external traffic to your applications. Understanding ingress is crucial because it's how users actually reach your application in production.

**Professional Context**: Every production Kubernetes deployment uses ingress controllers. They handle SSL termination, load balancing, and traffic routing - critical functions for any web application.

## Understanding Kubernetes Networking

### Service Types Overview

```bash
# ClusterIP (default): Internal cluster access only
# NodePort: Access via node IP and port (limited, not production)
# LoadBalancer: Cloud provider load balancer (expensive)
# Ingress: Layer 7 routing with SSL, domains, paths (production choice)
```

### Current Application Network Architecture

```
Internet → Ingress Controller → Services → Pods
    ↓           ↓                 ↓        ↓
   HTTPS    Load Balancer    Internal    Application
   Port 443  + SSL Termination  ClusterIP  Containers
```

## Deploy NGINX Ingress Controller

### Step 1: Install NGINX Ingress

# 📦 Add NGINX Ingress Helm Repository
# Add and update the official NGINX Ingress Controller repository

```bash
# Add NGINX ingress helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

**Expected Output:**

# ✅ Helm Repository Update
# Confirmation of NGINX Ingress repository addition and update

```bash
"ingress-nginx" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "ingress-nginx" chart repository
Update Complete. ⎈Happy Helming!⎈
```

# 🚀 Install NGINX Ingress Controller
# Deploy NGINX Ingress Controller with LoadBalancer service

```bash
# Install NGINX ingress controller
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --set controller.service.type=LoadBalancer \
  --set controller.service.loadBalancerIP="" \
  --wait
```

**Expected Output:**

# ✅ NGINX Ingress Installation
# Successful deployment of NGINX Ingress Controller

```bash
Release "ingress-nginx" does not exist. Installing it now.
NAME: ingress-nginx
LAST DEPLOYED: 2025-01-15T10:30:00Z
NAMESPACE: ingress-nginx
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

**💡 Pro Tip**: k3d automatically maps ports 8080:80 and 8090:443 from your cluster to localhost, so the LoadBalancer will be accessible on these ports.

### Step 2: Verify Ingress Controller

# 🔍 Verify Ingress Controller Pods
# Check that NGINX Ingress Controller pods are running

```bash
# Check ingress controller pods
kubectl get pods -n ingress-nginx
```

**Expected Output:**

# 📊 Ingress Controller Pod Status
# Confirmation that NGINX Ingress Controller is running

```bash
NAME                                        READY   STATUS    RESTARTS   AGE
ingress-nginx-controller-7844b9db77-xyz12   1/1     Running   0          2m
```

# 🔗 Check Ingress Controller Service
# Verify LoadBalancer service configuration

```bash
# Check ingress controller service
kubectl get svc -n ingress-nginx
```

**Expected Output:**

# 🔗 Ingress Controller Services
# LoadBalancer and admission webhook services configuration

```bash
NAME                                 TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
ingress-nginx-controller             LoadBalancer   10.43.123.45    172.18.0.2    80:30080/TCP,443:30443/TCP   2m
ingress-nginx-controller-admission   ClusterIP      10.43.234.56    <none>        443/TCP                      2m
```

## Configure Application Ingress

### Step 3: Create Ingress Resource

# 📝 Create Application Ingress Resource
# Define ingress rules for frontend and backend services

```bash
# Create ingress for your application
cat > k8s/ingress.yaml << EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: humor-game-ingress
  namespace: humor-game
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "false"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
spec:
  ingressClassName: nginx
  rules:
  - host: gameapp.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: backend
            port:
              number: 3001
  - host: localhost
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: backend
            port:
              number: 3001
EOF
```

### Step 4: Apply Ingress Configuration

# 🚀 Apply Ingress Configuration
# Deploy the ingress resource to the cluster

```bash
# Apply the ingress resource
kubectl apply -f k8s/ingress.yaml
```

**Expected Output:**

# ✅ Ingress Resource Created
# Confirmation of ingress resource deployment

```bash
ingress.networking.k8s.io/humor-game-ingress created
```

# 🔍 Verify Ingress Status
# Check that ingress is created and has an address

```bash
# Verify ingress is created
kubectl get ingress -n humor-game
```

**Expected Output:**

# 📊 Ingress Status Overview
# Confirmation of ingress with LoadBalancer address

```bash
NAME                  CLASS   HOSTS                    ADDRESS      PORTS   AGE
humor-game-ingress    nginx   gameapp.local,localhost  172.18.0.2   80      1m
```

### Step 5: Configure Local DNS (Optional)

For local testing with `gameapp.local`:

# 🌐 Configure Local DNS Resolution
# Add local domain mapping for testing

```bash
# Add entry to /etc/hosts (macOS/Linux)
echo "127.0.0.1 gameapp.local" | sudo tee -a /etc/hosts

# Or for Windows, edit C:\Windows\System32\drivers\etc\hosts
# Add: 127.0.0.1 gameapp.local
```

## Test Application Access

### Step 6: Test HTTP Access

# 🧪 Test HTTP Access via Ingress
# Test backend API through ingress controller

```bash
# Test via localhost
curl -H "Host: localhost" http://localhost:8080/api/health
```

**Expected Output:**

# ✅ Backend Health via Ingress
# Successful API response through ingress controller

```json
{
  "status": "healthy",
  "services": {
    "database": "connected",
    "redis": "connected"
  },
  "timestamp": "2025-01-15T10:30:00.000Z"
}
```

# 🌐 Test Custom Domain Access
# Test API access using custom domain name

```bash
# Test via gameapp.local (if configured)
curl http://gameapp.local:8080/api/health
```

# 🌐 Test Frontend Access via Ingress
# Verify frontend is accessible through ingress controller

```bash
# Test frontend access
curl -s http://localhost:8080 | grep -o "<title>.*</title>"
```

**Expected Output:**

# 📄 Frontend HTML via Ingress
# Confirmation that frontend is served through ingress

```html
<title>Humor Memory Game</title>
```

### Step 7: Test in Browser

Open your browser and navigate to:
- `http://localhost:8080` - Should show the game interface
- `http://localhost:8080/api/health` - Should show health status
- `http://gameapp.local:8080` (if configured) - Should work the same

[[ADD IMAGE: Browser showing the game interface accessible via ingress]]

## Configure Advanced Ingress Features

### Step 8: Add Rate Limiting

# 🚦 Add Rate Limiting to Ingress
# Configure NGINX rate limiting for API protection

```bash
# Update ingress with rate limiting
kubectl patch ingress humor-game-ingress -n humor-game --type='merge' -p='{
  "metadata": {
    "annotations": {
      "nginx.ingress.kubernetes.io/rate-limit": "100",
      "nginx.ingress.kubernetes.io/rate-limit-window": "1m"
    }
  }
}'
```

### Step 9: Add Request/Response Headers

# 🔒 Add Security Headers to Ingress
# Configure security headers for enhanced protection

```bash
# Add security headers
kubectl patch ingress humor-game-ingress -n humor-game --type='merge' -p='{
  "metadata": {
    "annotations": {
      "nginx.ingress.kubernetes.io/configuration-snippet": |
        more_set_headers \"X-Frame-Options: DENY\";
        more_set_headers \"X-Content-Type-Options: nosniff\";
        more_set_headers \"X-XSS-Protection: 1; mode=block\";
    }
  }
}'
```

### Step 10: Test Advanced Features

# 🧪 Test Rate Limiting
# Verify rate limiting is working by making multiple requests

```bash
# Test rate limiting (make many requests quickly)
for i in {1..10}; do
  curl -w "Status: %{http_code}\n" -o /dev/null -s http://localhost:8080/api/health
done
```

# 🔒 Test Security Headers
# Verify security headers are being sent by ingress

```bash
# Test security headers
curl -I http://localhost:8080
```

**Expected Output:**

# 🔒 Security Headers Response
# Confirmation of security headers in HTTP response

```bash
HTTP/1.1 200 OK
Date: Tue, 15 Jan 2025 10:30:00 GMT
Content-Type: text/html
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
```

## Global Access with Cloudflare Tunnels

### Step 11: Set Up Cloudflare Tunnel (Production)

**🎯 What is Cloudflare Tunnel?**
Cloudflare Tunnels create a secure connection from your local machine to Cloudflare's global network, allowing anyone worldwide to access your application without exposing your local network to the internet.

**Think of it like:** A secure tunnel that connects your local development server to the world through Cloudflare's global network.

**Prerequisites:**
- **Cloudflare Account**: Free account at [cloudflare.com](https://cloudflare.com)
- **Domain**: Any domain you own (or use a free subdomain service)
- **Zero Trust**: Enable in Cloudflare dashboard (free tier available)
- **`cloudflared` CLI**: Command-line tool for tunnel management

**Install cloudflared:**

# 📦 Install Cloudflare Tunnel CLI
# Install cloudflared for tunnel management

```bash
# macOS
brew install cloudflare/cloudflare/cloudflared

# Linux
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin/
```

**Authenticate with Cloudflare:**

# 🔐 Cloudflare Authentication
# Login to Cloudflare and download certificates

```bash
# Login to Cloudflare
cloudflared tunnel login

# This opens browser for authentication
# Select your domain (e.g., gameapp.games)
# Downloads certificate to ~/.cloudflared/
```

**💡 What happens during authentication:**
1. **Browser opens** to Cloudflare login page
2. **Select your domain** from the list (this authorizes the tunnel)
3. **Certificate downloads** to `~/.cloudflared/` folder
4. **Tunnel is authorized** to create connections for your domain

**Create tunnel:**

# 🚇 Create Cloudflare Tunnel
# Create a new tunnel for secure access

```bash
# Create tunnel
cloudflared tunnel create gameapp-tunnel

# Output: Tunnel gameapp-tunnel created with ID: [TUNNEL_ID]
# Save the ID for configuration
```

**💡 Understanding the tunnel creation:**
- **Tunnel name**: `gameapp-tunnel` (you can choose any name)
- **Tunnel ID**: A unique identifier (like `abc123-def456-ghi789`)
- **Credentials file**: `~/.cloudflared/[TUNNEL_ID].json` (contains authentication keys)
- **Purpose**: This tunnel will route traffic from the internet to your local services

**Configure tunnel:**

# ⚙️ Configure Cloudflare Tunnel
# Set up tunnel routing for multiple services

```bash
# Create tunnel configuration
cat > ~/.cloudflared/config.yml << EOF
tunnel: gameapp-tunnel
credentials-file: /Users/$(whoami)/.cloudflared/[TUNNEL_ID].json

ingress:
  - hostname: app.gameapp.games
    service: http://localhost:8080
  - hostname: prometheus.app.gameapp.games
    service: http://localhost:9090
  - hostname: grafana.app.gameapp.games
    service: http://localhost:3000
  - hostname: argocd.app.gameapp.games
    service: http://localhost:8090
  - service: http_status:404
EOF
```

**💡 Understanding the configuration:**
- **`tunnel`**: Name of your tunnel (must match what you created)
- **`credentials-file`**: Path to your tunnel's authentication file
- **`ingress`**: Routing rules that map internet domains to local services
  - `app.gameapp.games` → Your main application (port 8080)
  - `prometheus.app.gameapp.games` → Monitoring (port 9090)
  - `grafana.app.gameapp.games` → Dashboards (port 3000)
  - `argocd.app.gameapp.games` → GitOps (port 8090)
  - `http_status:404` → Default fallback for unmatched requests

**Route tunnel:**

# 🌐 Route Tunnel DNS Records
# Create DNS records for tunnel access

```bash
# Route tunnel to your domain
cloudflared tunnel route dns gameapp-tunnel app.gameapp.games
cloudflared tunnel route dns gameapp-tunnel prometheus.app.gameapp.games
cloudflared tunnel route dns gameapp-tunnel grafana.app.gameapp.games
cloudflared tunnel route dns gameapp-tunnel argocd.app.gameapp.games
```

**💡 What DNS routing does:**
- **Creates DNS records** in Cloudflare for your subdomains
- **Points subdomains** to your tunnel (not your local IP)
- **Enables HTTPS** automatically with Cloudflare certificates
- **Makes services accessible** from anywhere in the world
- **Example**: `app.gameapp.games` now points to your local port 8080 via the tunnel

**Run tunnel:**

# 🚀 Start Cloudflare Tunnel
# Launch tunnel for global access

```bash
# Start tunnel (keep running)
cloudflared tunnel run gameapp-tunnel

# Or run as service
cloudflared tunnel --config ~/.cloudflared/config.yml run gameapp-tunnel
```

**Expected Output:**
```bash
2025-01-15T10:30:00Z INF Starting tunnel tunnelID=[TUNNEL_ID]
2025-01-15T10:30:01Z INF Connection established
2025-01-15T10:30:02Z INF Route propagating
```

### Step 12: Test Global Access

```bash
# Test global access (replace with your domain)
curl https://app.gameapp.games/api/health
curl https://prometheus.app.gameapp.games
curl https://grafana.app.gameapp.games
curl https://argocd.app.gameapp.games
```

**Expected Results:**
- Application accessible globally via HTTPS
- Automatic SSL certificates from Cloudflare
- DDoS protection and CDN acceleration
- No need to expose Kubernetes cluster directly

## Production Domain Configuration

### Step 13: Configure for Production Domain

For production, you would configure a real domain like `gameapp.games`:

```yaml
# Production ingress example (don't apply locally)
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: humor-game-production
  namespace: humor-game
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - gameapp.games
    secretName: gameapp-games-tls
  rules:
  - host: gameapp.games
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: backend
            port:
              number: 3001
```

**[TODO]** Add cert-manager installation and configuration for automatic SSL certificates.

## Monitor Ingress Performance

### Step 12: Check Ingress Metrics

```bash
# View ingress controller logs
kubectl logs -l app.kubernetes.io/name=ingress-nginx -n ingress-nginx --tail=20
```

**Expected Output:**
```bash
2025/01/15 10:30:00 [info] 123#123: Using the pollfd connection method
2025/01/15 10:30:01 [notice] 123#123: nginx/1.21.6
2025/01/15 10:30:01 [notice] 123#123: built with OpenSSL 1.1.1q  5 Jul 2022
192.168.1.100 - - [15/Jan/2025:10:30:02 +0000] "GET /api/health HTTP/1.1" 200 156 "-" "curl/7.79.1"
```

```bash
# Check ingress controller metrics (if metrics enabled)
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller-metrics 9090:10254 &
curl http://localhost:9090/metrics | grep nginx_ingress
```

## ✅ Checkpoint

Your ingress networking is working when:
- ✅ NGINX ingress controller pods are running in `ingress-nginx` namespace
- ✅ Ingress resource shows ADDRESS assigned (usually cluster IP)
- ✅ `curl http://localhost:8080/api/health` returns healthy status
- ✅ Frontend is accessible at `http://localhost:8080` in browser
- ✅ Backend API is accessible at `http://localhost:8080/api/*` 
- ✅ Rate limiting and security headers are applied
- ✅ Ingress logs show successful requests

## Troubleshooting Ingress Issues

### Issue: Ingress Shows No Address

**Symptom:**
```bash
NAME                  CLASS   HOSTS         ADDRESS   PORTS   AGE
humor-game-ingress    nginx   localhost     <none>    80      5m
```

**Diagnosis:**
```bash
# Check ingress controller service
kubectl get svc -n ingress-nginx

# Check k3d port mappings
docker ps | grep k3d
```

**Fix:**
```bash
# Ensure k3d was created with correct port mappings
k3d cluster delete dev-cluster
k3d cluster create dev-cluster --port "8080:80@loadbalancer" --port "8090:443@loadbalancer"
```

### Issue: 404 Not Found

**Symptom:** Ingress returns 404 for all requests

**Diagnosis:**
```bash
# Check ingress paths and backend services
kubectl describe ingress humor-game-ingress -n humor-game

# Verify services exist and have endpoints
kubectl get svc -n humor-game
kubectl get endpoints -n humor-game
```

**Fix:**
```bash
# Ensure backend services are running
kubectl get pods -n humor-game

# Check service selector matches pod labels
kubectl describe svc frontend -n humor-game
kubectl get pods -n humor-game --show-labels
```

### Issue: Backend API Not Accessible

**Symptom:** Frontend loads but `/api/*` returns 502

**Diagnosis:**
```bash
# Check backend service health
kubectl logs -l app=backend -n humor-game --tail=20

# Test backend service directly
kubectl port-forward svc/backend -n humor-game 3001:3001 &
curl http://localhost:3001/api/health
```

**Fix:**
```bash
# Ensure backend is healthy
kubectl get pods -l app=backend -n humor-game

# Check ingress backend configuration
kubectl describe ingress humor-game-ingress -n humor-game
```

## Production Considerations

### SSL/TLS Configuration

For production deployments:

```bash
# Install cert-manager for automatic SSL
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml

# Create Let's Encrypt cluster issuer
cat > cluster-issuer.yaml << EOF
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@domain.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
EOF
```

### High Availability

```bash
# Scale ingress controller for HA
helm upgrade ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.replicaCount=3 \
  --set controller.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].topologyKey=kubernetes.io/hostname
```

## What You Learned

You've implemented production-grade networking:

**Ingress Fundamentals:**
- **Layer 7 Routing**: Host and path-based traffic routing
- **SSL Termination**: Handling HTTPS at the ingress layer
- **Load Balancing**: Distributing traffic across multiple pods
- **Traffic Management**: Rate limiting and request/response modification

**Production Patterns:**
- **Domain Configuration**: Real-world domain and DNS setup
- **Security Headers**: Browser security protection
- **Monitoring Integration**: Metrics and logging for troubleshooting
- **High Availability**: Multi-replica ingress controllers

**Networking Skills:**
- **Kubernetes Services**: Understanding ClusterIP, NodePort, LoadBalancer
- **Ingress Controllers**: NGINX configuration and management
- **DNS Integration**: Local and production domain configuration
- **Certificate Management**: SSL/TLS automation with cert-manager

This networking setup provides the foundation for production traffic handling. Your application is now accessible from the internet with proper security and performance characteristics.

---

**Next**: [Chapter 7: CI/CD Pipeline Implementation](07-ci-cd.md) - Automate your deployment workflow
**Previous**: [Chapter 5: Kubernetes Basics](05-kubernetes-basics.md) - Deploying your application to Kubernetes
