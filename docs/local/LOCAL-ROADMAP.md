# Local Completion Roadmap

This roadmap is the practical, step-by-step path for completing the Humor Memory Game project on a local machine. It follows the existing local documentation, but corrects a few repo-specific mismatches so the commands match the files that are actually present.

Use this as the working checklist. Complete one phase, verify the checkpoint, then move to the next phase.

## Source Guides

- [home-lab.md](../../home-lab.md)
- [FILE-STRUCTURE.md](../../FILE-STRUCTURE.md)
- [00-overview.md](00-overview.md)
- [01-prereqs.md](01-prereqs.md)
- [02-compose.md](02-compose.md)
- [03-k8s-basics.md](03-k8s-basics.md)
- [04-ingress.md](04-ingress.md)
- [05-observability.md](05-observability.md)
- [06-gitops.md](06-gitops.md)
- [07-global.md](07-global.md)
- [08-troubleshooting.md](08-troubleshooting.md)

## Corrections To Keep In Mind

The existing docs are useful, but a few names and paths drifted over time:

- `home-lab.md` links to `docs/00-overview.md`, but the active local guides are in `docs/local/`.
- `FILE-STRUCTURE.md` mentions `scripts/deploy-with-secrets.sh`, but that script is not currently in this repo.
- The Kubernetes docs say to apply `k8s/secrets.yaml`, but only `k8s/secrets.template.yaml` exists. Create `k8s/secrets.yaml` before deploying Kubernetes resources.
- `k8s/secrets.template.yaml` uses old names. The manifests expect:
  - Secret name: `humor-game-secrets`
  - Namespace: `humor-game`
  - Keys: `DB_PASSWORD`, `REDIS_PASSWORD`, `JWT_SECRET`
- Docker Compose access goes through the reverse proxy at `http://localhost:3000`.
- Kubernetes service names are `backend` and `frontend`, not `humor-game-backend` or `humor-game-frontend`.
- The repo's k3d config names the cluster `humor-game-cluster`. Use that name consistently.
- The project contains demo production domains such as `gameapp.games`. Replace them with your own domain before attempting global access.

## Phase 0: Git Remote Setup

Goal: make sure this clone points to your GitHub repository.

```bash
cd /Users/cndivine/Desktop/practice/Game-Project
git remote -v
git remote set-url origin https://github.com/nsohchunhung/Game-Project.git
git remote -v
git status
```

Checkpoint:

- `origin` points to `https://github.com/nsohchunhung/Game-Project.git`.
- `git status` shows the current branch and any local changes.

## Phase 1: Local Tool Check

Goal: confirm your machine has the tools needed for the project.

```bash
docker --version
docker compose version
kubectl version --client
k3d version
helm version
node --version
npm --version
jq --version
docker info
```

Checkpoint:

- Docker is running.
- Docker Compose, kubectl, k3d, Helm, Node.js, npm, and jq all return versions.
- Docker has enough resources available for local containers and k3d.

If Docker Desktop is unavailable on macOS, Colima is a workable fallback:

```bash
brew install colima
colima start --cpu 2 --memory 4 --disk 20
```

## Phase 2: Docker Compose Run

Goal: prove the app works before moving to Kubernetes.

```bash
docker compose build
docker compose up -d
docker compose ps
```

Test the backend and frontend:

```bash
curl http://localhost:3001/health
curl -I http://localhost:3000/
```

Open the app:

```text
http://localhost:3000
```

Checkpoint:

- PostgreSQL, Redis, backend, frontend, and reverse proxy containers are running.
- `http://localhost:3001/health` returns a healthy response.
- `http://localhost:3000` loads the game.
- Starting a game does not show API connection errors in the browser console.

Useful troubleshooting:

```bash
docker compose logs backend
docker compose logs frontend
docker compose logs postgres
docker compose logs redis
```

Reset Docker Compose if needed:

```bash
docker compose down
docker compose up -d
```

Full reset with data deletion:

```bash
docker compose down -v --remove-orphans
docker compose build
docker compose up -d
```

## Phase 3: Create The Kubernetes Secret

Goal: create the missing `k8s/secrets.yaml` file expected by the Kubernetes manifests.

Create `k8s/secrets.yaml` with this content:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: humor-game-secrets
  namespace: humor-game
type: Opaque
stringData:
  DB_PASSWORD: gamepass123
  REDIS_PASSWORD: gamepass123
  JWT_SECRET: change-this-local-dev-secret
