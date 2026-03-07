# Application Networking Flow - Beginner's Guide

## 🎯 Overview

This document explains how your Humor Memory Game application works from a networking perspective, from the user's browser all the way down to the database. Think of it like explaining how a letter travels from your mailbox to its destination!

---

## 📦 What Are The Pieces?

Your application has **4 main components**:

1. **Frontend** - The web page users see (HTML, CSS, JavaScript)
2. **Backend** - The API server that handles game logic (Node.js)
3. **PostgreSQL** - The database that stores game data (scores, users, etc.)
4. **Redis** - A fast cache for frequently accessed data (leaderboards)

---

## 🏠 Part 1: Local Development (Docker Compose)

When you run `docker-compose up`, here's what happens:

### The Docker Network Setup

```
┌─────────────────────────────────────────────────────────┐
│              Docker Host (Your Computer)                │
│                                                          │
│  ┌──────────────────┐         ┌──────────────────┐     │
│  │  frontend-network│         │  backend-network  │     │
│  │  (Bridge Network)│         │  (Bridge Network) │     │
│  └──────────────────┘         └──────────────────┘     │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │  Frontend    │  │   Backend    │  │   Postgres   │ │
│  │  Container   │  │   Container  │  │   Container  │ │
│  │              │  │              │  │              │ │
│  │  Port: 80    │  │  Port: 3001  │  │  Port: 5432  │ │
│  │              │  │              │  │              │ │
│  │  Network:    │  │  Network:    │  │  Network:    │ │
│  │  frontend +  │  │  frontend +  │  │  backend     │ │
│  │  backend     │  │  backend     │  │              │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
│                                                          │
│  ┌──────────────┐                                       │
│  │    Redis     │                                       │
│  │   Container  │                                       │
│  │              │                                       │
│  │  Port: 6379  │                                       │
│  │              │                                       │
│  │  Network:    │                                       │
│  │  backend     │                                       │
│  └──────────────┘                                       │
└─────────────────────────────────────────────────────────┘
```

### How Services Communicate in Docker

#### 1. **User Opens Browser → Frontend**

```
User types: http://localhost:3000
    ↓
Browser connects to: localhost:3000
    ↓
Docker maps: localhost:3000 → frontend container:80
    ↓
Frontend container serves: index.html (the game page)
```

**Key Point**: Docker uses **port mapping** to expose container ports to your computer. The `ports: "3000:80"` in docker-compose.yml means "map my computer's port 3000 to the container's port 80".

#### 2. **Frontend Needs Data → Backend API**

When the game page loads, JavaScript makes API calls:

```javascript
// Frontend code (game.js)
fetch('/api/game/start', { method: 'POST' })
```

**What happens:**

```
Frontend Container (port 80)
    ↓
nginx.conf sees: location /api/
    ↓
nginx proxies to: http://backend:3001
    ↓
Docker DNS resolves: "backend" → backend container IP
    ↓
Request reaches: Backend container on port 3001
```

**Key Concepts:**
- **Service Names**: In Docker Compose, containers can talk to each other using their **service names** (like `backend`, `postgres`, `redis`) instead of IP addresses. Docker provides a built-in DNS server!
- **Networks**: Containers must be on the same network to communicate. The frontend is on both `frontend-network` and `backend-network`, so it can talk to the backend.

#### 3. **Backend Needs Data → Database**

When the backend receives a request, it might need to save or retrieve game data:

```javascript
// Backend code (server.js)
await database.query('SELECT * FROM users WHERE username = $1', [username])
```

**What happens:**

```
Backend Container
    ↓
Connects to: postgres:5432
    ↓
Docker DNS resolves: "postgres" → postgres container IP
    ↓
PostgreSQL receives query on port 5432
    ↓
Returns data to backend
```

**Environment Variables:**
- The backend knows where the database is because of `DB_HOST=postgres` in docker-compose.yml
- Docker automatically sets up DNS so "postgres" resolves to the postgres container

#### 4. **Backend Needs Cache → Redis**

For fast leaderboard lookups:

```javascript
// Backend code
await redisClient.get('leaderboard:top10')
```

**What happens:**

```
Backend Container
    ↓
Connects to: redis:6379
    ↓
Docker DNS resolves: "redis" → redis container IP
    ↓
Redis returns cached data (or backend queries DB if cache miss)
```

---

## ☸️ Part 2: Kubernetes Deployment

When you deploy to Kubernetes, the networking is more sophisticated but follows similar principles.

### The Kubernetes Network Setup

