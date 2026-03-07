# Chapter 2: System Architecture Overview

*Understanding the complete production-grade infrastructure before you build it*

---

## What You'll Learn
- High-level system architecture and component relationships
- Data flow from user interaction to database persistence
- Technology choices and their production implications
- How the system scales from local development to global deployment

## Time Required: 20 minutes

## Prerequisites: [Chapter 1: Introduction](01-intro.md)

---

## Why This Matters

Understanding the complete architecture before diving into implementation helps you see how each piece contributes to the whole. This prevents the common mistake of learning individual tools without understanding how they work together in production systems.

**Professional Context**: Senior engineers always start with architecture diagrams. Understanding system design is what differentiates DevOps engineers from script runners.

## Complete System Architecture

[[ADD IMAGE: Complete technical architecture diagram showing all components and connections]]

### High-Level Component Overview

# 🏗️ System Architecture Diagram
# Visual representation of all components and their relationships

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Global CDN    │    │   Monitoring    │    │   GitOps        │
│   (Cloudflare)  │    │ (Prometheus/    │    │   (ArgoCD)      │
│                 │    │  Grafana)       │    │                 │
└─────────┬───────┘    └─────────────────┘    └─────────────────┘
          │
┌─────────▼───────────────────────────────────────────────────────┐
│                     Kubernetes Cluster                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐            │
│  │  Ingress    │  │  Frontend   │  │  Backend    │            │
│  │ Controller  │  │  (nginx)    │  │  (Node.js)  │            │
│  └─────────────┘  └─────────────┘  └─────────────┘            │
│                                          │                     │
│  ┌─────────────┐  ┌─────────────┐       │                     │
│  │ PostgreSQL  │  │   Redis     │◄──────┘                     │
│  │ Database    │  │   Cache     │                              │
│  └─────────────┘  └─────────────┘                              │
└─────────────────────────────────────────────────────────────────┘
```

## Application Layer Architecture

### User Interaction Flow

1. **User Browser** → Cloudflare CDN → Kubernetes Ingress → Frontend nginx
2. **Frontend JavaScript** → API calls → Backend Node.js service
3. **Backend Logic** → Database queries → PostgreSQL + Redis caching
4. **Response Path** → Reverse of the above with cached data optimization

[[ADD IMAGE: User interaction flow diagram from browser to database]]

### Component Responsibilities

**Frontend (nginx + Vanilla JavaScript):**
- Serves static HTML, CSS, JavaScript files
- Handles user interface interactions
- Makes REST API calls to backend
- Implements game logic and state management

**Backend (Node.js + Express):**
- RESTful API for game operations
- User authentication and session management
- Database operations and business logic
- Metrics collection for monitoring

**PostgreSQL Database:**
- User account storage
- Game session persistence
- Leaderboard data
- ACID compliance for data integrity

**Redis Cache:**
- Session storage for fast lookup
- Leaderboard caching for performance
- Temporary game state during active sessions
- Pub/sub for potential real-time features

## Infrastructure Layer Architecture

### Kubernetes Component Structure

# 📁 Kubernetes Resource Hierarchy
# Complete structure of all Kubernetes resources in the humor-game namespace

```
Namespace: humor-game
├── Deployments
│   ├── frontend (nginx container)
│   ├── backend (Node.js container)
│   ├── postgres (PostgreSQL container)
│   └── redis (Redis container)
├── Services
│   ├── frontend (ClusterIP)
│   ├── backend (ClusterIP)
│   ├── postgres (ClusterIP)
│   └── redis (ClusterIP)
├── ConfigMaps
│   └── humor-game-config (environment variables)
├── Secrets
│   └── humor-game-secrets (passwords, keys)
└── PersistentVolumeClaims
    ├── postgres-pvc (database storage)
    └── redis-pvc (cache persistence)
```

### Network Architecture

**External Access:**
- Internet → Cloudflare CDN → Cloudflare Tunnel → Kubernetes Ingress
- Local testing → Direct access via kubectl port-forward

**Internal Communication:**
- Frontend ↔ Backend: HTTP REST API
- Backend ↔ PostgreSQL: Direct database connection
- Backend ↔ Redis: Cache operations
- All services use Kubernetes DNS for service discovery

**Security Boundaries:**
- Network policies restrict inter-pod communication
- Security contexts run containers as non-root users
- Secrets are mounted as volumes, not environment variables

## Data Architecture

### Database Schema (PostgreSQL)

# 🗄️ PostgreSQL Database Schema
# Complete database structure for user management, game sessions, and leaderboards

```sql
-- Users table for authentication
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Game sessions for tracking individual games
CREATE TABLE game_sessions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    difficulty VARCHAR(20) NOT NULL,
    score INTEGER DEFAULT 0,
    attempts INTEGER DEFAULT 0,
    completed BOOLEAN DEFAULT FALSE,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP
);

