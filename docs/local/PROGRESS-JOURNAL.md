# Local Build Progress Journal

This journal records each step we take while completing the local Humor Memory Game project. It includes commands run by the learner, results observed, problems encountered, and fixes applied.

Keep this file updated as we proceed so the project has a clear learning trail and a practical troubleshooting history.

## Session 6: Monitoring Recovery

Date: 2026-05-07

### Goal

Repair the local monitoring stack so Grafana and Prometheus can run in k3d and be opened with `kubectl port-forward`.

### Problem 1: Grafana Port-Forward Failed Because The Pod Was Pending

Observed:

```text
error: unable to forward port because pod is not running. Current status=Pending
```

Why this mattered:

- The failure was not a local port conflict this time.
- Kubernetes had no running Grafana pod behind `svc/grafana`.

### Investigation

Commands used:

```bash
kubectl get pods,deploy,svc,cm,pvc -n monitoring -o wide
kubectl describe pod -l app=grafana -n monitoring
rg -n "ServiceMonitor|grafana-datasources|grafana-dashboards|monitoring.coreos.com" k8s/monitoring.yaml k8s/simple-monitoring.yaml
```

Observed:

- `grafana` and `prometheus` pods were both `Pending`.
- `grafana-datasources` and `grafana-dashboards` ConfigMaps existed.
- Grafana repeatedly showed `FailedMount` events such as:

```text
MountVolume.SetUp failed for volume "grafana-datasources" : object "monitoring"/"grafana-datasources" not registered
MountVolume.SetUp failed for volume "grafana-dashboards" : object "monitoring"/"grafana-dashboards" not registered
```

- `k8s/monitoring.yaml` includes `ServiceMonitor` resources.
- The cluster does not have Prometheus Operator CRDs installed.

### Diagnosis

- `k8s/monitoring.yaml` is too advanced for the current local cluster because it expects Prometheus Operator CRDs.
- The monitoring namespace was left in a stale, half-applied state after earlier CRD errors and control-plane instability.
- The repo already had a safer local-first manifest: `k8s/simple-monitoring.yaml`.

### Correction Applied In The Repo

- Updated `k8s/simple-monitoring.yaml` so Prometheus targets the app services with fully qualified DNS names:
  - `backend.humor-game.svc.cluster.local:3001`
  - `frontend.humor-game.svc.cluster.local:80`
- Updated `docs/local/LOCAL-ROADMAP.md` so Phase 7 uses `k8s/simple-monitoring.yaml` by default.

### Next Repair Action

- Redeploy the `monitoring` namespace cleanly with the simple manifest.
- Verify both monitoring pods become `Running`.

### What Actually Happened During Repair

The first namespace-level cleanup exposed a deeper cluster problem:

- the k3d control-plane container was restart-looping
- `docker inspect` showed the restart count climbing rapidly
- the server logs showed networking initialization failures during startup

Because of that, a normal namespace repair would not stick. The fix became:

```bash
k3d cluster delete humor-game-cluster
k3d cluster create --config k3d-config.yaml
kubectl config set-cluster k3d-humor-game-cluster --server=https://127.0.0.1:<new-port>
```

After the fresh cluster came up:

- local app images were re-imported into k3d
- the Humor Game Kubernetes manifests were re-applied
- the backend deployment was restarted once PostgreSQL became healthy
- `k8s/simple-monitoring.yaml` was created on the new cluster

### Final Result

Verified healthy:

```text
humor-game namespace
- backend   Running
- frontend  Running
- postgres  Running
- redis     Running

monitoring namespace
- grafana     Running
- prometheus  Running
```

This resolved the original Grafana problem:

```text
error: unable to forward port because pod is not running. Current status=Pending
```

because Grafana is now a running pod again.

## Session 1: Local Setup And Docker Compose Start

Date: 2026-04-18

### Goal

Start the local completion roadmap and begin with tool readiness plus Docker Compose validation.

### Step 1: Verify Required Local Tools

Commands checked:

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

Observed versions:

```text
Docker version 29.3.1
Docker Compose version 5.1.1
kubectl client v1.35.3
Kustomize v5.7.1
k3d v5.8.3
k3s v1.33.6-k3s1
Helm v4.1.3
Node.js v25.9.0
npm 11.12.1
jq 1.8.1
```

Result:

- Required tools are installed.
- Docker is using the `colima` context.

### Problem 1: Docker Memory Was Too Low For The Full Roadmap

Observed from `docker info`:

```text
Total Memory: 1.92GiB
```

Why this matters:

- Docker Compose might run with this amount of memory.
- k3d plus PostgreSQL, Redis, backend, frontend, ingress, Prometheus, Grafana, and ArgoCD is likely to be unstable under 2 GiB.

Fix applied:

```bash
colima stop
colima start --cpu 2 --memory 4 --disk 20
```

Observed after restart:

```text
Total Memory: 3.822GiB
```

Result:

- Colima is now sized appropriately for the local Kubernetes phases.
- The disk-size warning during startup was harmless because Colima cannot shrink an existing disk.

### Step 2: Check Disk Space