```
┌─────────────────────────────────────────────────────────────────┐
│                    Kubernetes Cluster                            │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              Ingress Controller (NGINX)                  │  │
│  │  - Routes external traffic to internal services          │  │
│  │  - Handles SSL/TLS termination                           │  │
│  │  - Port: 80 (HTTP), 443 (HTTPS)                          │  │
│  └──────────────────────────────────────────────────────────┘  │
│                            ↓                                     │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                    Namespace: humor-game                  │  │
│  │                                                           │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │  │
│  │  │  Frontend    │  │   Backend    │  │   Postgres   │ │  │
│  │  │  Pod         │  │   Pod        │  │   Pod        │ │  │
│  │  │              │  │              │  │              │ │  │
│  │  │  Port: 80    │  │  Port: 3001  │  │  Port: 5432  │ │  │
│  │  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘ │  │
│  │         │                 │                 │          │  │
│  │  ┌──────▼───────┐  ┌──────▼───────┐  ┌──────▼───────┐ │  │
│  │  │  Frontend    │  │   Backend    │  │   Postgres   │ │  │
│  │  │  Service     │  │   Service   │  │   Service    │ │  │
│  │  │              │  │              │  │              │ │  │
│  │  │  Port: 80    │  │  Port: 3001  │  │  Port: 5432  │ │  │
│  │  │              │  │              │  │              │ │  │
│  │  │  DNS:        │  │  DNS:        │  │  DNS:        │ │  │
│  │  │  frontend.   │  │  backend.    │  │  postgres.   │ │  │
│  │  │  humor-game  │  │  humor-game  │  │  humor-game  │ │  │
│  │  │  .svc        │  │  .svc        │  │  .svc        │ │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘ │  │
│  │                                                           │  │
│  │  ┌──────────────┐                                       │  │
│  │  │    Redis     │                                       │  │
│  │  │   Pod        │                                       │  │
│  │  │              │                                       │  │
│  │  │  Port: 6379  │                                       │  │
│  │  └──────┬───────┘                                       │  │
│  │         │                                               │  │
│  │  ┌──────▼───────┐                                       │  │
│  │  │    Redis     │                                       │  │
│  │  │   Service    │                                       │  │
│  │  │              │                                       │  │
│  │  │  Port: 6379  │                                       │  │
│  │  │              │                                       │  │
│  │  │  DNS:        │                                       │  │
│  │  │  redis.      │                                       │  │
│  │  │  humor-game  │                                       │  │
│  │  │  .svc        │                                       │  │
│  │  └──────────────┘                                       │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### Key Kubernetes Networking Concepts

#### 1. **Pods**
- A Pod is like a container, but Kubernetes can run multiple containers in one Pod
- Each Pod gets its own IP address
- Pods can be created/destroyed (they're "ephemeral")

#### 2. **Services**
- A Service is a stable network endpoint that points to Pods
- Services have a **DNS name** like `backend.humor-game.svc.cluster.local`
- Services use **labels** to find which Pods to route to
- Services provide **load balancing** if multiple Pods exist

#### 3. **Ingress**
- Ingress is like a reverse proxy/router at the cluster edge
- It receives traffic from outside the cluster
- It routes traffic to Services based on URL paths and hostnames

---

### How Services Communicate in Kubernetes

#### 1. **User Opens Browser → Ingress → Frontend**

```
User types: https://gameapp.games
    ↓
DNS resolves: gameapp.games → Ingress Controller IP
    ↓
Ingress Controller (NGINX) receives request
    ↓
Ingress rules check: host = gameapp.games, path = /
    ↓
Routes to: frontend Service (port 80)
    ↓
Service routes to: Frontend Pod
    ↓
Frontend Pod serves: index.html
```

**From ingress.yaml:**
```yaml
- host: gameapp.games
  http:
    paths:
      - path: /
        backend:
          service:
            name: frontend
            port:
              number: 80
```

#### 2. **Frontend Needs Data → Ingress → Backend**

When the game makes an API call:

```javascript
fetch('/api/game/start', { method: 'POST' })
```

**What happens:**

```
Frontend Pod
    ↓
Browser makes request to: /api/game/start
    ↓
Request goes to: Ingress Controller (same domain)
    ↓
Ingress rules check: host = gameapp.games, path = /api
    ↓
Routes to: backend Service (port 3001)
    ↓
Service routes to: Backend Pod
    ↓
Backend processes request
```

**From ingress.yaml:**
```yaml
- path: /api
  pathType: Prefix
  backend:
    service:
      name: backend
      port:
        number: 3001
```

**Key Point**: The frontend doesn't need to know the backend's IP address. It just uses relative URLs (`/api`), and the Ingress Controller routes them correctly!

#### 3. **Backend Needs Data → Database**

```javascript
await database.query('SELECT * FROM users')
```

**What happens:**

```
Backend Pod
    ↓
Connects to: postgres.humor-game.svc.cluster.local:5432
    ↓
Kubernetes DNS resolves: postgres → Postgres Service IP
    ↓
Service routes to: Postgres Pod
    ↓
PostgreSQL executes query
    ↓
Returns data to backend
```

**From backend.yaml:**
```yaml
env:
  - name: DB_HOST
    value: "postgres"  # Short name works within namespace!
```

**Key Concepts:**
- **Service DNS**: `postgres.humor-game.svc.cluster.local` is the full DNS name
- **Short Names**: Within the same namespace, you can use just `postgres`
- **Namespace**: `humor-game` is the namespace (like a folder for resources)

#### 4. **Backend Needs Cache → Redis**

```javascript
await redisClient.get('leaderboard:top10')
```

**What happens:**

```
Backend Pod
    ↓