```

Checkpoint:

- `k8s/secrets.yaml` exists locally.
- It is not committed if your `.gitignore` excludes it.
- The secret name, namespace, and key names match the manifests.

Security note:

- This is acceptable for local development.
- For production, use stronger secrets and a real secret-management workflow.

## Phase 4: Local Kubernetes With k3d

Goal: create the local Kubernetes cluster and deploy the application.

Create the local registry:

```bash
k3d registry create k3d-registry --port 5000
```

Create the cluster from the repo config:

```bash
k3d cluster create --config k3d-config.yaml
kubectl get nodes
```

Build and import local images:

```bash
docker build -t humor-game-backend:latest ./backend
docker build -t humor-game-frontend:latest ./frontend
k3d image import humor-game-backend:latest -c humor-game-cluster
k3d image import humor-game-frontend:latest -c humor-game-cluster
```

Deploy Kubernetes resources:

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secrets.yaml
kubectl apply -f k8s/postgres.yaml
kubectl apply -f k8s/redis.yaml
kubectl apply -f k8s/backend.yaml
kubectl apply -f k8s/frontend.yaml
```

Check status:

```bash
kubectl get pods -n humor-game
kubectl get svc -n humor-game
```

Checkpoint:

- `postgres`, `redis`, `backend`, and `frontend` pods are running.
- Services named `postgres`, `redis`, `backend`, and `frontend` exist in the `humor-game` namespace.

Useful troubleshooting:

```bash
kubectl describe pod <pod-name> -n humor-game
kubectl logs deployment/backend -n humor-game
kubectl logs deployment/frontend -n humor-game
kubectl logs deployment/postgres -n humor-game
kubectl logs deployment/redis -n humor-game
```

## Phase 5: Kubernetes App Test

Goal: verify the app works inside the cluster before adding Ingress.

Start backend port-forwarding in one terminal:

```bash
kubectl port-forward svc/backend 3001:3001 -n humor-game
```

In another terminal, test:

```bash
curl http://localhost:3001/health
```

Start frontend port-forwarding:

```bash
kubectl port-forward svc/frontend 3000:80 -n humor-game
```

Open:

```text
http://localhost:3000
```

Checkpoint:

- Backend health check succeeds.
- Frontend loads.
- Game actions do not show API errors.

Stop port-forwarding before moving to Ingress:

```bash
pkill -f "kubectl port-forward"
```

## Phase 6: Ingress

Goal: access the app through production-style HTTP routing.

Install ingress-nginx:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/baremetal/deploy.yaml
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
```

Apply the app ingress:

```bash
kubectl apply -f k8s/ingress.yaml
kubectl get ingress -n humor-game
```

Add the local host entry:

```bash
echo "127.0.0.1 gameapp.local" | sudo tee -a /etc/hosts
```

Test through the k3d load balancer:

```bash
curl -H "Host: gameapp.local" -I http://localhost:8080/
curl -H "Host: gameapp.local" http://localhost:8080/api/health
```

Open:

```text
http://gameapp.local:8080
```

Checkpoint:

- Ingress controller is running in `ingress-nginx`.
- `gameapp.local` resolves to `127.0.0.1`.
- The app loads at `http://gameapp.local:8080`.
- `/api/health` routes to the backend through Ingress.

## Phase 7: Observability

Goal: deploy Prometheus and Grafana.

```bash
kubectl apply -f k8s/prometheus-rbac.yaml
kubectl apply -f k8s/monitoring.yaml
kubectl wait --for=condition=ready pod -l app=prometheus -n monitoring --timeout=300s
kubectl wait --for=condition=ready pod -l app=grafana -n monitoring --timeout=300s
kubectl get pods -n monitoring
```

Access Prometheus:

```bash
kubectl port-forward svc/prometheus 9090:9090 -n monitoring
```

Access Grafana:

```bash
kubectl port-forward svc/grafana 3000:3000 -n monitoring
```

Open:

```text
http://localhost:9090
http://localhost:3000
```

Grafana login:

```text
admin / admin123
```

Import the recommended dashboard:

```text
k8s/comprehensive-dashboard.json
```

Generate sample traffic:

```bash
chmod +x scripts/populate-game-metrics.sh
./scripts/populate-game-metrics.sh
```

Checkpoint:

- Prometheus is reachable at `http://localhost:9090`.
- Grafana is reachable at `http://localhost:3000`.
- The Grafana dashboard imports successfully.
- Metrics appear after traffic is generated.

## Phase 8: GitOps With ArgoCD