Command:

```bash
df -h .
```

Observed:

```text
426Gi available
```

Result:

- Disk space is sufficient.

### Problem 2: Root `.env` File Was Missing

Observed:

```bash
test -f .env && printf '.env exists\n' || printf '.env missing\n'
```

Output:

```text
.env missing
```

Why this matters:

- `docker-compose.override.yml` loads a root `.env` file for local configuration.
- Without it, Compose may fail or use incomplete defaults.

Fix applied:

Created `.env` with local development values:

```env
NODE_ENV=development
PORT=3001
API_PORT=3001
API_BASE_URL=/api

DB_HOST=postgres
DB_PORT=5432
DB_NAME=humor_memory_game
DB_USER=gameuser
DB_PASSWORD=gamepass123

REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD=gamepass123

FRONTEND_PORT=80
FRONTEND_URL=http://localhost:3000
CORS_ORIGIN=http://localhost:3000

JWT_SECRET=local-dev-jwt-secret-change-before-production
SESSION_SECRET=local-dev-session-secret-change-before-production

GRAFANA_ADMIN_USER=admin
GRAFANA_ADMIN_PASSWORD=admin123
```

Safety note:

- `.env` is already ignored by `.gitignore`.
- This file is for local development only and should not be committed.

### Step 3: Validate Docker Compose Configuration

Learner ran:

```bash
docker compose config --quiet
```

Observed:

```text
No output
```

Meaning:

- No output means Compose successfully parsed the configuration.

Result:

- Docker Compose config is valid.

### Step 4: Confirm Nothing Is Running Yet

Learner ran:

```bash
docker compose ps
```

Observed:

```text
NAME      IMAGE     COMMAND   SERVICE   CREATED   STATUS    PORTS
```

Meaning:

- Compose is working.
- No project containers are currently running.

Result:

- We are ready to build images with `docker compose build`.

### Step 5: Build Docker Images

Learner ran:

```bash
docker compose build
```

Observed result:

- Backend image built successfully:

```text
Successfully tagged game-project-backend:latest
```

- Frontend image built successfully:

```text
Successfully tagged game-project-frontend:latest
```

- Final Compose summary:

```text
[+] build 2/2
 ✔ Image game-project-backend  Built
 ✔ Image game-project-frontend Built
```

Verified local images:

```text
game-project-frontend:latest bc739111fd8c 99.1MB
game-project-backend:latest cfd0cc4b48cc 238MB
```

Result:

- Docker image build succeeded.
- We can proceed to `docker compose up -d` after reviewing warnings.

### Warning Review From Docker Build

#### Warning 1: Missing Buildx Plugin

Observed:

```text
Docker Compose requires buildx plugin to be installed
```

Meaning:

- Docker Compose wanted to use the newer BuildKit/buildx builder.
- Docker fell back to the classic builder and still completed the build.

Impact:

- Not blocking.
- Build may be slower and misses newer build features.

Recommended future fix:

```bash
brew install docker-buildx
```

Then confirm:

```bash
docker buildx version
```

#### Warning 2: Alpine APK Cache Warnings

Observed:

```text
WARNING: opening from cache https://dl-cdn.alpinelinux.org/alpine/v3.21/main: No such file or directory
WARNING: opening from cache https://dl-cdn.alpinelinux.org/alpine/v3.21/community: No such file or directory
```

Meaning:

- Alpine package manager did not find a local package index cache.
- It fetched packages successfully from the network.

Impact:

- Not blocking.
- No repo change required.

#### Warning 3: Deprecated npm Flag

Observed:

```text
npm warn config only Use `--omit=dev` to omit dev dependencies from the install.
```

Cause:

- `backend/Dockerfile` used the older command:

```dockerfile
RUN npm ci --only=production && npm cache clean --force
```

Fix applied:

```dockerfile
RUN npm ci --omit=dev && npm cache clean --force
```

Result:

- Next backend image build should not show this warning.

#### Warning 4: npm Vulnerability Notices

Observed:

```text
Backend: 4 vulnerabilities (1 low, 1 moderate, 2 high)
Frontend: 2 moderate severity vulnerabilities
```

Meaning:

- npm found dependency advisories in installed packages.

Impact:

- Needs review, but not safe to auto-fix blindly because `npm audit fix` can change package versions and behavior.

Recommended next diagnostic step:

```bash
cd backend && npm audit
cd ../frontend && npm audit
```

Then decide whether fixes are safe.

#### Warning 5: Unused Build Argument

Observed:

```text
[Warning] One or more build-args [BUILDKIT_INLINE_CACHE] were not consumed
```

Cause:

- `docker-compose.yml` passed `BUILDKIT_INLINE_CACHE`, but neither Dockerfile declared or used that build argument.

Fix applied:

- Removed the unused `BUILDKIT_INLINE_CACHE` build args from backend and frontend build config in `docker-compose.yml`.

Result:

- Next build should not show this warning.

### Next Step

Rebuild after the warning cleanup:

```bash
docker compose build
```

Expected:

- Backend and frontend images still build successfully.
- The deprecated npm flag warning should be gone.
- The unused build-arg warning should be gone.
- The missing buildx warning may remain until buildx is installed locally.

### Step 6: Rebuild After Warning Cleanup

Learner reran:

```bash
docker compose build
```

Observed:

```text
[+] build 2/2
 ✔ Image game-project-frontend Built
 ✔ Image game-project-backend  Built
```

Result:

- Backend and frontend builds succeeded again.
- The previous repo-caused warnings were no longer present in the reported final output.

### Improvement 1: Use Project-Specific Image Names

Learner requested image names:

```text
humor-game-backend
humor-game-frontend
```

Reason:

- Docker Compose's default image names were based on the folder name:

```text
game-project-backend
game-project-frontend
```

- The Kubernetes manifests already expect:

```yaml
image: humor-game-backend:latest
image: humor-game-frontend:latest
```

Fix applied:

Added explicit image names to `docker-compose.yml`:

```yaml
backend:
  image: humor-game-backend:latest

frontend:
  image: humor-game-frontend:latest
```

Result:

- Future `docker compose build` runs will tag images with the same names used by Kubernetes.

Next verification command:

```bash
docker compose build
docker images | grep humor-game
```

Learner verified image names:

```text
IMAGE                        ID             DISK USAGE   CONTENT SIZE
humor-game-backend:latest    33c0c45f7088        238MB         54.2MB
humor-game-frontend:latest   3422a67ac94c         99MB         27.5MB
```

Result:

- Image naming is now aligned between Docker Compose and Kubernetes.

### Next Step

Start the Docker Compose application:

```bash
docker compose up -d
```

Then check status:

```bash
docker compose ps
```

### Step 7: Start Docker Compose Stack

Learner ran:

```bash
docker compose up -d
```

Observed:

```text
[+] up 33/33
 ✔ Image redis:7-alpine                  Pulled
 ✔ Image postgres:15-alpine              Pulled
 ✔ Network game-project_backend-network  Created
 ✔ Network game-project_frontend-network Created
 ✔ Volume game-project_postgres_data     Created
 ✔ Volume game-project_redis_data        Created
 ✔ Container humor-game-redis            Healthy
 ✔ Container humor-game-postgres         Healthy
 ✔ Container humor-game-backend          Started
 ✔ Container humor-game-frontend         Started
 ✔ Container humor-game-reverse-proxy    Started
```

Meaning:

- Docker pulled the database/cache base images.
- Docker created isolated frontend/backend networks.
- Docker created persistent volumes for PostgreSQL and Redis.
- PostgreSQL and Redis passed their health checks.
- Backend, frontend, and reverse proxy started.

Learner checked status:

```bash
docker compose ps
```

Observed:

```text
NAME                       IMAGE                        SERVICE         STATUS                    PORTS
humor-game-backend         humor-game-backend:latest    backend         Up                        0.0.0.0:3001->3001/tcp
humor-game-frontend        humor-game-frontend:latest   frontend        Up (healthy)              80/tcp
humor-game-postgres        postgres:15-alpine           postgres        Up (healthy)              5432/tcp
humor-game-redis           redis:7-alpine               redis           Up (healthy)              6379/tcp
humor-game-reverse-proxy   nginx:alpine                 reverse-proxy   Up                        0.0.0.0:3000->80/tcp
```

Result:

- Docker Compose stack started successfully.
- The browser-facing entry point is `http://localhost:3000`.
- The backend debug port is `http://localhost:3001`.

### Next Step

Test the running app:

```bash
curl http://localhost:3001/health
curl -I http://localhost:3000/
```

### Step 8: Test Backend Health

Learner ran:

```bash
curl http://localhost:3001/health
```

Observed:

```json
{
  "status": "healthy",
  "timestamp": "2026-04-19T22:11:20.504Z",
  "services": {
    "database": "connected",
    "redis": "connected",
    "api": "running"
  },
  "version": "1.0.0",
  "environment": "development"
}
```

Meaning:

- Backend API is reachable on `localhost:3001`.
- PostgreSQL connection is working.
- Redis connection is working.
- API is running in development mode.

Result:

- Backend health check passed.

### Step 9: Browser Game Test

Learner opened the app and confirmed the game UI rendered.

Observed game state:

```text
Humor Memory Game
A DevOps Learning Adventure!
Player: gameuser
Score: 0
Moves: 0
Time: 02:51
Pairs: 0 / 8
Pause / New Game / Quit controls visible
Cards rendered and visible
```

Meaning:

- Reverse proxy and frontend are serving the app successfully.
- The browser-facing entry point works.
- Game UI assets and scripts are loading.
- The app can start an active game session.

Result:

- Docker Compose milestone is functionally complete.

### Phase 2 Checkpoint

Docker Compose is complete when:

- Backend health returns `healthy`.
- PostgreSQL shows `connected`.
- Redis shows `connected`.
- Frontend loads in the browser.
- A game can be started and cards render.

Status:

```text
PASS
```

### Next Phase

Move to Phase 3: create the Kubernetes secret required by the Kubernetes manifests.

