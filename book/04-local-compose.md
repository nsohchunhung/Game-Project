# Chapter 4: Local Multi-Container Development

*Build and test your application stack locally with Docker Compose*

---

## What You'll Learn
- Multi-service application deployment with Docker Compose
- Container networking and service communication
- Database and cache integration patterns
- Application health verification and debugging techniques

## Time Required: 40 minutes

## Prerequisites: [Chapter 3: Environment Setup](03-env-setup.md)

---

## Why This Matters

Docker Compose is your safety net before Kubernetes deployment. It allows you to test your complete application stack locally, identifying configuration issues, service dependencies, and networking problems before they become expensive production problems.

**Professional Context**: Senior engineers always validate applications locally before deploying to shared environments. This practice prevents disrupting team productivity and demonstrates operational maturity.

**💡 Pro Tip**: If your application doesn't work in Docker Compose, it won't work in Kubernetes. This chapter catches 80% of deployment issues before they reach production.

## Understanding the Application Stack

Before starting, understand what you're deploying:

# 🐳 Docker Compose Application Stack
# Multi-service architecture with frontend, backend, database, and cache

```
┌─────────────────────────────────────────────────────────────┐
│                     Docker Compose Stack                    │
├─────────────────────────────────────────────────────────────┤
│  Frontend (nginx:80) ←→ Backend (Node.js:3001)             │
│                           ↓                                 │
│  PostgreSQL (5432) ←→ Redis Cache (6379)                   │
└─────────────────────────────────────────────────────────────┘
```

**Service Dependencies:**
1. **PostgreSQL**: Must start first (persistent data)
2. **Redis**: Starts in parallel with PostgreSQL (cache layer)
3. **Backend**: Waits for database health checks
4. **Frontend**: Starts after backend is ready

## Build and Deploy Application Stack

### Step 1: Examine the Configuration

First, understand your Docker Compose configuration:

# 📋 Docker Compose Configuration Review
# Examine the multi-service application configuration

```bash
# Navigate to project directory
cd DevOps-Home-Lab-2025

# Examine the compose file structure
cat docker-compose.yml | head -20
```

**Expected Output:**

# 📄 Docker Compose Services Configuration
# PostgreSQL service definition with environment variables and volumes

```yaml
services:
  postgres:
    image: postgres:15-alpine
    container_name: humor-game-postgres
    restart: unless-stopped
    environment:
      POSTGRES_DB: ${DB_NAME:-humor_memory_game}
      POSTGRES_USER: ${DB_USER:-gameuser}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-gamepass123}
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./database/combined-init.sql:/docker-entrypoint-initdb.d/01-combined-init.sql
```

**📚 Editor Note**: The compose file uses environment variable defaults (e.g., `${DB_PASSWORD:-gamepass123}`) which is a production-ready pattern for configuration management.

### Step 2: Build Application Images

# 🏗️ Container Image Build
# Build all application images from source code

```bash
# Build all container images from source
docker-compose build --no-cache
```

**Expected Output:**

# 🏗️ Docker Build Process Output
# Successful build of backend and frontend container images

```bash
Building backend
[+] Building 45.2s (12/12) FINISHED
 => [internal] load build definition from Dockerfile                    0.1s
 => => transferring dockerfile: 543B                                    0.0s
 => [internal] load .dockerignore                                       0.1s
 => [1/7] FROM docker.io/library/node:18-alpine@sha256:abc123           2.1s
 => [2/7] WORKDIR /app                                                  0.1s
 => [3/7] COPY package*.json ./                                         0.1s
 => [4/7] RUN npm ci --only=production                                 30.2s
 => [5/7] COPY . .                                                      0.3s
 => [6/7] EXPOSE 3001                                                   0.1s
 => [7/7] CMD ["npm", "start"]                                          0.1s
 => => naming to docker.io/library/devops-home-lab-2025-backend        0.0s

Building frontend
[+] Building 23.1s (8/8) FINISHED
 => [internal] load build definition from Dockerfile                    0.1s
 => [1/4] FROM docker.io/library/nginx:alpine@sha256:def456             1.2s
 => [2/4] COPY dist/ /usr/share/nginx/html                              0.2s
 => [3/4] COPY nginx.conf /etc/nginx/nginx.conf                         0.1s
 => [4/4] EXPOSE 80                                                     0.1s
 => => naming to docker.io/library/devops-home-lab-2025-frontend       0.0s
```