Goal: install ArgoCD and connect it to your GitHub repository.

Install ArgoCD:

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=ready pod -l app.kubernetes.io/component=server -n argocd --timeout=300s
```

Get the admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Access ArgoCD:

```bash
kubectl port-forward svc/argocd-server -n argocd 8090:443
```

Open:

```text
http://localhost:8090
```

Login:

```text
admin / <password from command above>
```

Before applying the GitOps manifests, update repo URLs in:

- `gitops-safe/argocd-project.yaml`
- `gitops-safe/argocd-application.yaml`

Use:

```text
https://github.com/nsohchunhung/Game-Project.git
```

Then apply:

```bash
kubectl apply -f gitops-safe/argocd-project.yaml
kubectl apply -f gitops-safe/argocd-application.yaml
kubectl get applications -n argocd
```

Checkpoint:

- ArgoCD UI loads.
- ArgoCD can access your GitHub repo.
- The application appears in ArgoCD.
- `OutOfSync` is acceptable while learning; it means ArgoCD detected a difference between Git and the cluster.

## Phase 9: Production Hardening

Goal: add autoscaling, security contexts, and network policies.

```bash
kubectl apply -f k8s/hpa.yaml
kubectl apply -f k8s/security-context.yaml
kubectl apply -f k8s/network-policies.yaml
kubectl get hpa -n humor-game
kubectl get networkpolicy -n humor-game
```

Verify the app still works:

```bash
curl -H "Host: gameapp.local" http://localhost:8080/api/health
```

Checkpoint:

- HPA resources exist.
- Network policies exist.
- The app still loads and the API still responds.

If traffic breaks after this phase, inspect network policies first:

```bash
kubectl describe networkpolicy -n humor-game
kubectl delete networkpolicy --all -n humor-game
```

## Phase 10: Optional Global Access

Goal: expose your local app through Cloudflare Tunnel.

Only start this phase after local Kubernetes, Ingress, monitoring, and ArgoCD are stable.

Prerequisites:

- A real domain managed by Cloudflare.
- `cloudflared` installed.
- Demo domains such as `gameapp.games` replaced with your actual domain.

Install `cloudflared` on macOS:

```bash
brew install cloudflare/cloudflare/cloudflared
cloudflared --version
```

Authenticate:

```bash
cloudflared tunnel login
```

Create a tunnel:

```bash
cloudflared tunnel create gameapp-tunnel
cloudflared tunnel list
```

Create DNS routes after replacing `yourdomain.com`:

```bash
cloudflared tunnel route dns gameapp-tunnel gameapp.yourdomain.com
cloudflared tunnel route dns gameapp-tunnel grafana.yourdomain.com
cloudflared tunnel route dns gameapp-tunnel prometheus.yourdomain.com
cloudflared tunnel route dns gameapp-tunnel argocd.yourdomain.com
```

Run the tunnel:

```bash
cloudflared tunnel run gameapp-tunnel
```

Checkpoint:

- `https://gameapp.yourdomain.com` reaches the local app.
- Optional monitoring and ArgoCD subdomains work.
- Cloudflare is handling public HTTPS.

## Daily Working Loop

Use this loop whenever making changes:

```bash
git status
docker compose ps
kubectl get pods -n humor-game
kubectl get ingress -A
curl -H "Host: gameapp.local" http://localhost:8080/api/health
```

After backend or frontend code changes:

```bash
docker build -t humor-game-backend:latest ./backend
docker build -t humor-game-frontend:latest ./frontend
k3d image import humor-game-backend:latest -c humor-game-cluster
k3d image import humor-game-frontend:latest -c humor-game-cluster
kubectl rollout restart deployment/backend -n humor-game
kubectl rollout restart deployment/frontend -n humor-game
kubectl rollout status deployment/backend -n humor-game
kubectl rollout status deployment/frontend -n humor-game
```

## Completion Criteria

The local project is complete when:

- Docker Compose runs the app successfully.
- k3d cluster `humor-game-cluster` runs the Kubernetes version.
- `postgres`, `redis`, `backend`, and `frontend` pods run in the `humor-game` namespace.
- Ingress serves the app at `http://gameapp.local:8080`.
- Prometheus and Grafana run in the `monitoring` namespace.
- Grafana has a working imported dashboard.
- ArgoCD runs in the `argocd` namespace and tracks the GitOps app.
- HPA and network policies are applied without breaking the app.
- Optional: Cloudflare Tunnel exposes the app through your real domain.