## Phase 3: Kubernetes Secret Setup

### Step 10: Check Secret File Git Status

Learner ran:

```bash
git status --short
```

Observed:

```text
 M backend/Dockerfile
 M docker-compose.yml
 M docs/local/LOCAL-ROADMAP.md
 M k8s/secrets.yaml
?? docs/local/PROGRESS-JOURNAL.md
```

Problem:

- `k8s/secrets.yaml` appears as modified instead of being ignored.

Meaning:

- The file is already tracked by Git.
- `.gitignore` only prevents new untracked files from being added.
- If a file is already tracked, Git will continue showing changes even if the path is listed in `.gitignore`.

Why this matters:

- `k8s/secrets.yaml` contains local secret values.
- Local secrets should not be committed.
- The project should track a template such as `k8s/secrets.template.yaml`, not the real secret file.

Fix to apply next:

```bash
git rm --cached k8s/secrets.yaml
```

Important:

- This removes `k8s/secrets.yaml` from Git tracking.
- It does not delete the local file from disk.
- After this, `.gitignore` should hide future local edits to `k8s/secrets.yaml`.

Fix applied by learner:

```bash
git rm --cached k8s/secrets.yaml
```

Observed:

```text
rm 'k8s/secrets.yaml'
```

Learner checked Git status:

```bash
git status --short
```

Observed:

```text
 M backend/Dockerfile
 M docker-compose.yml
 M docs/local/LOCAL-ROADMAP.md
D  k8s/secrets.yaml
?? docs/local/PROGRESS-JOURNAL.md
```

Meaning:

- Git will remove `k8s/secrets.yaml` from repository tracking on the next commit.
- Local file changes will be ignored afterward because `.gitignore` already includes `k8s/secrets.yaml`.

Learner confirmed the file still exists locally:

```bash
ls k8s/secrets.yaml
```

Observed:

```text
k8s/secrets.yaml
```

Result:

- Secret tracking issue fixed.
- Local Kubernetes secret file remains available.

### Next Step

Inspect the local secret file and confirm it has the expected names:

```bash
cat k8s/secrets.yaml
```

### Problem 4: Secret File Included Shell Heredoc Wrapper

Learner ran:

```bash
cat k8s/secrets.yaml
```

Observed:

```text
cat > k8s/secrets.yaml <<'EOF'
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
EOF
```

Problem:

- The file contained the shell command wrapper:

```text
cat > k8s/secrets.yaml <<'EOF'
EOF
```

- Kubernetes expects pure YAML, so this file would fail to apply.

Cause:

- The heredoc command text was saved into the file instead of only the YAML body.

Fix applied:

- Removed the first heredoc line and final `EOF` line from `k8s/secrets.yaml`.

Expected corrected file:

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

Verified corrected file:

```text
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

### Problem 5: kubectl Dry-Run Tried To Contact An Unavailable Cluster

Command attempted:

```bash
kubectl apply --dry-run=client -f k8s/secrets.yaml
```

Observed:

```text
failed to download openapi: Get "https://0.0.0.0:52023/openapi/v2?timeout=32s": dial tcp 0.0.0.0:52023: connect: connection refused
```

Meaning:

- The YAML file is not necessarily wrong.
- `kubectl` tried to contact the Kubernetes API server for schema validation.
- No active cluster is currently available at the saved kubeconfig endpoint.

Why this is expected right now:

- We have not created the k3d cluster for this project yet.
- The current kubeconfig may point to an old local cluster.

Safe validation workaround before the cluster exists:

```bash
kubectl apply --dry-run=client --validate=false -f k8s/secrets.yaml
```

Later, after the k3d cluster exists, normal validation should work.

Learner tried:

```bash
kubectl apply --dry-run=client --validate=false -f k8s/secrets.yaml
```

Observed:

```text
E0419 20:24:15.841048   99545 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: Get \"https://0.0.0.0:52023/api?timeout=32s\": dial tcp 0.0.0.0:52023: connect: connection refused"
error: unable to recognize "k8s/secrets.yaml": Get "https://0.0.0.0:52023/api?timeout=32s": dial tcp 0.0.0.0:52023: connect: connection refused
```

Correction:

- `--validate=false` disables schema validation, but `kubectl apply` still contacts the cluster to discover API resource types.
- Because the current kubeconfig points to an unavailable cluster, even client dry-run cannot complete right now.

Better pre-cluster validation:

```bash
ruby -e 'require "yaml"; YAML.load_file("k8s/secrets.yaml"); puts "YAML OK"'
```

Next project step:

- Create the k3d cluster.
- After the cluster exists, re-run `kubectl apply --dry-run=client -f k8s/secrets.yaml` or apply the secret for real.

## Phase 4: Local Kubernetes With k3d

### Step 11: Create k3d Registry And Cluster

Learner ran:

```bash
k3d registry create k3d-registry --port 5000
k3d cluster create --config k3d-config.yaml
```

Observed registry failure:

```text
Failed to create registry: failed to create registry node 'k3d-k3d-registry'
docker failed to pull image 'docker.io/library/registry:2'
failed to resolve reference "docker.io/library/registry:2"
lookup registry-1.docker.io on 192.168.5.1:53: no such host
```

Meaning:

- k3d tried to create a local Docker registry.
- To do that, Docker needed to pull `registry:2` from Docker Hub.
- Docker/Colima could not resolve `registry-1.docker.io`.
- This is a DNS problem inside the Docker/Colima environment, not a project YAML problem.

Observed cluster failure:

```text
Failed to find registry node 'k3d-k3d-registry'
Cluster creation FAILED
```

Meaning:

- `k3d-config.yaml` expects a registry named `k3d-k3d-registry:5000`.
- Because registry creation failed first, cluster creation could not attach to that registry.

Important sequence:

1. Fix Docker/Colima DNS.
2. Confirm Docker can pull `registry:2`.
3. Create the k3d registry.
4. Create the k3d cluster.

Next diagnostic commands:

```bash
nslookup registry-1.docker.io
docker pull registry:2
```

If Docker still cannot resolve Docker Hub, restart Colima with explicit DNS:

```bash
colima stop
colima start --cpu 2 --memory 4 --dns 1.1.1.1 --dns 8.8.8.8
docker pull registry:2
```

Learner ran:

```bash
nslookup registry-1.docker.io
docker pull registry:2
```

Observed:

```text
Server:         8.8.8.8
Name:   registry-1.docker.io
Address: 100.27.240.114
Address: 23.20.72.109
Address: 34.233.14.88
Address: 54.225.36.192
Address: 107.21.112.168
Address: 54.159.86.7
Address: 34.195.176.175
Address: 54.210.213.255
```

Docker pull result:

```text
2: Pulling from library/registry
Digest: sha256:a3d8aaa63ed8681a604f1dea0aa03f100d5895b6a58ace528858a7b332415373
Status: Image is up to date for registry:2
docker.io/library/registry:2
```

Meaning:

- Host DNS works.
- Docker can now pull `registry:2`.
- The original k3d registry blocker is cleared.

Next step:

```bash
k3d registry create k3d-registry --port 5000
k3d registry list
```

Learner ran:

```bash
k3d registry create k3d-registry --port 5000
k3d registry list
```

Observed:

```text
FATA[0000] Failed to create registry: A registry node with that name already exists
NAME               ROLE       CLUSTER   STATUS
k3d-k3d-registry   registry             running
```

Meaning:

- The registry already exists.
- The registry is running.
- The `FATA` message is not a blocker in this case because the desired registry is already present.

Result:

- Registry prerequisite is satisfied.

Next step:

```bash
k3d cluster create --config k3d-config.yaml
kubectl get nodes
```

Learner verified nodes:

```bash
kubectl get nodes
```

Observed:

```text
NAME                              STATUS   ROLES                  AGE     VERSION
k3d-humor-game-cluster-agent-0    Ready    <none>                 102s    v1.33.6+k3s1
k3d-humor-game-cluster-agent-1    Ready    <none>                 103s    v1.33.6+k3s1
k3d-humor-game-cluster-server-0   Ready    control-plane,master   2m11s   v1.33.6+k3s1
```

Meaning:

- The local k3d Kubernetes cluster was created successfully.
- The cluster has one control-plane node and two worker nodes.
- All nodes are `Ready`.

Result:

- k3d cluster prerequisite is satisfied.

Next step:

```bash
k3d image import humor-game-backend:latest -c humor-game-cluster
k3d image import humor-game-frontend:latest -c humor-game-cluster
```

Learner ran:

```bash
k3d image import humor-game-backend:latest -c humor-game-cluster
k3d image import humor-game-frontend:latest -c humor-game-cluster
```

Observed:

```text
Successfully imported image(s)
Successfully imported 1 image(s) into 1 cluster(s)
Successfully imported image(s)
Successfully imported 1 image(s) into 1 cluster(s)
```

Meaning:

- `humor-game-backend:latest` is now available inside the k3d cluster nodes.
- `humor-game-frontend:latest` is now available inside the k3d cluster nodes.
- This is required because the manifests use `imagePullPolicy: Never`.

Learner verified cluster list:

```bash
k3d cluster list
```

Observed:

```text
NAME                 SERVERS   AGENTS   LOADBALANCER
humor-game-cluster   1/1       2/2      true
```

Result:

- Image import is complete.
- Cluster remains healthy.

Next step:

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secrets.yaml
kubectl get configmap,secret -n humor-game
```

Learner applied base Kubernetes configuration:

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secrets.yaml
```

Observed:

```text
namespace/humor-game created
configmap/humor-game-config created
secret/humor-game-secrets created
```

Learner verified:

```bash
kubectl get configmap,secret -n humor-game
```

Observed:

```text
NAME                          DATA   AGE
configmap/humor-game-config   9      5m16s
configmap/kube-root-ca.crt    1      5m16s