[[ADD IMAGE: Docker build output showing successful image creation]]

### Step 3: Start the Complete Stack

# 🚀 Start Docker Compose Stack
# Launch all services in detached mode

```bash
# Start all services in detached mode
docker-compose up -d
```

**Expected Output:**

# 🎯 Docker Compose Startup Output
# Successful creation of networks, volumes, and containers

```bash
Creating network "devops-home-lab-2025_backend-network" ... done
Creating network "devops-home-lab-2025_frontend-network" ... done
Creating volume "devops-home-lab-2025_postgres_data" ... done
Creating volume "devops-home-lab-2025_redis_data" ... done
Creating devops-home-lab-2025_postgres_1 ... done
Creating devops-home-lab-2025_redis_1 ... done
Creating devops-home-lab-2025_backend_1 ... done
Creating devops-home-lab-2025_frontend_1 ... done
```

# ⏳ Service Initialization Wait
# Allow time for database and services to start properly

```bash
# Wait for database initialization (important!)
echo "Waiting for services to initialize..."
sleep 30

# Check service status
docker-compose ps
```

**Expected Output:**

# 📊 Docker Compose Service Status
# All services running with proper health checks

```bash
NAME                            IMAGE                              STATUS                    PORTS
devops-home-lab-2025_postgres_1 postgres:15-alpine                Up 2 minutes             5432/tcp
devops-home-lab-2025_redis_1    redis:7-alpine                    Up 2 minutes             6379/tcp
devops-home-lab-2025_backend_1  devops-home-lab-2025-backend      Up 1 minute              0.0.0.0:3001->3001/tcp
devops-home-lab-2025_frontend_1 devops-home-lab-2025-frontend     Up 1 minute (healthy)    0.0.0.0:3000->80/tcp
```

**⚠️ Important**: The `(healthy)` status for frontend indicates Docker health checks are passing. This is a production-ready pattern you'll implement in Kubernetes.

## Verify Application Functionality

### Step 1: Test Backend API Health

# 🏥 Backend Health Check Test
# Verify backend API health endpoint is responding

```bash
# Test backend health endpoint
curl -s http://localhost:3001/api/health | jq .
```

**Expected Output:**

# ✅ Backend Health Response
# JSON response confirming all services are healthy

```json
{
  "status": "healthy",
  "services": {
    "database": "connected",
    "redis": "connected"
  },
  "timestamp": "2025-01-15T10:30:00.000Z",
  "uptime": "00:02:15",
  "version": "1.0.0"
}
```

**💡 Pro Tip**: The health endpoint checks database and Redis connectivity. This same pattern will be used for Kubernetes readiness probes.

### Step 2: Test Database Connectivity

# 🗄️ Database Connection Test
# Verify PostgreSQL database is accessible and responding

```bash
# Test direct database connection
docker-compose exec postgres psql -U gameuser -d humor_memory_game -c "SELECT version();"
```

**Expected Output:**

# 📊 PostgreSQL Version Check
# Confirmation of database version and connectivity

```bash
                                                             version
----------------------------------------------------------------------------------------------------------------
 PostgreSQL 15.4 on x86_64-pc-linux-gnu, compiled by gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924, 64-bit
(1 row)
```

# 📋 Database Schema Verification
# Check that all required tables exist in the database

```bash
# Verify database schema
docker-compose exec postgres psql -U gameuser -d humor_memory_game -c "\dt"
```

**Expected Output:**

# 📊 Database Tables List
# Confirmation of all application tables in PostgreSQL

```bash
               List of relations
 Schema |     Name      | Type  |  Owner
--------+---------------+-------+----------
 public | game_sessions | table | gameuser
 public | leaderboard   | table | gameuser
 public | users         | table | gameuser
(3 rows)
```

### Step 3: Test Redis Cache

# 🔴 Redis Cache Test
# Verify Redis connectivity and authentication