Connects to: redis.humor-game.svc.cluster.local:6379
    ↓
Kubernetes DNS resolves: redis → Redis Service IP
    ↓
Service routes to: Redis Pod
    ↓
Redis returns cached data
```

---

## 🔄 Complete Request Flow Example

Let's trace a complete request: **User starts a new game**

### Step-by-Step Flow:

```
1. USER ACTION
   User clicks "Start Game" button
   ↓

2. FRONTEND (Browser)
   JavaScript calls: fetch('/api/game/start', { method: 'POST' })
   ↓

3. INGRESS CONTROLLER (Kubernetes) or NGINX (Docker)
   Receives: POST /api/game/start
   Routes to: backend service
   ↓

4. BACKEND POD/CONTAINER
   Express.js receives request at: POST /api/game/start
   ↓

5. BACKEND LOGIC
   - Validates request
   - Generates game ID
   - Needs to save to database
   ↓

6. BACKEND → POSTGRES
   Connects to: postgres:5432
   Executes: INSERT INTO games (...)
   ↓

7. POSTGRES
   Saves game data
   Returns: game ID and data
   ↓

8. BACKEND → REDIS (Optional)
   Caches leaderboard data for faster future access
   ↓

9. BACKEND RESPONSE
   Returns JSON: { gameId: "...", cards: [...], ... }
   ↓

10. INGRESS/Nginx
    Forwards response back to frontend
    ↓

11. FRONTEND (Browser)
    Receives response
    Updates UI with game cards
    User sees the game!
```

---

## 🔑 Key Networking Differences: Docker vs Kubernetes

| Feature | Docker Compose | Kubernetes |
|---------|---------------|------------|
| **Service Discovery** | Service names in docker-compose.yml | Service DNS names (`service.namespace.svc`) |
| **Networking** | Bridge networks (isolated) | Cluster-wide network (all pods can talk) |
| **Load Balancing** | None (single container) | Built into Services (multiple pods) |
| **External Access** | Port mapping (`3000:80`) | Ingress Controller + Services |
| **DNS** | Docker's built-in DNS | Kubernetes DNS (CoreDNS) |
| **Scaling** | Manual (change replicas in compose) | Automatic (HPA, replicas in Deployment) |

---

## 🛡️ Security & Isolation

### Docker Compose:
- Containers on the same network can talk to each other
- Ports are only exposed if you map them (`ports:` section)
- Database port (5432) is NOT exposed in production (commented out)

### Kubernetes:
- **Network Policies** can restrict which pods can talk to each other
- **Services** only expose ports you define
- **Ingress** is the only way external traffic enters (no direct pod access)
- **Secrets** store passwords (not in environment variables)

---

## 📊 Monitoring & Observability

### How Monitoring Works:

```
Backend Pod
    ↓
Exposes: /metrics endpoint (Prometheus format)
    ↓
Prometheus Pod
    ↓
Scrapes: backend.humor-game.svc:3001/metrics
    ↓
Stores metrics in time-series database
    ↓
Grafana Pod
    ↓
Queries Prometheus
    ↓
Displays dashboards
```

**From backend.yaml:**
```yaml
annotations:
  prometheus.io/scrape: "true"
  prometheus.io/port: "3001"
  prometheus.io/path: "/metrics"
```

---

## 🎓 Summary: The Big Picture

1. **User** → Types URL in browser
2. **Ingress/NGINX** → Routes request based on URL path
3. **Frontend** → Serves HTML/CSS/JavaScript
4. **Frontend JavaScript** → Makes API calls to `/api/*`
5. **Ingress/NGINX** → Routes `/api/*` to backend
6. **Backend** → Processes request, may need data
7. **Backend** → Queries **PostgreSQL** (persistent data)
8. **Backend** → Queries **Redis** (fast cache)
9. **Backend** → Returns JSON response
10. **Frontend** → Updates UI with response

**The magic**: Services find each other using **DNS names** (not IP addresses), which makes everything flexible and scalable!

---

## 🔧 Troubleshooting Tips

### "Can't connect to backend"
- **Docker**: Check if containers are on the same network
- **Kubernetes**: Check if Service exists and Pods have correct labels

### "Database connection failed"
- **Docker**: Check `DB_HOST=postgres` matches service name
- **Kubernetes**: Check Service name matches `DB_HOST` environment variable

### "API calls return 404"
- **Docker**: Check nginx.conf has `/api/` location block
- **Kubernetes**: Check Ingress rules have `/api` path configured

### "Can't access from browser"
- **Docker**: Check port mapping (`ports: "3000:80"`)
- **Kubernetes**: Check Ingress Controller is running and Ingress rules are correct

---

## 📚 Further Reading

- Docker Networking: https://docs.docker.com/network/
- Kubernetes Services: https://kubernetes.io/docs/concepts/services-networking/service/
- Kubernetes Ingress: https://kubernetes.io/docs/concepts/services-networking/ingress/
- DNS in Kubernetes: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/

---

*This document explains the networking flow for the Humor Memory Game application. For deployment instructions, see the main README.md*