NAME                        TYPE     DATA   AGE
secret/humor-game-secrets   Opaque   3      5m15s
```

Meaning:

- `humor-game` namespace exists.
- App ConfigMap exists with 9 config keys.
- App Secret exists with the 3 required secret keys.
- `kube-root-ca.crt` is automatically created by Kubernetes and is normal.

Result:

- Base Kubernetes configuration is complete.

Next step:

```bash
kubectl apply -f k8s/postgres.yaml
kubectl apply -f k8s/redis.yaml
kubectl get pods,pvc,svc -n humor-game
```

### Step 12: Deploy PostgreSQL And Redis

Learner ran:

```bash
kubectl apply -f k8s/postgres.yaml
kubectl apply -f k8s/redis.yaml
kubectl get pods,pvc,svc -n humor-game
```

Observed:

```text
configmap/postgres-init unchanged
deployment.apps/postgres configured
service/postgres unchanged
persistentvolumeclaim/postgres-pvc unchanged
deployment.apps/redis unchanged
service/redis unchanged
persistentvolumeclaim/redis-pvc unchanged
```

Meaning:

- These resources already existed from a previous apply.
- `configured` means Kubernetes accepted an update to the PostgreSQL deployment.
- `unchanged` means the live resource already matched the YAML.

Observed pods:

```text
NAME                           READY   STATUS              RESTARTS   AGE
pod/postgres-d7d464d9c-mdklt   0/1     ContainerCreating   0          2m14s
pod/redis-656b5995cb-4bjm6     1/1     Running             0          2m12s
```

Observed PVCs:

```text
persistentvolumeclaim/postgres-pvc   Bound   1Gi   RWO   local-path
persistentvolumeclaim/redis-pvc      Bound   1Gi   RWO   local-path
```

Observed services:

```text
service/postgres   ClusterIP   10.43.39.150    5432/TCP
service/redis      ClusterIP   10.43.172.217   6379/TCP
```

Meaning:

- Redis is running.
- PostgreSQL is still creating its container.
- Both persistent volumes are bound successfully.
- Internal services for PostgreSQL and Redis exist.

Result:

- Redis is ready.
- PostgreSQL storage and service are ready.
- PostgreSQL pod needs to finish container creation before deploying the backend.

Next step:

```bash
kubectl wait --for=condition=ready pod -l app=postgres -n humor-game --timeout=180s
kubectl wait --for=condition=ready pod -l app=redis -n humor-game --timeout=180s
kubectl get pods -n humor-game
```

Learner ran:

```bash
kubectl wait --for=condition=ready pod -l app=postgres -n humor-game --timeout=180s
kubectl wait --for=condition=ready pod -l app=redis -n humor-game --timeout=180s
kubectl get pods -n humor-game
```

Observed:

```text
pod/postgres-d7d464d9c-mdklt condition met
pod/redis-656b5995cb-4bjm6 condition met
NAME                       READY   STATUS    RESTARTS   AGE
postgres-d7d464d9c-mdklt   1/1     Running   0          6m10s
redis-656b5995cb-4bjm6     1/1     Running   0          6m8s
```

Meaning:

- PostgreSQL is ready.
- Redis is ready.
- Both database-layer pods are healthy with zero restarts.

Result:

- Database layer is complete.

Next step:

```bash
kubectl apply -f k8s/backend.yaml
kubectl apply -f k8s/frontend.yaml
kubectl wait --for=condition=ready pod -l app=backend -n humor-game --timeout=180s
kubectl wait --for=condition=ready pod -l app=frontend -n humor-game --timeout=180s
kubectl get pods,svc -n humor-game
```

### Step 13: Deploy Backend And Frontend

Learner ran:

```bash
kubectl apply -f k8s/backend.yaml
kubectl apply -f k8s/frontend.yaml
kubectl wait --for=condition=ready pod -l app=backend -n humor-game --timeout=180s
kubectl wait --for=condition=ready pod -l app=frontend -n humor-game --timeout=180s
kubectl get pods,svc -n humor-game
```

Observed:

```text
deployment.apps/backend unchanged
service/backend unchanged
deployment.apps/frontend unchanged
service/frontend unchanged
pod/backend-67f9f67fd4-pvkbv condition met
pod/frontend-78d4b6b885-chd95 condition met
```

Observed pods:

```text
pod/backend-67f9f67fd4-pvkbv    1/1   Running   0
pod/frontend-78d4b6b885-chd95   1/1   Running   0
pod/postgres-d7d464d9c-mdklt    1/1   Running   0
pod/redis-656b5995cb-4bjm6      1/1   Running   0
```

Observed services:

```text
service/backend    ClusterIP   10.43.40.212    3001/TCP
service/frontend   ClusterIP   10.43.159.162   80/TCP
service/postgres   ClusterIP   10.43.39.150    5432/TCP
service/redis      ClusterIP   10.43.172.217   6379/TCP
```

Meaning:

- Backend deployment is ready.
- Frontend deployment is ready.
- PostgreSQL and Redis remain healthy.
- All four application services exist.

Result:

- Core Kubernetes application deployment is complete.

Next step:

```bash
kubectl port-forward svc/backend 3001:3001 -n humor-game
curl http://localhost:3001/health
```

### Step 14: First Kubernetes Backend Port-Forward Attempt

Learner ran:

```bash
kubectl port-forward svc/backend 3001:3001 -n humor-game
```

Observed:

```text
Forwarding from 127.0.0.1:3001 -> 3001
Forwarding from [::1]:3001 -> 3001
error: lost connection to pod
```

Meaning:

- `kubectl` successfully opened the local port-forward at first.
- The forwarding session then lost its connection to the selected backend pod.

Common causes:

- The selected pod restarted.
- The API server briefly lost connectivity to the pod.
- The service endpoint changed while port-forwarding was attaching.

Immediate next diagnostics:

```bash
kubectl get pods -n humor-game
kubectl get endpoints backend -n humor-game
kubectl logs deployment/backend -n humor-game --tail=50
```

Learner ran:

```bash
kubectl get pods -n humor-game
kubectl get endpoints backend -n humor-game
kubectl logs deployment/backend -n humor-game --tail=50
```

Observed:

```text
NAME                        READY   STATUS             RESTARTS       AGE
backend-67f9f67fd4-pqkhj    0/1     CrashLoopBackOff   2 (115s ago)   19h
frontend-78d4b6b885-l8kfv   1/1     Running            4 (3m6s ago)   19h
postgres-d7d464d9c-6zpnw    1/1     Running            0              3m54s
redis-656b5995cb-9rq8q      1/1     Running            0              19h
```

Observed backend endpoints:

```text
NAME      ENDPOINTS   AGE
backend               24h
```

Observed backend logs:

```text
> humor-memory-game-backend@1.0.0 start
> node server.js