```bash
# Test Redis connectivity and authentication
docker-compose exec redis redis-cli -a gamepass123 ping
```

**Expected Output:**

# ✅ Redis Ping Response
# Confirmation that Redis cache is responding

```bash
PONG
```

# 🧪 Redis Cache Operations Test
# Test basic set and get operations in Redis

```bash
# Test cache operations
docker-compose exec redis redis-cli -a gamepass123 set test-key "Hello Docker Compose"
docker-compose exec redis redis-cli -a gamepass123 get test-key
```

**Expected Output:**

# ✅ Redis Cache Operations Output
# Successful set and get operations confirmation

```bash
OK
"Hello Docker Compose"
```

### Step 4: Test Frontend Application

Open your web browser and navigate to `http://localhost:3000`:

**✅ Verification Checklist:**
- ✅ Game interface loads with "Humor Memory Game" title
- ✅ Username input field accepts text
- ✅ Difficulty selection dropdown works
- ✅ "Start Game" button is clickable and responsive
- ✅ No JavaScript errors in browser console (F12 → Console)

[[ADD IMAGE: Browser screenshot showing the Humor Memory Game interface]]

# 🌐 Frontend Static Content Test
# Verify frontend is serving HTML content correctly

```bash
# Test frontend static content delivery
curl -s http://localhost:3000 | grep -o "<title>.*</title>"
```

**Expected Output:**

# 📄 Frontend HTML Title
# Confirmation that frontend is serving the correct HTML

```html
<title>Humor Memory Game</title>
```

## Test Complete User Workflow

### Step 1: Test User Registration

# 👤 User Registration API Test
# Test the complete user registration workflow

```bash
# Test user registration API
curl -X POST http://localhost:3001/api/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "testpass123"
  }' | jq .
```

**Expected Output:**

# ✅ User Registration Response
# Successful user creation with database persistence

```json
{
  "success": true,
  "message": "User registered successfully",
  "user": {
    "id": 1,
    "username": "testuser",
    "email": "test@example.com",
    "created_at": "2025-01-15T10:35:00.000Z"
  }
}
```

### Step 2: Test Game Session Creation

# 🎮 Game Session Creation Test
# Test starting a new game session with difficulty selection

```bash
# Test game session creation
curl -X POST http://localhost:3001/api/game/start \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "difficulty": "easy"
  }' | jq .
```

**Expected Output:**

# 🎯 Game Session Response
# Successful game session creation with card data

```json
{
  "success": true,
  "session_id": "sess_1234567890",
  "game_config": {
    "difficulty": "easy",
    "grid_size": "4x4",
    "time_limit": null
  },
  "cards": ["🎭", "🎪", "🃏", "🎨", "🎭", "🎪", "🃏", "🎨"]
}
```

### Step 3: Test Leaderboard

# 🏆 Leaderboard API Test
# Test the leaderboard endpoint for game statistics

```bash
# Test leaderboard endpoint
curl -s http://localhost:3001/api/leaderboard | jq .
```

**Expected Output:**

# 🏆 Leaderboard Response
# Game statistics and rankings from the database

```json
{
  "success": true,
  "leaderboard": [
    {
      "username": "testuser",
      "best_score": 0,
      "total_games": 1,
      "difficulty": "easy",
      "rank": 1
    }
  ]
}
```

## Environment Configuration Verification

### Step 1: Check Environment Variables

# 🔧 Backend Environment Verification
# Check that all environment variables are properly configured

```bash
# Verify backend environment configuration
docker-compose exec backend env | grep -E "(DB_|REDIS_|NODE_ENV|PORT)"
```

**Expected Output:**

# 📊 Backend Environment Variables
# Confirmation of all database and Redis connection settings

```bash
DB_HOST=postgres
DB_PORT=5432
DB_NAME=humor_memory_game
DB_USER=gameuser
DB_PASSWORD=gamepass123
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD=gamepass123
NODE_ENV=development
PORT=3001
```

### Step 2: Test Service Discovery

# 🌐 Container Networking Test
# Verify inter-container communication is working

```bash
# Test container-to-container networking
docker-compose exec backend ping -c 3 postgres
docker-compose exec backend ping -c 3 redis
```