-- Leaderboard aggregation for high scores
CREATE TABLE leaderboard (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    username VARCHAR(50),
    best_score INTEGER,
    total_games INTEGER,
    difficulty VARCHAR(20),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Caching Strategy (Redis)

# 🚀 Redis Cache Key Structure
# Organized cache keys for session management, game state, and leaderboards

```
Keys Structure:
- user:session:{user_id} → User session data
- game:active:{session_id} → Current game state
- leaderboard:easy → Cached easy difficulty rankings
- leaderboard:medium → Cached medium difficulty rankings  
- leaderboard:hard → Cached hard difficulty rankings
- stats:global → Global game statistics
```

**Cache Invalidation:**
- TTL-based expiration for temporary data
- Event-driven invalidation for leaderboards
- Write-through caching for user sessions

## Monitoring and Observability Architecture

### Metrics Collection

**Application Metrics (Prometheus):**
- HTTP request rate, latency, error rate (RED metrics)
- Database connection pool status
- Cache hit/miss ratios
- Business metrics (games completed, user registrations)

**Infrastructure Metrics:**
- Pod CPU and memory usage
- Persistent volume storage utilization
- Network traffic patterns
- Kubernetes cluster health

**Custom Dashboards (Grafana):**
- Application performance overview
- Business metrics dashboard
- Infrastructure health monitoring
- Alert status and incident tracking

### Logging Strategy

**Application Logs:**
- Structured JSON logging from Node.js backend
- nginx access logs for request tracing
- Database query logs for performance analysis

**System Logs:**
- Kubernetes event logs
- Container stdout/stderr collection
- Security audit logs

## Deployment Architecture

### GitOps Workflow

# 🔄 GitOps Deployment Flow
# Automated deployment process from code change to production

```
Developer → Git Push → ArgoCD Detection → Kubernetes Sync
     ↓
Configuration Repository (declarative YAML)
     ↓
ArgoCD Controller → Kubernetes API → Pod Updates
```

**Deployment Process:**
1. Developer updates application code
2. CI/CD builds new container image
3. Image tag updated in GitOps repository
4. ArgoCD detects configuration change
5. ArgoCD syncs new configuration to cluster
6. Kubernetes performs rolling update
7. Health checks verify successful deployment

### Multi-Environment Strategy

**Local Development (k3d):**
- Single-node cluster on developer laptop
- Direct image building and loading
- Port-forwarding for service access

**Production (Multi-zone Kubernetes):**
- High-availability control plane
- Node distribution across availability zones
- LoadBalancer services with external IPs
- Automatic scaling and failure recovery

## Security Architecture

### Defense-in-Depth Strategy

**Network Security:**
- Network policies for micro-segmentation
- Ingress-only external access points
- Service mesh for encrypted internal communication

**Container Security:**
- Non-root user execution
- Read-only root filesystems
- Resource limits to prevent resource exhaustion
- Regular security scanning of container images

**Data Security:**
- Encrypted secrets storage
- Database connection encryption
- Environment variable separation from sensitive data

**Access Control:**
- Role-based access control (RBAC) for Kubernetes
- Service account isolation
- Principle of least privilege enforcement

## Scaling Architecture

### Horizontal Scaling

**Application Tier:**
- Frontend: Multiple nginx replicas behind load balancer
- Backend: Horizontal Pod Autoscaler based on CPU/memory
- Database: Read replicas for query distribution
- Cache: Redis Cluster for distributed caching

**Infrastructure Tier:**
- Kubernetes node autoscaling
- Pod anti-affinity for availability zone distribution
- Persistent volume automatic provisioning

### Performance Optimization

**Caching Layers:**
- CDN edge caching for static content
- Redis application-level caching
- Browser caching with appropriate headers

**Database Optimization:**
- Connection pooling for efficient resource usage
- Query optimization and indexing strategy
- Automated backup and point-in-time recovery

## Technology Choice Rationale

### Why Kubernetes?
- **Industry Standard**: 88% adoption rate in enterprises
- **Career Value**: Essential skill for DevOps roles
- **Ecosystem**: Rich tooling and community support
- **Portability**: Runs consistently across environments

### Why Prometheus + Grafana?
- **Cloud Native**: CNCF graduated projects
- **Flexibility**: Powerful query language and visualization
- **Integration**: Native Kubernetes service discovery
- **Scalability**: Handles millions of metrics efficiently

### Why PostgreSQL + Redis?
- **Reliability**: ACID compliance and data integrity
- **Performance**: Optimized for both OLTP and caching
- **Ecosystem**: Excellent tooling and operational knowledge
- **Cost**: Open source with enterprise features

### Why ArgoCD?
- **GitOps Standard**: Declarative configuration management
- **Audit Trail**: Complete deployment history
- **Rollback**: Easy recovery from failed deployments
- **Security**: Git-based access control

## What You Learned

You now understand:
- **Complete system architecture** from user request to database response
- **Component interactions** and data flow patterns
- **Infrastructure design** for production scalability
- **Technology choices** and their career relevance
- **Security boundaries** and defense-in-depth strategies
- **Monitoring strategy** for production operations

This architectural foundation will guide your implementation decisions throughout the remaining chapters. Each component serves a specific purpose in creating a production-ready system.

---

**Next**: [Chapter 3: Environment Setup](03-env-setup.md) - Install and configure all required tools
**Previous**: [Chapter 1: Introduction](01-intro.md) - Understanding what you're building and why