npm error path /app
npm error command failed
npm error signal SIGTERM
npm error command sh -c node server.js
```

Meaning:

- Backend pod is not healthy and is restarting repeatedly.
- The backend service currently has no ready endpoints.
- This explains why the port-forward connected briefly and then failed.
- The current log snippet shows the process was terminated, but does not yet show the original root cause.

What we know so far:

- PostgreSQL is healthy.
- Redis is healthy.
- Frontend is still running.
- Backend requires deeper inspection using pod description and previous container logs.

Next diagnostics:

```bash
kubectl describe pod backend-67f9f67fd4-pqkhj -n humor-game
kubectl logs backend-67f9f67fd4-pqkhj -n humor-game --previous
```

### Step 15: Restart Deployments To Pick Up Newly Imported Images

Reason for trying this:

- The app images were rebuilt and re-imported into k3d.
- The Deployments still showed long-lived Pods.
- With a reused `:latest` tag in a local cluster, Kubernetes does not automatically replace existing Pods after `k3d image import`.
- A rollout restart is required so the Deployment creates Pods from the newly imported image.

Learner ran:

```bash
kubectl rollout restart deployment/backend -n humor-game
kubectl rollout restart deployment/frontend -n humor-game
kubectl rollout status deployment/backend -n humor-game
kubectl rollout status deployment/frontend -n humor-game
kubectl get pods -n humor-game
```

Observed:

```text
deployment.apps/backend restarted
deployment.apps/frontend restarted
deployment "backend" successfully rolled out
deployment "frontend" successfully rolled out
```

Observed pods after rollout:

```text
backend-767756b79b-rzll5    1/1   Running       0    43s
frontend-65fcc8cc65-jgpkl   1/1   Running       0    42s
postgres-d7d464d9c-6zpnw    1/1   Running       0    2d
redis-656b5995cb-9rq8q      1/1   Running       0    2d20h
backend-6796b995b-r5prs     1/1   Terminating   2    2d
frontend-6f647bff5-v45tj    1/1   Terminating   0    2d
```

Meaning:

- New backend and frontend Pods were created successfully.
- The new backend pod is healthy and has zero restarts.
- The old Pods are terminating as part of the rollout, which is normal.
- This strongly suggests the prior backend CrashLoop came from stale Pods using an older image, not from the current image build.

Result:

- Rollout restart fixed the stale-image deployment problem.

Lesson learned:

- In this local workflow, after rebuilding and importing images into k3d, also run:

```bash
kubectl rollout restart deployment/backend -n humor-game
kubectl rollout restart deployment/frontend -n humor-game
```

Next step:

```bash
kubectl get pods -n humor-game
kubectl port-forward svc/backend 3001:3001 -n humor-game
curl http://localhost:3001/health
```

### Step 16: Second Backend Port-Forward Attempt After Rollout

Learner ran:

```bash
kubectl port-forward svc/backend 3001:3001 -n humor-game
```

Observed:

```text
Forwarding from 127.0.0.1:3001 -> 3001
Forwarding from [::1]:3001 -> 3001
Handling connection for 3001
Handling connection for 3001
Handling connection for 3001
error: lost connection to pod
```

Meaning:

- The port-forward started successfully.
- Real traffic reached the backend service at least three times.
- The forwarding session later lost connectivity to the selected pod again.

What this suggests:

- This is no longer a simple stale-image problem.
- The backend was alive long enough to accept traffic.
- We now need to inspect the current pod state immediately after the disconnect and confirm whether the pod restarted, whether the service lost endpoints, and whether the health request itself succeeded before the disconnect.

Next diagnostics:

```bash
kubectl get pods -n humor-game
kubectl get endpoints backend -n humor-game
kubectl logs deployment/backend -n humor-game --tail=100
curl http://localhost:3001/health
```

## Phase 5: Ingress Access

### Step 17: Investigate `Empty reply from server` On `localhost:8080`

Symptom observed earlier:

```bash
curl -H "Host: gameapp.local" -I http://localhost:8080/
```

Observed:

```text
curl: (52) Empty reply from server
```

Why this needed investigation:

- k3d already mapped local port `8080` to the cluster load balancer.
- The project ingress should make the app reachable at `http://gameapp.local:8080`.
- An empty reply suggested the final hop through the ingress controller was not healthy yet.