**Expected Output:**
```bash
PING postgres (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.123 ms
64 bytes from 172.18.0.2: seq=1 ttl=64 time=0.089 ms
64 bytes from 172.18.0.2: seq=2 ttl=64 time=0.095 ms
```

**📚 Editor Note**: Docker Compose automatically creates a bridge network where services can communicate using their service names as hostnames. This same principle applies to Kubernetes service discovery.

## Performance and Resource Monitoring

### Step 1: Monitor Resource Usage

```bash
# Check container resource usage
docker stats --no-stream
```

**Expected Output:**
```bash
CONTAINER ID   NAME                              CPU %     MEM USAGE / LIMIT   MEM %     NET I/O       BLOCK I/O   PIDS
abc123def456   devops-home-lab-2025_frontend_1   0.01%     3.2MiB / 1.944GiB   0.16%     1.23kB / 0B   0B / 0B     3
def456ghi789   devops-home-lab-2025_backend_1    1.50%     45.1MiB / 1.944GiB  2.27%     15.2kB / 0B   0B / 0B     11
ghi789jkl012   devops-home-lab-2025_postgres_1   0.25%     25.3MiB / 1.944GiB  1.27%     8.45kB / 0B   0B / 8.2MB  7
jkl012mno345   devops-home-lab-2025_redis_1      0.15%     8.1MiB / 1.944GiB   0.41%     4.12kB / 0B   0B / 0B     4
```

### Step 2: Check Application Logs

```bash
# View backend application logs
docker-compose logs backend --tail=20
```

**Expected Output:**

# 📋 Backend Application Logs
# Successful startup sequence with all service connections

```bash
backend_1   | 2025-01-15T10:30:00.123Z [INFO] Starting Humor Memory Game Backend
backend_1   | 2025-01-15T10:30:00.234Z [INFO] Connecting to PostgreSQL at postgres:5432
backend_1   | 2025-01-15T10:30:01.345Z [INFO] Database connected successfully
backend_1   | 2025-01-15T10:30:01.456Z [INFO] Connecting to Redis at redis:6379
backend_1   | 2025-01-15T10:30:01.567Z [INFO] Redis connected successfully
backend_1   | 2025-01-15T10:30:01.678Z [INFO] Server listening on port 3001
backend_1   | 2025-01-15T10:30:01.789Z [INFO] Health check endpoint available at /api/health
```

## ✅ Checkpoint

Your Docker Compose stack is working correctly when:
- ✅ All 4 containers show "Up" status in `docker-compose ps`
- ✅ Backend health check returns `{"status": "healthy"}`
- ✅ Frontend loads at `http://localhost:3000` without errors
- ✅ Database accepts connections and shows expected schema
- ✅ Redis responds to ping and cache operations
- ✅ Container resource usage is reasonable (< 100MB per service)
- ✅ Application logs show successful service connections

## Troubleshooting Common Issues

### Issue: Services Won't Start

**Symptom:**
```bash
ERROR: for postgres  Cannot start service postgres: driver failed programming external connectivity
```

**Cause**: Port conflicts with existing services

**Diagnosis:**

# 🔍 Port Conflict Diagnosis
# Check which processes are using required ports

```bash
# Check what's using the ports
lsof -i :3000  # Frontend port
lsof -i :3001  # Backend port
lsof -i :5432  # PostgreSQL port
lsof -i :6379  # Redis port
```

**Fix:**

# 🔧 Port Conflict Resolution
# Stop conflicting services or modify port mappings

```bash
# Stop conflicting services or change ports in docker-compose.yml
# Example: Change frontend port
# ports:
#   - "3001:80"  # Changed from 3000:80
```

### Issue: Database Connection Fails

**Symptom:**
```bash
backend_1   | Error: connect ECONNREFUSED postgres:5432
```

**Cause**: Backend starting before PostgreSQL is ready

**Diagnosis:**

# 🔍 Database Connection Diagnosis
# Check PostgreSQL logs and connection status

```bash
# Check PostgreSQL logs
docker-compose logs postgres

# Check if PostgreSQL is accepting connections
docker-compose exec postgres pg_isready -U gameuser
```

**Fix:**

# 🔧 Database Connection Fix
# Wait for database initialization and restart backend

```bash
# Wait longer for database initialization
sleep 60
docker-compose restart backend

# Or add depends_on with health checks (already configured)
```

### Issue: Frontend Shows Connection Errors

**Symptom**: Browser console shows "Failed to fetch" errors

**Cause**: Backend API not accessible or CORS issues

**Diagnosis:**

# 🔍 Frontend Connection Diagnosis
# Test backend connectivity and check for CORS issues

```bash
# Test backend directly
curl http://localhost:3001/api/health

# Check backend logs for CORS errors
docker-compose logs backend | grep -i cors
```

**Fix:**

# 🔧 Frontend Connection Fix
# Restart backend and verify configuration

```bash
# Verify backend is running and accessible
docker-compose ps backend
docker-compose restart backend

# Check frontend configuration points to correct backend URL
```

### Issue: Memory or Performance Problems

**Symptom**: Containers consuming excessive resources

**Diagnosis:**

# 🔍 Performance Problem Diagnosis
# Monitor resource usage and check for memory issues

```bash
# Monitor resource usage
docker stats --no-stream

# Check for memory leaks in logs
docker-compose logs backend | grep -i "memory\|leak\|out of memory"
```

**Fix:**

# 🔧 Performance Optimization Fix
# Add resource limits to prevent excessive resource usage

```bash
# Add resource limits to docker-compose.yml
# services:
#   backend:
#     deploy:
#       resources:
#         limits:
#           memory: 512M
#           cpus: '0.5'
```

## Clean Up and Reset Procedures

### Graceful Shutdown

# 🛑 Graceful Service Shutdown
# Stop all Docker Compose services cleanly

```bash
# Stop all services gracefully
docker-compose down
```

**Expected Output:**

# 🛑 Graceful Shutdown Output
# Confirmation of clean service termination

```bash
Stopping devops-home-lab-2025_frontend_1 ... done
Stopping devops-home-lab-2025_backend_1 ... done
Stopping devops-home-lab-2025_redis_1 ... done
Stopping devops-home-lab-2025_postgres_1 ... done
Removing devops-home-lab-2025_frontend_1 ... done
Removing devops-home-lab-2025_backend_1 ... done
Removing devops-home-lab-2025_redis_1 ... done
Removing devops-home-lab-2025_postgres_1 ... done
Removing network devops-home-lab-2025_backend-network
Removing network devops-home-lab-2025_frontend-network
```

### Complete Reset (Nuclear Option)

# 🗑️ Complete Environment Reset
# Nuclear option to remove all containers, volumes, and images

```bash
# Remove everything including volumes (data loss!)
docker-compose down -v --remove-orphans

# Remove built images
docker-compose down --rmi all

# Clean up Docker system
docker system prune -f
```

**⚠️ Warning**: The `-v` flag removes persistent volumes, deleting all database data.

## What You Learned

You've successfully deployed and tested a complete multi-service application:

**Technical Skills:**
- **Multi-container orchestration** with Docker Compose
- **Service networking** and inter-container communication
- **Database integration** with connection pooling and health checks
- **Cache layer implementation** with Redis
- **Health monitoring** and application verification
- **Resource monitoring** and performance analysis

**Production Patterns:**
- **Environment variable configuration** for different deployment contexts
- **Health check implementation** for service readiness
- **Graceful shutdown procedures** for clean service termination
- **Logging best practices** for debugging and monitoring
- **Network isolation** with dedicated bridges for security

**Troubleshooting Skills:**
- **Systematic diagnosis** of container and networking issues
- **Log analysis** for identifying service problems
- **Resource monitoring** for performance optimization
- **Port conflict resolution** and service configuration

This local deployment serves as your baseline. Every configuration and pattern you've implemented here will translate directly to Kubernetes deployment with additional orchestration features.

---

**Next**: [Chapter 5: Kubernetes Basics](05-kubernetes-basics.md) - Deploy your application to a production-ready Kubernetes cluster
**Previous**: [Chapter 3: Environment Setup](03-env-setup.md) - Installing and configuring your development environment