Diagnostics run:

```bash
kubectl get pods -n ingress-nginx
kubectl get ingress -A
kubectl get svc -n humor-game
kubectl get nodes -o wide
kubectl describe ingress humor-game-ingress -n humor-game
```

Observed:

- Ingress controller pod was running:

```text
ingress-nginx-controller-f74f77d4c-lckfk   1/1   Running
```

- Ingress existed with class `nginx` and host `gameapp.local`
- Ingress rules pointed correctly to:
  - `backend:3001`
  - `frontend:80`
- Backend and frontend service endpoints were present in the ingress description

Meaning:

- Ingress configuration was correct.
- The controller existed and was reading the rules.
- The problem was not a missing ingress object.

Most likely cause:

- Earlier app instability during backend rollout and pod churn caused a transient empty reply while the ingress path was syncing or while upstream availability was shifting.

### Step 18: Confirm Ingress Works End-To-End

Diagnostic run:

```bash
curl -sv -H 'Host: gameapp.local' http://localhost:8080/
```

Observed:

```text
HTTP/1.1 200 OK
Content-Type: text/html
```

Observed response body:

- Full frontend HTML for the Humor Memory Game was returned.

Meaning:

- k3d load balancer on local port `8080` is working.
- ingress-nginx is working.
- Host-based routing for `gameapp.local` is working.
- The frontend service is reachable through ingress.

Result:

- Ingress issue resolved.

Browser access path:

```text
http://gameapp.local:8080
```

Lesson learned:

- During rollouts or backend instability, ingress symptoms can be transient.
- When debugging ingress, test in layers:
  1. ingress controller pod health
  2. ingress object and backend rules
  3. services and endpoints
  4. final host-header curl through `localhost:8080`

## Cluster Recovery: kubectl API EOF / Connection Refused

### Symptom

Learner saw:

```bash
kubectl get nodes
```

Errors:

```text
couldn't get current server API group list
Get "https://0.0.0.0:54257/api?timeout=32s": EOF
```

Later, after changing the kubeconfig server to loopback:

```text
Get "https://127.0.0.1:54257/api?timeout=32s": connect: connection refused
```

### What We Checked

- `k3d cluster list` showed the cluster still existed.
- `colima status` showed Colima was running.
- `docker info` showed Docker was healthy.
- `kubectl config view --minify` showed the current context still pointed at `k3d-humor-game-cluster`.

### Important Discovery

The kubeconfig server was:

```text
https://0.0.0.0:54257
```

This is a fragile client target, so it was updated to:

```bash
kubectl config set-cluster k3d-humor-game-cluster --server=https://127.0.0.1:54257
```

That was a worthwhile cleanup, but it did not fix the outage by itself.

### Root Cause

The real failure was that the k3d load balancer container had exited:

```text
k3d-humor-game-cluster-serverlb   Exited (137)
```

Because the `serverlb` container owns the host port mapping for the Kubernetes API, once it exited:

- nothing listened on local port `54257`
- `kubectl` could not reach the control plane

### Recovery Steps

Attempted:

```bash
k3d cluster stop humor-game-cluster
k3d cluster start humor-game-cluster
```

During restart, cluster nodes came back, but the `serverlb` container still was not running.

Direct fix:

```bash
docker start k3d-humor-game-cluster-serverlb
```

Verification:

```bash
lsof -iTCP:54257 -sTCP:LISTEN
kubectl get nodes
kubectl cluster-info
```

Observed:

```text
TCP *:54257 (LISTEN)
```

```text
NAME                              STATUS   ROLES
k3d-humor-game-cluster-agent-0    Ready
k3d-humor-game-cluster-agent-1    Ready
k3d-humor-game-cluster-server-0   Ready
```

```text
Kubernetes control plane is running at https://127.0.0.1:54257
```

### Result

- `kubectl` access restored.
- Cluster control plane reachable again.

### Practical Lesson

When `kubectl` suddenly starts returning `EOF` or `connection refused` against a k3d cluster:

1. Check the current context.
2. Check whether the host API port is listening.
3. Check whether `k3d-humor-game-cluster-serverlb` is running.
4. If needed:

```bash
docker start k3d-humor-game-cluster-serverlb
```

5. Prefer `127.0.0.1` over `0.0.0.0` in kubeconfig client endpoints.
