# DevOps Production Deployment: Complete Beginner Guide

**From Zero to Production-Ready DevOps Engineer**

*A comprehensive guide to building production-ready applications with
Kubernetes, GitOps, and modern DevOps practices*

------------------------------------------------------------------------

**Author:** Zudonu Osomudeya\
**Version:** 1.0\
**Date:** 2025\
**Target Audience:** Complete beginners to DevOps

------------------------------------------------------------------------

## Table of Contents

### Part I: Foundation

1.  [Introduction: What You'll Build](chapters/01-intro/chapter.md)
2.  [System Architecture Overview](chapters/02-architecture/chapter.md)
3.  [Environment Setup](chapters/03-env-setup/chapter.md)

### Part II: Application Development

4.  [Local Multi-Container
    Development](chapters/04-local-compose/chapter.md)
5.  [Kubernetes Production
    Deployment](chapters/05-kubernetes-basics/chapter.md)
6.  [Internet Access &
    Networking](chapters/06-ingress-networking/chapter.md)

### Part III: Production Operations

7.  [Automated Deployments with CI/CD](chapters/07-ci-cd/chapter.md)
8.  [Monitoring and Observability](chapters/08-observability/chapter.md)
9.  [GitOps: The Modern Way to Deploy](chapters/09-gitops/chapter.md)

### Part IV: Production Hardening

10. [Security and Production
    Hardening](chapters/10-prod-hardening/chapter.md)
11. [Deployment
    Strategies](chapters/11-deployment-strategies/chapter.md)
12. [Troubleshooting Production
    Issues](chapters/12-troubleshooting/chapter.md)

### Part V: Career Development

13. [Preparing for DevOps
    Interviews](chapters/13-interview-prep/chapter.md)
14. [Next Steps: Your DevOps Journey](chapters/14-next-steps/chapter.md)

------------------------------------------------------------------------

## About This Guide

This comprehensive guide takes you from knowing nothing about DevOps to
building and deploying a production-ready application that could serve
millions of users. You'll learn the same technologies and practices used
by companies like Netflix, Airbnb, and GitHub.

### What Makes This Different

Most DevOps tutorials teach you to deploy "hello world" applications
that bear no resemblance to real production systems. This guide is
different. You'll build a complete **Humor Memory Game** application
with the same infrastructure patterns used by major tech companies.

### Your Learning Journey

**Week 1: Foundation** - Understanding what DevOps really means -
Setting up your development environment - Building a multi-container
application

**Week 2: Production Deployment** - Deploying to Kubernetes - Making
your app globally accessible - Setting up monitoring

**Week 3: Automation and Security** - Building CI/CD pipelines -
Implementing GitOps - Securing your application

**Week 4: Mastery** - Scaling and optimization - Troubleshooting real
issues - Preparing for DevOps roles

### Technology Stack You'll Master

**Containerization** - Docker and Docker Compose - Multi-container
application architecture - Container best practices

**Orchestration** - Kubernetes fundamentals - Pods, Services, and
Deployments - Configuration management with Kustomize

**Networking** - Ingress controllers - Load balancing - Global CDN
integration

**Automation** - GitOps with ArgoCD - CI/CD with GitHub Actions -
Infrastructure as Code

**Monitoring** - Prometheus metrics collection - Grafana dashboards -
Alerting and incident response

**Security** - Network policies - Secrets management - Security scanning

### Success Metrics

By the end of this guide, you'll be able to:

- Deploy a multi-service application to Kubernetes
- Set up automated CI/CD pipelines
- Monitor application performance and health
- Implement security best practices
- Troubleshoot production issues
- Explain DevOps concepts in technical interviews

------------------------------------------------------------------------

## How to Use This Guide

### For Complete Beginners

Start with Chapter 1 and work through each chapter sequentially. Each
chapter builds on the previous one, so don't skip ahead.

### For Experienced Developers

You can jump to specific chapters that interest you, but I recommend at
least reading the architecture overview (Chapter 2) to understand the
complete system.

### For Career Changers

Focus on understanding the "why" behind each decision. This guide
explains not just how to do things, but why these approaches are used in
production environments.

### Time Investment

- **Total Time**: 6-10 hours over 1-2 weeks
- **Daily Sessions**: 30-60 minutes work well
- **Practice**: Additional time for experimentation and troubleshooting

------------------------------------------------------------------------

## Prerequisites

**What You Need to Know** - Basic command line navigation -
Understanding of what containers are (conceptually) - Familiarity with
text editors

**What You Don't Need** - Previous DevOps experience - Cloud platform
knowledge - Advanced programming skills - Expensive hardware or cloud
accounts

**System Requirements** - 4GB+ RAM available - 10GB+ disk space - macOS,
Linux, or Windows with WSL2 - Internet connection for downloading tools

------------------------------------------------------------------------

## Getting Started

Ready to begin your DevOps journey? Start with [Chapter 1:
Introduction](chapters/01-intro/chapter.md) to understand what you'll
build and why it matters for your career.

**Your journey to production-ready DevOps expertise starts now.**

# Table of Contents

## DevOps Production Deployment: Complete Beginner Guide

### Part I: Foundation

#### Chapter 1: Introduction - What You'll Build

- **File**: `chapters/01-intro/chapter.md`
- **Time**: 15 minutes
- **Prerequisites**: None
- **What You'll Learn**:
  - The architecture of a production-grade application stack
  - Why each technology choice matters for career development
  - The learning journey from Docker to global deployment
  - Success metrics and real-world impact

#### Chapter 2: System Architecture Overview

- **File**: `chapters/02-architecture/chapter.md`
- **Time**: 20 minutes
- **Prerequisites**: Chapter 1
- **What You'll Learn**:
  - High-level system architecture and component relationships
  - Data flow from user interaction to database persistence
  - Technology choices and their production implications
  - How the system scales from local development to global deployment

#### Chapter 3: Environment Setup

- **File**: `chapters/03-env-setup/chapter.md`
- **Time**: 30 minutes
- **Prerequisites**: Chapter 2
- **What You'll Learn**:
  - Complete development environment setup for DevOps workflows
  - Tool installation and verification procedures
  - System resource requirements and optimization
  - Troubleshooting common installation issues

### Part II: Application Development

#### Chapter 4: Local Multi-Container Development

- **File**: `chapters/04-local-compose/chapter.md`
- **Time**: 20-40 minutes
- **Prerequisites**: Chapter 3
- **What You'll Learn**:
  - Building multi-container applications with Docker Compose
  - Service communication and data persistence
  - Local development workflow optimization
  - Container debugging and troubleshooting

#### Chapter 5: Kubernetes Production Deployment

- **File**: `chapters/05-kubernetes-basics/chapter.md`
- **Time**: 30-60 minutes
- **Prerequisites**: Chapter 4
- **What You'll Learn**:
  - Kubernetes fundamentals and resource types
  - Production deployment strategies
  - Configuration management with Kustomize
  - Resource management and scaling

#### Chapter 6: Internet Access & Networking

- **File**: `chapters/06-ingress-networking/chapter.md`
- **Time**: 20-40 minutes
- **Prerequisites**: Chapter 5
- **What You'll Learn**:
  - Ingress controllers and load balancing
  - DNS configuration and SSL certificate management
  - Global CDN integration with Cloudflare
  - Network security and policy enforcement

### Part III: Production Operations

#### Chapter 7: Automated Deployments with CI/CD

- **File**: `chapters/07-ci-cd/chapter.md`
- **Time**: 30-60 minutes
- **Prerequisites**: Chapter 6
- **What You'll Learn**:
  - GitHub Actions workflow design
  - Container image building and security scanning
  - Automated testing and deployment strategies
  - GitOps integration and best practices

#### Chapter 8: Monitoring and Observability

- **File**: `chapters/08-observability/chapter.md`
- **Time**: 45-90 minutes
- **Prerequisites**: Chapter 7
- **What You'll Learn**:
  - Prometheus metrics collection and querying
  - Grafana dashboard creation and customization
  - Alerting configuration and incident response
  - Application performance monitoring

#### Chapter 9: GitOps: The Modern Way to Deploy

- **File**: `chapters/09-gitops/chapter.md`
- **Time**: 30-60 minutes
- **Prerequisites**: Chapter 8
- **What You'll Learn**:
  - ArgoCD setup and configuration
  - GitOps workflow implementation
  - Declarative configuration management
  - Automated deployment and rollback strategies

### Part IV: Production Hardening

#### Chapter 10: Security and Production Hardening

- **File**: `chapters/10-prod-hardening/chapter.md`
- **Time**: 60-120 minutes
- **Prerequisites**: Chapter 9
- **What You'll Learn**:
  - Security contexts and network policies
  - Secrets management and rotation
  - Container security best practices
  - Compliance and governance frameworks

#### Chapter 11: Deployment Strategies

- **File**: `chapters/11-deployment-strategies/chapter.md`
- **Time**: 30-60 minutes
- **Prerequisites**: Chapter 10
- **What You'll Learn**:
  - Rolling updates and blue-green deployments
  - Canary deployments and traffic splitting
  - Zero-downtime deployment strategies
  - Rollback and disaster recovery

#### Chapter 12: Troubleshooting Production Issues

- **File**: `chapters/12-troubleshooting/chapter.md`
- **Time**: 45-90 minutes
- **Prerequisites**: Chapter 11
- **What You'll Learn**:
  - Systematic troubleshooting methodology
  - Common Kubernetes issues and solutions
  - Performance optimization techniques
  - Incident response procedures

### Part V: Career Development

#### Chapter 13: Preparing for DevOps Interviews

- **File**: `chapters/13-interview-prep/chapter.md`
- **Time**: 60-120 minutes
- **Prerequisites**: All previous chapters
- **What You'll Learn**:
  - Technical interview preparation strategies
  - Behavioral questions and storytelling
  - Troubleshooting scenarios and problem-solving
  - Architecture deep dives and system design

#### Chapter 14: Next Steps: Your DevOps Journey

- **File**: `chapters/14-next-steps/chapter.md`
- **Time**: 15 minutes
- **Prerequisites**: All previous chapters
- **What You'll Learn**:
  - Career pathways in DevOps and platform engineering
  - Advanced topics to explore next
  - Building a professional portfolio
  - Continuous learning strategies

------------------------------------------------------------------------

## Learning Path Recommendations

### For Complete Beginners

**Recommended Path**: Chapters 1-14 in order **Time Investment**: 6-10
hours over 1-2 weeks **Focus**: Understanding the complete DevOps
lifecycle

### For Experienced Developers

**Recommended Path**: Chapters 1-2, then skip to chapters of interest
**Time Investment**: 3-5 hours **Focus**: Understanding production
patterns and best practices

### For Career Changers

**Recommended Path**: Chapters 1-3, 7, 9, 13-14 **Time Investment**: 4-6
hours **Focus**: Understanding DevOps concepts and interview preparation

### For DevOps Professionals

**Recommended Path**: Chapters 2, 6, 8, 10-12 **Time Investment**: 3-4
hours **Focus**: Advanced patterns and troubleshooting techniques

------------------------------------------------------------------------

## Success Metrics

By completing this guide, you'll have:

### Technical Achievements

-  **4 microservices** running in production configuration
-  **Zero-downtime deployments** with rolling updates
-  **Comprehensive monitoring** with custom metrics and alerts
-  **Global accessibility** through CDN integration
-  **Production security** with network policies and security contexts
-  **Automated operations** through GitOps workflows

### Career Readiness

-  **Portfolio project** showcasing enterprise-grade DevOps skills
-  **Interview preparation** with real scenarios and talking points
-  **Troubleshooting experience** with actual production-like issues
-  **Architecture understanding** of how major tech companies operate
-  **Hands-on expertise** with industry-standard tools and practices

------------------------------------------------------------------------

## Additional Resources

### Documentation References

- [Kubernetes Official Documentation](https://kubernetes.io/docs/)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Docker Documentation](https://docs.docker.com/)

### Community Resources

- [CNCF Landscape](https://landscape.cncf.io/)
- [Kubernetes Slack](https://kubernetes.slack.com/)
- [DevOps Subreddit](https://reddit.com/r/devops)
- [GitHub DevOps Discussions](https://github.com/topics/devops)

### Certification Paths

- Certified Kubernetes Administrator (CKA)
- Certified Kubernetes Security Specialist (CKS)
- AWS Certified DevOps Engineer
- Google Cloud Professional DevOps Engineer

------------------------------------------------------------------------

*This guide represents distilled experience from engineers who have
built and scaled systems at companies like Google, Netflix, and Airbnb.
Use it as a foundation for your continued growth in the DevOps and
platform engineering disciplines.*

# Chapter 1: Introduction - What We're Building

*Learn DevOps by building a real application that scales from local
development to global production*

------------------------------------------------------------------------

## What You'll Learn

- The architecture of a production-grade application stack
- Why each technology choice matters for career development
- The learning journey from Docker to global deployment
- Success metrics and real-world impact

## Time Required: 15 minutes

## Prerequisites: None - This is your starting point

------------------------------------------------------------------------

## Why This Matters

Most DevOps tutorials teach you to deploy "hello world" applications
that bear no resemblance to real production systems. This guide is
different. You'll build a complete **Humor Memory Game** application
with the same infrastructure patterns used by major tech companies.

**Career Impact**: The skills you'll learn directly translate to DevOps
engineer roles that typically pay \$90,000-\$150,000+ annually.
Companies desperately need engineers who understand how to deploy and
maintain production applications at scale.

### What Professional DevOps Engineers Actually Do

DevOps engineers don't just run `kubectl apply`. They: - Design systems
that serve millions of users without breaking - Implement monitoring
that catches problems before customers notice - Build deployment
pipelines that allow multiple daily releases - Troubleshoot complex
issues across distributed systems - Plan for disasters and ensure
applications recover automatically

This guide teaches you to think and work like a professional platform
engineer.

## What You'll Build

### The Application: Humor Memory Game

You'll deploy a complete web application featuring:

- **Interactive Game Interface**: 4x4 grid memory game with humor-themed
  cards
- **User Management**: Registration, authentication, and persistent user
  sessions\
- **Leaderboards**: Global and personal statistics with PostgreSQL
  persistence
- **Real-time Features**: Live score updates using Redis caching
- **Production APIs**: RESTful backend with comprehensive health checks

\[\[ADD IMAGE: Game interface showing 4x4 card grid with game stats\]\]

### The Infrastructure Stack

**Application Layer:** - **Frontend**: Vanilla JavaScript with nginx
(production-optimized) - **Backend**: Node.js Express API with metrics
instrumentation - **Database**: PostgreSQL 15 with connection pooling -
**Cache**: Redis 7 with persistence and authentication

**Infrastructure Layer:** - **Containerization**: Multi-stage Docker
builds optimized for production - **Orchestration**: Kubernetes with
proper resource limits and health checks - **Networking**: Production
ingress with SSL termination and load balancing - **Monitoring**:
Prometheus metrics with custom Grafana dashboards - **Automation**:
GitOps deployment pipeline with ArgoCD - **Security**: Network policies,
security contexts, and secrets management - **Global Access**:
Cloudflare CDN with automatic failover

### Learning Progression

This isn't a simple tutorial - it's a **professional development
pathway**:

  ----------------------------------------------------------------------------
  Stage               Focus           Real-World Parallel
  ------------------- --------------- ----------------------------------------
  **Local             Docker Compose  Developer workstation setup
  Development**                       

  **Basic             Pod deployment  Staging environment
  Kubernetes**                        

  **Production        Ingress         Production traffic routing
  Networking**        configuration   

  **Observability**   Monitoring      Site reliability engineering
                      setup           

  **Automation**      GitOps          DevOps engineering workflows
                      pipelines       

  **Global Scale**    CDN and         Enterprise production systems
                      security        
  ----------------------------------------------------------------------------

## Learning Outcomes

### Technical Skills You'll Master

**Container Orchestration:** - Multi-service application deployment -
Resource management and scaling - Health checks and failure recovery -
Storage persistence and backup strategies

**Production Networking:** - Ingress controllers and load balancing -
DNS configuration and SSL certificate management - Service mesh concepts
and implementation - Network security and policy enforcement

**Monitoring and Observability:** - Metrics collection with Prometheus -
Custom dashboard creation in Grafana - Log aggregation and analysis -
Alert configuration and incident response

**DevOps Automation:** - GitOps workflow implementation - CI/CD pipeline
design - Infrastructure as Code practices - Automated testing and
deployment strategies

**Security and Compliance:** - Container security best practices -
Network segmentation and policies - Secrets management and rotation -
Security context configuration

### Career Skills You'll Develop

**Problem-Solving Approach:** - Systematic troubleshooting methodology -
Root cause analysis techniques - Performance optimization strategies -
Capacity planning and scaling decisions

**Professional Communication:** - Technical documentation writing -
Incident response procedures - Architecture decision documentation -
Interview presentation skills

**Platform Engineering Mindset:** - Designing for reliability and
maintainability - Automation-first thinking - Security-by-design
principles - User experience focus for developer tools

## Success Metrics

By the end of this guide, you'll have built a system that demonstrates:

### Technical Achievements

-  **4 microservices** running in production configuration
-  **Zero-downtime deployments** with rolling updates
-  **Comprehensive monitoring** with custom metrics and alerts
-  **Global accessibility** through CDN integration
-  **Production security** with network policies and security contexts
-  **Automated operations** through GitOps workflows

### Career Readiness

-  **Portfolio project** showcasing enterprise-grade DevOps skills
-  **Interview preparation** with real scenarios and talking points
-  **Troubleshooting experience** with actual production-like issues
-  **Architecture understanding** of how major tech companies operate
-  **Hands-on expertise** with industry-standard tools and practices

## Technology Stack Deep Dive

### Why These Technologies?

**Kubernetes**: Used by 88% of organizations for container orchestration
(CNCF Survey 2024). Learning Kubernetes opens doors to virtually every
major tech company.

**Prometheus + Grafana**: The de facto standard for cloud-native
monitoring. These skills are essential for Site Reliability Engineer
roles.

**ArgoCD**: GitOps is becoming the standard for production deployments.
Understanding declarative configuration management is crucial for modern
DevOps roles.

**PostgreSQL + Redis**: The most common production database stack.
Understanding persistence, caching, and performance optimization is
fundamental for backend systems.

### Industry Relevance

The patterns you'll learn mirror those used by:

- **Netflix**: Multi-region deployment with automatic failover
- **Airbnb**: Comprehensive monitoring and alerting systems\
- **GitHub**: GitOps-based deployment automation
- **Spotify**: Kubernetes-native application development

These aren't academic exercises - they're proven approaches used to
serve millions of users reliably.

## What You Need to Succeed

### Required Mindset

- **Curiosity**: Question why each step matters
- **Persistence**: Complex systems require patience to debug
- **Attention to Detail**: Small configuration errors cause big problems
- **Systems Thinking**: Understand how components interact

### Time Investment

- **Total Time**: 6-10 hours over 1-2 weeks
- **Daily Sessions**: 30-60 minutes work well
- **Practice**: Additional time for experimentation and troubleshooting

### Support Resources

- **Complete Documentation**: Step-by-step guides with troubleshooting
- **Community Support**: GitHub discussions and issue tracking
- **Reset Procedures**: Clean slate commands when things go wrong
- **Professional Context**: Real-world explanations for every decision

## Common Concerns Addressed

**"I'm not ready for Kubernetes"**: The guide starts with Docker Compose
for a reason. Each step builds naturally on the previous one.

**"This seems too complex"**: Professional systems are complex, but we
break them down into manageable pieces. Each milestone is independently
valuable.

**"I don't have cloud experience"**: Everything runs locally on your
laptop using k3d. No cloud accounts or costs required.

**"What if I get stuck?"**: Comprehensive troubleshooting sections and
reset procedures ensure you can always recover and continue learning.

## Next Steps

Ready to see the big picture? Chapter 2 provides a detailed architecture
overview that shows how all the pieces fit together. Understanding the
destination makes the journey more meaningful.

The skills you're about to learn are in high demand. DevOps engineers
with Kubernetes experience typically earn 20-30% more than those without
it. More importantly, you'll understand how modern software systems
actually work at scale.

**Your journey to production-ready DevOps expertise starts now.**

------------------------------------------------------------------------

**Next**: [Chapter 2: Architecture Overview](02-architecture.md) - See
the complete system design and understand how each component contributes
to a production-grade application. **Previous**: [Front
Matter](00-front-matter.md) - How to use this book effectively

# Chapter 2: System Architecture Overview

*Understanding the complete production-grade infrastructure before you
build it*

------------------------------------------------------------------------

## What You'll Learn

- High-level system architecture and component relationships
- Data flow from user interaction to database persistence
- Technology choices and their production implications
- How the system scales from local development to global deployment

## Time Required: 20 minutes

## Prerequisites: [Chapter 1: Introduction](01-intro.md)

------------------------------------------------------------------------

## Why This Matters

Understanding the complete architecture before diving into
implementation helps you see how each piece contributes to the whole.
This prevents the common mistake of learning individual tools without
understanding how they work together in production systems.

**Professional Context**: Senior engineers always start with
architecture diagrams. Understanding system design is what
differentiates DevOps engineers from script runners.

## Complete System Architecture

\[\[ADD IMAGE: Complete technical architecture diagram showing all
components and connections\]\]

### High-Level Component Overview

#  System Architecture Diagram

# Visual representation of all components and their relationships

       Global CDN           Monitoring           GitOps        
       (Cloudflare)       (Prometheus/           (ArgoCD)      
                           Grafana)                            

                         Kubernetes Cluster                         
                      
        Ingress        Frontend       Backend                
       Controller      (nginx)        (Node.js)              

       PostgreSQL       Redis                          
       Database         Cache                                   

## Application Layer Architecture

### User Interaction Flow

1.  **User Browser**  Cloudflare CDN  Kubernetes Ingress  Frontend
    nginx
2.  **Frontend JavaScript**  API calls  Backend Node.js service
3.  **Backend Logic**  Database queries  PostgreSQL + Redis caching
4.  **Response Path**  Reverse of the above with cached data
    optimization

\[\[ADD IMAGE: User interaction flow diagram from browser to
database\]\]

### Component Responsibilities

**Frontend (nginx + Vanilla JavaScript):** - Serves static HTML, CSS,
JavaScript files - Handles user interface interactions - Makes REST API
calls to backend - Implements game logic and state management

**Backend (Node.js + Express):** - RESTful API for game operations -
User authentication and session management - Database operations and
business logic - Metrics collection for monitoring

**PostgreSQL Database:** - User account storage - Game session
persistence - Leaderboard data - ACID compliance for data integrity

**Redis Cache:** - Session storage for fast lookup - Leaderboard caching
for performance - Temporary game state during active sessions - Pub/sub
for potential real-time features

## Infrastructure Layer Architecture

### Kubernetes Component Structure

#  Kubernetes Resource Hierarchy

# Complete structure of all Kubernetes resources in the humor-game namespace

    Namespace: humor-game
     Deployments
        frontend (nginx container)
        backend (Node.js container)
        postgres (PostgreSQL container)
        redis (Redis container)
     Services
        frontend (ClusterIP)
        backend (ClusterIP)
        postgres (ClusterIP)
        redis (ClusterIP)
     ConfigMaps
        humor-game-config (environment variables)
     Secrets
        humor-game-secrets (passwords, keys)
     PersistentVolumeClaims
         postgres-pvc (database storage)
         redis-pvc (cache persistence)

### Network Architecture

**External Access:** - Internet  Cloudflare CDN  Cloudflare Tunnel 
Kubernetes Ingress - Local testing  Direct access via kubectl
port-forward

**Internal Communication:** - Frontend  Backend: HTTP REST API -
Backend  PostgreSQL: Direct database connection - Backend  Redis:
Cache operations - All services use Kubernetes DNS for service discovery

**Security Boundaries:** - Network policies restrict inter-pod
communication - Security contexts run containers as non-root users -
Secrets are mounted as volumes, not environment variables

## Data Architecture

### Database Schema (PostgreSQL)

#  PostgreSQL Database Schema

# Complete database structure for user management, game sessions, and leaderboards

``` sql
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

#  Redis Cache Key Structure

# Organized cache keys for session management, game state, and leaderboards

    Keys Structure:
    - user:session:{user_id}  User session data
    - game:active:{session_id}  Current game state
    - leaderboard:easy  Cached easy difficulty rankings
    - leaderboard:medium  Cached medium difficulty rankings  
    - leaderboard:hard  Cached hard difficulty rankings
    - stats:global  Global game statistics

**Cache Invalidation:** - TTL-based expiration for temporary data -
Event-driven invalidation for leaderboards - Write-through caching for
user sessions

## Monitoring and Observability Architecture

### Metrics Collection

**Application Metrics (Prometheus):** - HTTP request rate, latency,
error rate (RED metrics) - Database connection pool status - Cache
hit/miss ratios - Business metrics (games completed, user registrations)

**Infrastructure Metrics:** - Pod CPU and memory usage - Persistent
volume storage utilization - Network traffic patterns - Kubernetes
cluster health

**Custom Dashboards (Grafana):** - Application performance overview -
Business metrics dashboard - Infrastructure health monitoring - Alert
status and incident tracking

### Logging Strategy

**Application Logs:** - Structured JSON logging from Node.js backend -
nginx access logs for request tracing - Database query logs for
performance analysis

**System Logs:** - Kubernetes event logs - Container stdout/stderr
collection - Security audit logs

## Deployment Architecture

### GitOps Workflow

#  GitOps Deployment Flow

# Automated deployment process from code change to production

    Developer  Git Push  ArgoCD Detection  Kubernetes Sync
         
    Configuration Repository (declarative YAML)
         
    ArgoCD Controller  Kubernetes API  Pod Updates

**Deployment Process:** 1. Developer updates application code 2. CI/CD
builds new container image 3. Image tag updated in GitOps repository 4.
ArgoCD detects configuration change 5. ArgoCD syncs new configuration to
cluster 6. Kubernetes performs rolling update 7. Health checks verify
successful deployment

### Multi-Environment Strategy

**Local Development (k3d):** - Single-node cluster on developer laptop -
Direct image building and loading - Port-forwarding for service access

**Production (Multi-zone Kubernetes):** - High-availability control
plane - Node distribution across availability zones - LoadBalancer
services with external IPs - Automatic scaling and failure recovery

## Security Architecture

### Defense-in-Depth Strategy

**Network Security:** - Network policies for micro-segmentation -
Ingress-only external access points - Service mesh for encrypted
internal communication

**Container Security:** - Non-root user execution - Read-only root
filesystems - Resource limits to prevent resource exhaustion - Regular
security scanning of container images

**Data Security:** - Encrypted secrets storage - Database connection
encryption - Environment variable separation from sensitive data

**Access Control:** - Role-based access control (RBAC) for Kubernetes -
Service account isolation - Principle of least privilege enforcement

## Scaling Architecture

### Horizontal Scaling

**Application Tier:** - Frontend: Multiple nginx replicas behind load
balancer - Backend: Horizontal Pod Autoscaler based on CPU/memory -
Database: Read replicas for query distribution - Cache: Redis Cluster
for distributed caching

**Infrastructure Tier:** - Kubernetes node autoscaling - Pod
anti-affinity for availability zone distribution - Persistent volume
automatic provisioning

### Performance Optimization

**Caching Layers:** - CDN edge caching for static content - Redis
application-level caching - Browser caching with appropriate headers

**Database Optimization:** - Connection pooling for efficient resource
usage - Query optimization and indexing strategy - Automated backup and
point-in-time recovery

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

You now understand: - **Complete system architecture** from user request
to database response - **Component interactions** and data flow
patterns - **Infrastructure design** for production scalability -
**Technology choices** and their career relevance - **Security
boundaries** and defense-in-depth strategies - **Monitoring strategy**
for production operations

This architectural foundation will guide your implementation decisions
throughout the remaining chapters. Each component serves a specific
purpose in creating a production-ready system.

------------------------------------------------------------------------

**Next**: [Chapter 3: Environment Setup](03-env-setup.md) - Install and
configure all required tools **Previous**: [Chapter 1:
Introduction](01-intro.md) - Understanding what you're building and why

# Chapter 3: Environment Setup

*Install and configure all tools needed for production-grade DevOps
development*

------------------------------------------------------------------------

## What You'll Learn

- Complete development environment setup for DevOps workflows
- Tool installation and verification procedures
- System resource requirements and optimization
- Troubleshooting common installation issues

## Time Required: 30 minutes

## Prerequisites: [Chapter 2: Architecture Overview](02-architecture.md)

------------------------------------------------------------------------

## Why This Matters

Professional DevOps work requires a properly configured toolchain.
Installing tools correctly the first time prevents hours of debugging
later. Think of this as setting up your workshop before building a
house - you need the right tools to build something that actually works.

**Professional Context**: Every DevOps team has a standardized
development environment. Learning to set up and maintain developer
tooling is a fundamental skill that demonstrates attention to detail and
operational thinking.

## Required Tools Overview

The tools you'll install are used daily by professional DevOps
engineers:

  ------------------------------------------------------------------------
  Tool          Purpose             Career Relevance
  ------------- ------------------- --------------------------------------
  **Docker**    Container runtime   Essential for modern application
                                    deployment

  **kubectl**   Kubernetes CLI      Required for any Kubernetes operation

  **k3d**       Local Kubernetes    Industry standard for local
                                    development

  **Helm**      Kubernetes package  Used in 80%+ of Kubernetes deployments
                manager             

  **Node.js**   JavaScript runtime  Powers the application backend

  **jq**        JSON processor      Critical for DevOps automation scripts
  ------------------------------------------------------------------------

## System Requirements

**Minimum Requirements:** - **RAM**: 4GB available (8GB recommended) -
**Storage**: 10GB free disk space - **Network**: Stable internet for
image downloads - **OS**: macOS, Linux, or Windows with WSL2

**Resource Planning:** - Kubernetes cluster: \~2GB RAM - Application
stack: \~1GB RAM\
- Container images: \~3GB storage - Development tools: \~1GB storage

## Tool Installation

### macOS Installation (Recommended)

The fastest path for macOS users is Homebrew:

#  macOS Tool Installation

# Install all required DevOps tools using Homebrew package manager

``` bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all required tools
brew install docker docker-compose kubectl k3d helm nodejs jq
```

**Expected Output:**

#  Homebrew Installation Output

# Successful installation confirmation for all DevOps tools

``` bash
==> Installing docker
==> Installing docker-compose
==> Installing kubectl
==> Installing k3d
==> Installing helm
==> Installing nodejs
==> Installing jq
  docker, docker-compose, kubectl, k3d, helm, nodejs, jq were successfully installed
```

** Important**: You also need Docker Desktop for the container
runtime:

#  Docker Desktop Installation

# Alternative container runtime setup for macOS

``` bash
# Download and install Docker Desktop
# Visit: https://www.docker.com/products/docker-desktop
# Or install via Homebrew Cask:
brew install --cask docker
```

**Alternative**: If you prefer Colima over Docker Desktop \[\[memory:
6996562\]\]:

#  Colima Docker Alternative

# Lightweight Docker runtime for macOS without Docker Desktop

``` bash
# Install Colima as Docker Desktop alternative
brew install colima

# Start Colima
colima start
```

### Linux Installation (Ubuntu/Debian)

For Linux systems, install each tool separately:

#  Linux Tool Installation

# Step-by-step installation for Ubuntu/Debian systems

``` bash
# Update package index
sudo apt-get update

# Install Docker
sudo apt-get install -y docker.io docker-compose
sudo usermod -aG docker $USER
newgrp docker  # Apply group changes immediately
```

**Expected Output:**

#  Linux Installation Output

# Confirmation of successful Docker installation on Linux

``` bash
Reading package lists... Done
Building dependency tree... Done
docker.io is already the newest version (20.10.21)
docker-compose is already the newest version (1.25.0)
Adding user to docker group...
```

#  kubectl Installation

# Install Kubernetes command-line tool for cluster management

``` bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl  # Clean up downloaded file
```

#  k3d Installation

# Install lightweight Kubernetes distribution for local development

``` bash
# Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

** Pro Tip**: k3d is a lightweight Kubernetes distribution that runs
inside Docker containers. It's perfect for development because it starts
quickly, uses minimal resources, and provides a real Kubernetes
experience without cluster management overhead.

#  Helm Installation

# Install Kubernetes package manager for application deployment

``` bash
# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

#  Node.js and jq Installation

# Install JavaScript runtime and JSON processor

``` bash
# Install Node.js and jq
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs jq
```

### Windows with WSL2

For Windows users, enable WSL2 first, then follow the Linux instructions
above.

#  Windows WSL2 Setup

# Enable Windows Subsystem for Linux for development environment

``` powershell
# Enable WSL2 (run in PowerShell as Administrator)
wsl --install

# Restart your computer, then install Ubuntu from Microsoft Store
# Follow Linux installation steps inside Ubuntu terminal
```

## Tool Verification

After installation, verify each tool is working correctly:

#  Tool Verification Commands

# Verify all installed tools are working correctly

``` bash
# Check Docker
docker --version
docker info
```

**Expected Output:**

#  Docker Verification Output

# Confirmation that Docker daemon is running properly

``` bash
Docker version 20.10.21, build 20.10.21-0ubuntu1~20.04.2
Client:
 Context:    default
 Debug Mode: false
Server:
 Server Version: 20.10.21
 Storage Driver: overlay2
 Total Memory: 4.096GiB
```

#  Kubernetes Tools Verification

# Check versions of kubectl, k3d, and Helm

``` bash
# Check Kubernetes tools
kubectl version --client
k3d version
helm version
```

**Expected Output:**

#  Kubernetes Tools Version Output

# Confirmation of installed Kubernetes tool versions

``` bash
Client Version: version.Info{Major:"1", Minor:"28", GitVersion:"v1.28.0"}
k3d version v5.6.0
version.BuildInfo{Version:"v3.12.3", GitCommit:"3a31588"}
```

#  Development Tools Verification

# Check Node.js, npm, and jq versions

``` bash
# Check development tools
node --version
npm --version
jq --version
```

**Expected Output:**

#  Development Tools Version Output

# Confirmation of Node.js, npm, and jq installations

``` bash
v18.17.1
8.19.4
jq-1.6
```

### Test Docker Functionality

Verify Docker is working with a simple test:

#  Docker Functionality Test

# Run hello-world container to verify Docker daemon

``` bash
# Test Docker daemon
docker run hello-world
```

**Expected Output:**

#  Docker Hello World Test Output

# Successful Docker daemon verification

``` bash
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
```

\[\[ADD IMAGE: Terminal output showing successful hello-world Docker
container\]\]

## System Resource Check

Verify your system has sufficient resources:

#  System Resource Check

# Verify available memory and disk space

``` bash
# Check available memory (macOS)
vm_stat | head -10

# Check available memory (Linux)
free -h

# Check disk space
df -h
```

**Expected Output:**

#  System Resource Status

# Memory and disk space availability confirmation

``` bash
              total        used        free      shared  buff/cache   available
Mem:          7.8Gi       2.1Gi       3.2Gi       0.5Gi       2.5Gi       5.1Gi
Swap:         2.0Gi          0B       2.0Gi

Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   25G   23G  53% /
```

** Resource Requirements**: Ensure you have at least 4GB available
memory and 10GB free disk space before proceeding.

## Project Setup

Clone the project repository and verify structure:

#  Project Repository Setup

# Clone and verify the DevOps Home Lab project structure

``` bash
# Clone the repository
git clone https://github.com/Osomudeya/DevOps-Home-Lab-2025.git
cd DevOps-Home-Lab-2025

# Verify project structure
ls -la
```

**Expected Output:**

#  Project Structure Verification

# Confirmation of cloned repository contents

``` bash
total 24
drwxr-xr-x  12 user  staff   384 Jan 15 10:30 .
drwxr-xr-x   5 user  staff   160 Jan 15 10:30 ..
drwxr-xr-x   8 user  staff   256 Jan 15 10:30 .github
-rw-r--r--   1 user  staff  1234 Jan 15 10:30 README.md
drwxr-xr-x   5 user  staff   160 Jan 15 10:30 backend
drwxr-xr-x   7 user  staff   224 Jan 15 10:30 docs
drwxr-xr-x   4 user  staff   128 Jan 15 10:30 frontend
drwxr-xr-x  12 user  staff   384 Jan 15 10:30 k8s
-rw-r--r--   1 user  staff  2156 Jan 15 10:30 Makefile
drwxr-xr-x   8 user  staff   256 Jan 15 10:30 scripts
```

#  Project Automation Test

# Verify Makefile commands are available

``` bash
# Test project automation
make help
```

**Expected Output:**

#  Makefile Help Output

# Available automation commands for the project

``` bash
 Production Kubernetes Homelab - Quick Commands

 Deployment Commands:
  setup-cluster        Create and configure k3d cluster
  deploy-all           Deploy complete infrastructure
  deploy-app           Deploy the main application

 Testing & Verification:
  verify               Verify all deployments
  test-endpoints       Test application endpoints
```

## Environment Verification

Run the complete verification script:

#  Environment Verification Script

# Comprehensive check of all installed tools and system resources

``` bash
# Verify complete environment
./scripts/verify.sh
```

This script checks: - Tool versions and functionality - System resource
availability\
- Docker daemon status - Network connectivity - Project file structure

\[\[ADD IMAGE: Verification script output showing all green
checkmarks\]\]

##  Checkpoint

Your environment is ready when: -  All 7 tools show version numbers
without errors -  Docker daemon is running and accessible\
-  At least 4GB RAM and 10GB disk space available -  Project
repository cloned and structure verified -  `docker run hello-world`
completes successfully -  `make help` displays available commands

## Troubleshooting Common Issues

### Issue: Docker Permission Errors

**Symptom:**

``` bash
docker: permission denied while trying to connect to the Docker daemon
```

**Cause**: User not in docker group (Linux) or Docker Desktop not
running (macOS)

**Fix for Linux:**

#  Linux Docker Permission Fix

# Add user to docker group and apply changes

``` bash
sudo usermod -aG docker $USER
newgrp docker
# Test: docker run hello-world
```

**Fix for macOS:**

#  macOS Docker Desktop Fix

# Start Docker Desktop application

``` bash
# Ensure Docker Desktop is running
open -a Docker
# Wait for Docker Desktop to start completely
```

### Issue: kubectl Command Not Found

**Symptom:**

``` bash
kubectl: command not found
```

**Cause**: kubectl not in PATH or not installed correctly

**Fix:**

#  kubectl Installation Fix

# Reinstall kubectl if command not found

``` bash
# Check if kubectl exists
which kubectl

# If not found, reinstall
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
rm kubectl

# Verify installation
kubectl version --client
```

### Issue: Insufficient System Resources

**Symptom:** - Docker containers fail to start - System becomes
unresponsive - "No space left on device" errors

**Diagnosis:**

#  Resource Usage Diagnosis

# Check system memory, disk, and Docker resource consumption

``` bash
# Check memory usage
free -h

# Check disk usage
df -h

# Check Docker resource usage
docker system df
```

**Fix:**

#  System Resource Cleanup

# Clean Docker system and optimize resource usage

``` bash
# Clean Docker system
docker system prune -a --volumes

# Close unnecessary applications
# Consider increasing VM memory allocation if using Docker Desktop
```

### Issue: k3d Cluster Creation Fails

**Symptom:**

``` bash
ERRO[0000] Failed to create cluster 'dev-cluster'
```

**Cause**: Docker not running or port conflicts

**Fix:**

#  k3d Cluster Creation Fix

# Resolve Docker and port conflicts for cluster creation

``` bash
# Ensure Docker is running
docker info

# Check for port conflicts
lsof -i :8080
lsof -i :8090

# Delete existing cluster if any
k3d cluster delete dev-cluster

# Retry cluster creation
k3d cluster create dev-cluster --port "8080:80@loadbalancer" --port "8090:443@loadbalancer"
```

## Reset Procedures

If you need to start over completely:

#  Complete Environment Reset

# Nuclear option to clean all installations and start fresh

``` bash
# Remove all Docker containers and images
docker system prune -a --volumes

# Remove k3d clusters
k3d cluster delete --all

# Clean Helm repositories
helm repo list
helm repo remove <repo-name>

# For complete reset on macOS
brew uninstall docker docker-compose kubectl k3d helm nodejs jq
# Reinstall with original commands
```

## Performance Optimization

### macOS Docker Desktop Settings

**Recommended Settings:** - **Memory**: 4-6GB (depending on system
RAM) - **CPU**: 2-4 cores - **Disk Image Size**: 32GB+ - **Enable
VirtioFS**: For better file sharing performance

### Linux Resource Limits

#  Linux Resource Optimization

# Increase system limits for container workloads

``` bash
# Increase container limits if needed
echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

## Domain Configuration (CRITICAL)

### Step 6: Configure Your Domain

** IMPORTANT**: This project uses `gameapp.games` as an example
domain. You MUST replace it with your own domain before proceeding.

**Option A: Use Your Own Domain**

``` bash
# If you have a domain (e.g., myapp.com), replace all instances:
# gameapp.games  myapp.com
# app.gameapp.games  app.myapp.com
# prometheus.gameapp.games  prometheus.myapp.com
```

**Option B: Get a Free Domain**

``` bash
# Free domain options:
# 1. Freenom (.tk, .ml, .ga domains)
# 2. Duck DNS (duckdns.org)
# 3. No-IP (noip.com)
# 4. Use localhost for testing (not recommended for production)
```

**Option C: Use Localhost (Testing Only)**

``` bash
# Add to /etc/hosts (macOS/Linux) or C:\Windows\System32\drivers\etc\hosts (Windows)
echo "127.0.0.1 gameapp.local" | sudo tee -a /etc/hosts
echo "127.0.0.1 prometheus.gameapp.local" | sudo tee -a /etc/hosts
echo "127.0.0.1 grafana.gameapp.local" | sudo tee -a /etc/hosts
echo "127.0.0.1 argocd.gameapp.local" | sudo tee -a /etc/hosts
```

### Step 7: Domain Replacement Checklist

**Files that need domain updates:**

``` bash
# Core application files
k8s/ingress.yaml                    # Lines 15, 59, 122, 123, 146, 156, 185, 198
k8s/monitoring-ingress.yaml         # Lines 12, 25, 38, 51
k8s/tunnel-ingress.yaml            # Lines 15, 28, 41, 54
k8s/unified-ingress.yaml           # Lines 15, 28, 41, 54, 67, 80, 93, 106

# Configuration files
k8s/configmap.yaml                 # Lines 8, 12, 16, 20
k8s/frontend-config.yaml           # Lines 8, 12, 16, 20

# Scripts
scripts/verify.sh                  # Lines 45, 48, 51, 54
scripts/test-traffic.sh            # Lines 8, 12, 16, 20
scripts/production-metrics-test.sh # Lines 8, 12, 16, 20

# Documentation
docs/07-global.md                  # Multiple references
docs/cloudflare-tunnel-setup-guide.md # Multiple references
```

**Quick domain replacement script:**

#  Domain Replacement Script

# Automated script to replace example domain with your actual domain

``` bash
# Replace domain in all files (replace YOUR_DOMAIN with your actual domain)
find . -type f \( -name "*.yaml" -o -name "*.yml" -o -name "*.sh" -o -name "*.md" \) \
  -exec sed -i 's/gameapp\.games/YOUR_DOMAIN/g' {} \;
```

**\[TODO\]** Add automated domain replacement script to repository

## What You Learned

You've successfully set up a complete DevOps development environment: -
**Container Runtime**: Docker for application packaging and deployment -
**Kubernetes Tools**: kubectl and k3d for container orchestration -
**Package Management**: Helm for Kubernetes application distribution -
**Development Tools**: Node.js and jq for automation and scripting -
**System Verification**: Comprehensive environment validation -
**Troubleshooting Skills**: Diagnostic procedures for common issues -
**Domain Configuration**: Critical setup for production deployment

This environment mirrors what professional DevOps engineers use daily.
You now have the foundation to build production-grade applications.

------------------------------------------------------------------------

**Next**: [Chapter 4: Local Multi-Container
Development](04-local-compose.md) - Build and test your application
locally with Docker Compose **Previous**: [Chapter 2: Architecture
Overview](02-architecture.md) - Understanding the complete system design

# Chapter 4: Local Multi-Container Development

*Build and test your application stack locally with Docker Compose*

------------------------------------------------------------------------

## What You'll Learn

- Multi-service application deployment with Docker Compose
- Container networking and service communication
- Database and cache integration patterns
- Application health verification and debugging techniques

## Time Required: 40 minutes

## Prerequisites: [Chapter 3: Environment Setup](03-env-setup.md)

------------------------------------------------------------------------

## Why This Matters

Docker Compose is your safety net before Kubernetes deployment. It
allows you to test your complete application stack locally, identifying
configuration issues, service dependencies, and networking problems
before they become expensive production problems.

**Professional Context**: Senior engineers always validate applications
locally before deploying to shared environments. This practice prevents
disrupting team productivity and demonstrates operational maturity.

** Pro Tip**: If your application doesn't work in Docker Compose, it
won't work in Kubernetes. This chapter catches 80% of deployment issues
before they reach production.

## Understanding the Application Stack

Before starting, understand what you're deploying:

#  Docker Compose Application Stack

# Multi-service architecture with frontend, backend, database, and cache

                         Docker Compose Stack                    
    
      Frontend (nginx:80)  Backend (Node.js:3001)             
                                                                
      PostgreSQL (5432)  Redis Cache (6379)                   

**Service Dependencies:** 1. **PostgreSQL**: Must start first
(persistent data) 2. **Redis**: Starts in parallel with PostgreSQL
(cache layer) 3. **Backend**: Waits for database health checks 4.
**Frontend**: Starts after backend is ready

## Build and Deploy Application Stack

### Step 1: Examine the Configuration

First, understand your Docker Compose configuration:

#  Docker Compose Configuration Review

# Examine the multi-service application configuration

``` bash
# Navigate to project directory
cd DevOps-Home-Lab-2025

# Examine the compose file structure
cat docker-compose.yml | head -20
```

**Expected Output:**

#  Docker Compose Services Configuration

# PostgreSQL service definition with environment variables and volumes

``` yaml
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

** Editor Note**: The compose file uses environment variable defaults
(e.g., `${DB_PASSWORD:-gamepass123}`) which is a production-ready
pattern for configuration management.

### Step 2: Build Application Images

#  Container Image Build

# Build all application images from source code

``` bash
# Build all container images from source
docker-compose build --no-cache
```

**Expected Output:**

#  Docker Build Process Output

# Successful build of backend and frontend container images

``` bash
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

\[\[ADD IMAGE: Docker build output showing successful image creation\]\]

### Step 3: Start the Complete Stack

#  Start Docker Compose Stack

# Launch all services in detached mode

``` bash
# Start all services in detached mode
docker-compose up -d
```

**Expected Output:**

#  Docker Compose Startup Output

# Successful creation of networks, volumes, and containers

``` bash
Creating network "devops-home-lab-2025_backend-network" ... done
Creating network "devops-home-lab-2025_frontend-network" ... done
Creating volume "devops-home-lab-2025_postgres_data" ... done
Creating volume "devops-home-lab-2025_redis_data" ... done
Creating devops-home-lab-2025_postgres_1 ... done
Creating devops-home-lab-2025_redis_1 ... done
Creating devops-home-lab-2025_backend_1 ... done
Creating devops-home-lab-2025_frontend_1 ... done
```

#  Service Initialization Wait

# Allow time for database and services to start properly

``` bash
# Wait for database initialization (important!)
echo "Waiting for services to initialize..."
sleep 30

# Check service status
docker-compose ps
```

**Expected Output:**

#  Docker Compose Service Status

# All services running with proper health checks

``` bash
NAME                            IMAGE                              STATUS                    PORTS
devops-home-lab-2025_postgres_1 postgres:15-alpine                Up 2 minutes             5432/tcp
devops-home-lab-2025_redis_1    redis:7-alpine                    Up 2 minutes             6379/tcp
devops-home-lab-2025_backend_1  devops-home-lab-2025-backend      Up 1 minute              0.0.0.0:3001->3001/tcp
devops-home-lab-2025_frontend_1 devops-home-lab-2025-frontend     Up 1 minute (healthy)    0.0.0.0:3000->80/tcp
```

** Important**: The `(healthy)` status for frontend indicates Docker
health checks are passing. This is a production-ready pattern you'll
implement in Kubernetes.

## Verify Application Functionality

### Step 1: Test Backend API Health

#  Backend Health Check Test

# Verify backend API health endpoint is responding

``` bash
# Test backend health endpoint
curl -s http://localhost:3001/api/health | jq .
```

**Expected Output:**

#  Backend Health Response

# JSON response confirming all services are healthy

``` json
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

** Pro Tip**: The health endpoint checks database and Redis
connectivity. This same pattern will be used for Kubernetes readiness
probes.

### Step 2: Test Database Connectivity

#  Database Connection Test

# Verify PostgreSQL database is accessible and responding

``` bash
# Test direct database connection
docker-compose exec postgres psql -U gameuser -d humor_memory_game -c "SELECT version();"
```

**Expected Output:**

#  PostgreSQL Version Check

# Confirmation of database version and connectivity

``` bash
                                                             version
----------------------------------------------------------------------------------------------------------------
 PostgreSQL 15.4 on x86_64-pc-linux-gnu, compiled by gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924, 64-bit
(1 row)
```

#  Database Schema Verification

# Check that all required tables exist in the database

``` bash
# Verify database schema
docker-compose exec postgres psql -U gameuser -d humor_memory_game -c "\dt"
```

**Expected Output:**

#  Database Tables List

# Confirmation of all application tables in PostgreSQL

``` bash
               List of relations
 Schema |     Name      | Type  |  Owner
--------+---------------+-------+----------
 public | game_sessions | table | gameuser
 public | leaderboard   | table | gameuser
 public | users         | table | gameuser
(3 rows)
```

### Step 3: Test Redis Cache

#  Redis Cache Test

# Verify Redis connectivity and authentication

``` bash
# Test Redis connectivity and authentication
docker-compose exec redis redis-cli -a gamepass123 ping
```

**Expected Output:**

#  Redis Ping Response

# Confirmation that Redis cache is responding

``` bash
PONG
```

#  Redis Cache Operations Test

# Test basic set and get operations in Redis

``` bash
# Test cache operations
docker-compose exec redis redis-cli -a gamepass123 set test-key "Hello Docker Compose"
docker-compose exec redis redis-cli -a gamepass123 get test-key
```

**Expected Output:**

#  Redis Cache Operations Output

# Successful set and get operations confirmation

``` bash
OK
"Hello Docker Compose"
```

### Step 4: Test Frontend Application

Open your web browser and navigate to `http://localhost:3000`:

** Verification Checklist:** -  Game interface loads with "Humor
Memory Game" title -  Username input field accepts text - 
Difficulty selection dropdown works -  "Start Game" button is
clickable and responsive -  No JavaScript errors in browser console
(F12  Console)

\[\[ADD IMAGE: Browser screenshot showing the Humor Memory Game
interface\]\]

#  Frontend Static Content Test

# Verify frontend is serving HTML content correctly

``` bash
# Test frontend static content delivery
curl -s http://localhost:3000 | grep -o "<title>.*</title>"
```

**Expected Output:**

#  Frontend HTML Title

# Confirmation that frontend is serving the correct HTML

``` html
<title>Humor Memory Game</title>
```

## Test Complete User Workflow

### Step 1: Test User Registration

#  User Registration API Test

# Test the complete user registration workflow

``` bash
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

#  User Registration Response

# Successful user creation with database persistence

``` json
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

#  Game Session Creation Test

# Test starting a new game session with difficulty selection

``` bash
# Test game session creation
curl -X POST http://localhost:3001/api/game/start \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "difficulty": "easy"
  }' | jq .
```

**Expected Output:**

#  Game Session Response

# Successful game session creation with card data

``` json
{
  "success": true,
  "session_id": "sess_1234567890",
  "game_config": {
    "difficulty": "easy",
    "grid_size": "4x4",
    "time_limit": null
  },
  "cards": ["", "", "", "", "", "", "", ""]
}
```

### Step 3: Test Leaderboard

#  Leaderboard API Test

# Test the leaderboard endpoint for game statistics

``` bash
# Test leaderboard endpoint
curl -s http://localhost:3001/api/leaderboard | jq .
```

**Expected Output:**

#  Leaderboard Response

# Game statistics and rankings from the database

``` json
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

#  Backend Environment Verification

# Check that all environment variables are properly configured

``` bash
# Verify backend environment configuration
docker-compose exec backend env | grep -E "(DB_|REDIS_|NODE_ENV|PORT)"
```

**Expected Output:**

#  Backend Environment Variables

# Confirmation of all database and Redis connection settings

``` bash
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

#  Container Networking Test

# Verify inter-container communication is working

``` bash
# Test container-to-container networking
docker-compose exec backend ping -c 3 postgres
docker-compose exec backend ping -c 3 redis
```

**Expected Output:**

``` bash
PING postgres (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.123 ms
64 bytes from 172.18.0.2: seq=1 ttl=64 time=0.089 ms
64 bytes from 172.18.0.2: seq=2 ttl=64 time=0.095 ms
```

** Editor Note**: Docker Compose automatically creates a bridge
network where services can communicate using their service names as
hostnames. This same principle applies to Kubernetes service discovery.

## Performance and Resource Monitoring

### Step 1: Monitor Resource Usage

``` bash
# Check container resource usage
docker stats --no-stream
```

**Expected Output:**

``` bash
CONTAINER ID   NAME                              CPU %     MEM USAGE / LIMIT   MEM %     NET I/O       BLOCK I/O   PIDS
abc123def456   devops-home-lab-2025_frontend_1   0.01%     3.2MiB / 1.944GiB   0.16%     1.23kB / 0B   0B / 0B     3
def456ghi789   devops-home-lab-2025_backend_1    1.50%     45.1MiB / 1.944GiB  2.27%     15.2kB / 0B   0B / 0B     11
ghi789jkl012   devops-home-lab-2025_postgres_1   0.25%     25.3MiB / 1.944GiB  1.27%     8.45kB / 0B   0B / 8.2MB  7
jkl012mno345   devops-home-lab-2025_redis_1      0.15%     8.1MiB / 1.944GiB   0.41%     4.12kB / 0B   0B / 0B     4
```

### Step 2: Check Application Logs

``` bash
# View backend application logs
docker-compose logs backend --tail=20
```

**Expected Output:**

#  Backend Application Logs

# Successful startup sequence with all service connections

``` bash
backend_1   | 2025-01-15T10:30:00.123Z [INFO] Starting Humor Memory Game Backend
backend_1   | 2025-01-15T10:30:00.234Z [INFO] Connecting to PostgreSQL at postgres:5432
backend_1   | 2025-01-15T10:30:01.345Z [INFO] Database connected successfully
backend_1   | 2025-01-15T10:30:01.456Z [INFO] Connecting to Redis at redis:6379
backend_1   | 2025-01-15T10:30:01.567Z [INFO] Redis connected successfully
backend_1   | 2025-01-15T10:30:01.678Z [INFO] Server listening on port 3001
backend_1   | 2025-01-15T10:30:01.789Z [INFO] Health check endpoint available at /api/health
```

##  Checkpoint

Your Docker Compose stack is working correctly when: -  All 4
containers show "Up" status in `docker-compose ps` -  Backend health
check returns `{"status": "healthy"}` -  Frontend loads at
`http://localhost:3000` without errors -  Database accepts connections
and shows expected schema -  Redis responds to ping and cache
operations -  Container resource usage is reasonable (\< 100MB per
service) -  Application logs show successful service connections

## Troubleshooting Common Issues

### Issue: Services Won't Start

**Symptom:**

``` bash
ERROR: for postgres  Cannot start service postgres: driver failed programming external connectivity
```

**Cause**: Port conflicts with existing services

**Diagnosis:**

#  Port Conflict Diagnosis

# Check which processes are using required ports

``` bash
# Check what's using the ports
lsof -i :3000  # Frontend port
lsof -i :3001  # Backend port
lsof -i :5432  # PostgreSQL port
lsof -i :6379  # Redis port
```

**Fix:**

#  Port Conflict Resolution

# Stop conflicting services or modify port mappings

``` bash
# Stop conflicting services or change ports in docker-compose.yml
# Example: Change frontend port
# ports:
#   - "3001:80"  # Changed from 3000:80
```

### Issue: Database Connection Fails

**Symptom:**

``` bash
backend_1   | Error: connect ECONNREFUSED postgres:5432
```

**Cause**: Backend starting before PostgreSQL is ready

**Diagnosis:**

#  Database Connection Diagnosis

# Check PostgreSQL logs and connection status

``` bash
# Check PostgreSQL logs
docker-compose logs postgres

# Check if PostgreSQL is accepting connections
docker-compose exec postgres pg_isready -U gameuser
```

**Fix:**

#  Database Connection Fix

# Wait for database initialization and restart backend

``` bash
# Wait longer for database initialization
sleep 60
docker-compose restart backend

# Or add depends_on with health checks (already configured)
```

### Issue: Frontend Shows Connection Errors

**Symptom**: Browser console shows "Failed to fetch" errors

**Cause**: Backend API not accessible or CORS issues

**Diagnosis:**

#  Frontend Connection Diagnosis

# Test backend connectivity and check for CORS issues

``` bash
# Test backend directly
curl http://localhost:3001/api/health

# Check backend logs for CORS errors
docker-compose logs backend | grep -i cors
```

**Fix:**

#  Frontend Connection Fix

# Restart backend and verify configuration

``` bash
# Verify backend is running and accessible
docker-compose ps backend
docker-compose restart backend

# Check frontend configuration points to correct backend URL
```

### Issue: Memory or Performance Problems

**Symptom**: Containers consuming excessive resources

**Diagnosis:**

#  Performance Problem Diagnosis

# Monitor resource usage and check for memory issues

``` bash
# Monitor resource usage
docker stats --no-stream

# Check for memory leaks in logs
docker-compose logs backend | grep -i "memory\|leak\|out of memory"
```

**Fix:**

#  Performance Optimization Fix

# Add resource limits to prevent excessive resource usage

``` bash
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

#  Graceful Service Shutdown

# Stop all Docker Compose services cleanly

``` bash
# Stop all services gracefully
docker-compose down
```

**Expected Output:**

#  Graceful Shutdown Output

# Confirmation of clean service termination

``` bash
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

#  Complete Environment Reset

# Nuclear option to remove all containers, volumes, and images

``` bash
# Remove everything including volumes (data loss!)
docker-compose down -v --remove-orphans

# Remove built images
docker-compose down --rmi all

# Clean up Docker system
docker system prune -f
```

** Warning**: The `-v` flag removes persistent volumes, deleting all
database data.

## What You Learned

You've successfully deployed and tested a complete multi-service
application:

**Technical Skills:** - **Multi-container orchestration** with Docker
Compose - **Service networking** and inter-container communication -
**Database integration** with connection pooling and health checks -
**Cache layer implementation** with Redis - **Health monitoring** and
application verification - **Resource monitoring** and performance
analysis

**Production Patterns:** - **Environment variable configuration** for
different deployment contexts - **Health check implementation** for
service readiness - **Graceful shutdown procedures** for clean service
termination - **Logging best practices** for debugging and monitoring -
**Network isolation** with dedicated bridges for security

**Troubleshooting Skills:** - **Systematic diagnosis** of container and
networking issues - **Log analysis** for identifying service problems -
**Resource monitoring** for performance optimization - **Port conflict
resolution** and service configuration

This local deployment serves as your baseline. Every configuration and
pattern you've implemented here will translate directly to Kubernetes
deployment with additional orchestration features.

------------------------------------------------------------------------

**Next**: [Chapter 5: Kubernetes Basics](05-kubernetes-basics.md) -
Deploy your application to a production-ready Kubernetes cluster
**Previous**: [Chapter 3: Environment Setup](03-env-setup.md) -
Installing and configuring your development environment

# Chapter 5: Kubernetes Basics - Your First Deployment

*Deploy your application to a production-ready Kubernetes cluster using
declarative manifests*

------------------------------------------------------------------------

## What You'll Learn

- Create and manage a local Kubernetes cluster with k3d
- Deploy multi-service applications using Kubernetes manifests
- Configure persistent storage for databases
- Implement health checks and resource management
- Use Kustomize for configuration management

## Time Required: 60 minutes

## Prerequisites: [Chapter 4: Local Multi-Container Development](04-local-compose.md)

------------------------------------------------------------------------

## Why This Matters

Kubernetes is the industry standard for deploying applications at scale.
Companies like Netflix, Airbnb, and GitHub use Kubernetes to manage
thousands of services serving millions of users. Learning Kubernetes
deployment patterns is essential for any DevOps engineer.

**Career Impact**: Kubernetes skills are in high demand. DevOps
engineers with Kubernetes experience earn 20-30% more than those without
it, and 88% of enterprises use Kubernetes for container orchestration.

** Pro Tip**: Kubernetes is like a smart manager for your
applications. It automatically handles scaling, health checks, and
updates while ensuring your services stay running reliably.

## Understanding Kubernetes vs Docker Compose

Before deploying, understand the key differences:

  Aspect              Docker Compose        Kubernetes
  ------------------- --------------------- ---------------------------
  **Scope**           Single machine        Multi-machine cluster
  **Networking**      Bridge networks       Pod networking + Services
  **Storage**         Bind mounts/volumes   Persistent Volumes
  **Scaling**         Manual                Automatic with HPA
  **Health Checks**   Basic health checks   Liveness/Readiness probes
  **Configuration**   Environment files     ConfigMaps and Secrets

## Create Kubernetes Cluster

### Step 1: Create Local k3d Cluster

#  Create k3d Kubernetes Cluster

# Set up a production-like local cluster with load balancer

``` bash
# Create a production-like cluster with load balancer
k3d cluster create dev-cluster \
  --servers 1 \
  --agents 2 \
  --port "8080:80@loadbalancer" \
  --port "8090:443@loadbalancer"
```

**Expected Output:**

#  k3d Cluster Creation Output

# Successful cluster creation with network and load balancer setup

``` bash
INFO[0000] Prep: Network                                
INFO[0001] Created network 'k3d-dev-cluster'           
INFO[0001] Created image volume k3d-dev-cluster-images  
INFO[0001] Starting cluster 'dev-cluster'                
INFO[0001] Starting servers...                          
INFO[0002] Starting agents...                            
INFO[0008] Updating the default kubeconfig with a new context for cluster "dev-cluster"
INFO[0008] You can now use it like this:                
kubectl cluster-info
```

** Editor Note**: The port mappings allow external access: 8080 for
HTTP traffic and 8090 for HTTPS/management interfaces.

### Step 2: Verify Cluster Health

#  Cluster Node Verification

# Check that all cluster nodes are running and ready

``` bash
# Check cluster nodes
kubectl get nodes
```

**Expected Output:**

#  Cluster Nodes Status

# Confirmation of 3-node cluster with control plane and worker nodes

``` bash
NAME                       STATUS   ROLES                  AGE   VERSION
k3d-dev-cluster-server-0   Ready    control-plane,master   2m    v1.28.2+k3s1
k3d-dev-cluster-agent-0    Ready    <none>                 2m    v1.28.2+k3s1
k3d-dev-cluster-agent-1    Ready    <none>                 2m    v1.28.2+k3s1
```

#  Cluster Components Check

# Verify all essential Kubernetes components are running

``` bash
# Verify cluster components
kubectl cluster-info
```

**Expected Output:**

#  Cluster Components Status

# Confirmation of control plane, DNS, and metrics server

``` bash
Kubernetes control plane is running at https://0.0.0.0:6443
CoreDNS is running at https://0.0.0.0:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://0.0.0.0:6443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy
```

\[\[ADD IMAGE: kubectl get nodes output showing 3-node cluster\]\]

## Build and Load Container Images

### Step 1: Build Application Images

Since k3d doesn't have access to Docker Hub images we haven't pushed,
build locally:

#  Build Application Images

# Create container images for backend and frontend services

``` bash
# Build backend image
docker build -t humor-game-backend:latest ./backend

# Build frontend image  
docker build -t humor-game-frontend:latest ./frontend
```

**Expected Output:**

#  Docker Build Process

# Successful build of backend container image

``` bash
[+] Building 23.1s (12/12) FINISHED
 => [internal] load build definition from Dockerfile               0.1s
 => [1/7] FROM docker.io/library/node:18-alpine@sha256:...         2.1s
 => [2/7] WORKDIR /app                                             0.1s
 => [3/7] COPY package*.json ./                                    0.1s
 => [4/7] RUN npm ci --only=production                            15.2s
 => [5/7] COPY . .                                                 0.3s
 => [6/7] EXPOSE 3001                                              0.1s
 => [7/7] CMD ["npm", "start"]                                     0.1s
 => => naming to docker.io/library/humor-game-backend:latest      0.0s
```

### Step 2: Load Images into k3d

#  Import Images to k3d Cluster

# Load locally built images into the Kubernetes cluster

``` bash
# Load images into k3d cluster
k3d image import humor-game-backend:latest -c dev-cluster
k3d image import humor-game-frontend:latest -c dev-cluster
```

**Expected Output:**

#  Image Import Success

# Confirmation that both images are available in the cluster

``` bash
INFO[0000] Importing image 'humor-game-backend:latest' into cluster 'dev-cluster'...
INFO[0002] Image 'humor-game-backend:latest' imported into cluster 'dev-cluster'
INFO[0002] Importing image 'humor-game-frontend:latest' into cluster 'dev-cluster'...
INFO[0004] Image 'humor-game-frontend:latest' imported into cluster 'dev-cluster'
```

## Deploy Application Using Kubernetes Manifests

### Step 1: Create Namespace and Configuration

#  Create Application Namespace

# Set up dedicated namespace for the humor game application

``` bash
# Create dedicated namespace for application
kubectl apply -f k8s/namespace.yaml
```

**Expected Output:**

#  Namespace Creation

# Confirmation of humor-game namespace creation

``` bash
namespace/humor-game created
```

#  Deploy Configuration and Secrets

# Apply ConfigMaps and Secrets for application configuration

``` bash
# Deploy configuration and secrets
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secrets.yaml
```

**Expected Output:**

#  Configuration Resources Created

# Confirmation of ConfigMaps and Secrets deployment

``` bash
configmap/humor-game-config created
configmap/frontend-config created
secret/humor-game-secrets created
```

** Important**: Ensure your `k8s/secrets.yaml` has been created from
the template with real values. This file contains database passwords and
should not be committed to Git in production.

### Step 2: Deploy Database Layer

#  Deploy PostgreSQL Database

# Deploy PostgreSQL with persistent volume for data storage

``` bash
# Deploy PostgreSQL with persistent storage
kubectl apply -f k8s/postgres.yaml
```

**Expected Output:**

#  PostgreSQL Resources Created

# Confirmation of PVC, Deployment, and Service creation

``` bash
persistentvolumeclaim/postgres-pvc created
deployment.apps/postgres created
service/postgres created
```

#  Deploy Redis Cache

# Deploy Redis with persistent storage for caching

``` bash
# Deploy Redis cache
kubectl apply -f k8s/redis.yaml
```

**Expected Output:**

#  Redis Resources Created

# Confirmation of Redis PVC, Deployment, and Service

``` bash
persistentvolumeclaim/redis-pvc created
deployment.apps/redis created
service/redis created
```

#  Wait for Database Readiness

# Ensure PostgreSQL and Redis are fully initialized before proceeding

``` bash
# Wait for databases to be ready
echo "Waiting for databases to initialize..."
kubectl wait --for=condition=Ready pods -l app=postgres -n humor-game --timeout=300s
kubectl wait --for=condition=Ready pods -l app=redis -n humor-game --timeout=300s
```

**Expected Output:**

#  Database Pods Ready

# Confirmation that PostgreSQL and Redis pods are running

``` bash
pod/postgres-7c8b9d4f6d-xyz12 condition met
pod/redis-849d7b8c5f-abc34 condition met
```

### Step 3: Deploy Application Layer

#  Deploy Backend API

# Deploy the Node.js backend service

``` bash
# Deploy backend API
kubectl apply -f k8s/backend.yaml
```

**Expected Output:**

#  Backend Resources Created

# Confirmation of backend Deployment and Service

``` bash
deployment.apps/backend created
service/backend created
```

#  Deploy Frontend Application

# Deploy the nginx frontend service

``` bash
# Deploy frontend
kubectl apply -f k8s/frontend.yaml
```

**Expected Output:**

#  Frontend Resources Created

# Confirmation of frontend Deployment and Service

``` bash
deployment.apps/frontend created
service/frontend created
```

#  Wait for Application Readiness

# Ensure backend and frontend pods are fully ready

``` bash
# Wait for application pods to be ready
kubectl wait --for=condition=Ready pods -l app=backend -n humor-game --timeout=300s
kubectl wait --for=condition=Ready pods -l app=frontend -n humor-game --timeout=300s
```

## Verify Deployment

### Step 1: Check Pod Status

#  Check Pod Status

# Verify all application pods are running successfully

``` bash
# Check all pods in the namespace
kubectl get pods -n humor-game
```

**Expected Output:**

#  Pod Status Overview

# All application pods running with healthy status

``` bash
NAME                        READY   STATUS    RESTARTS   AGE
postgres-7c8b9d4f6d-xyz12   1/1     Running   0          5m
redis-849d7b8c5f-abc34      1/1     Running   0          5m
backend-6d7f8b9c4e-def56    1/1     Running   0          3m
frontend-5a6b7c8d9e-ghi78   1/1     Running   0          3m
```

** Success Criteria**: All pods show `1/1 Running` status with 0 or
minimal restarts.

### Step 2: Check Services

#  Check Service Status

# Verify all services are created and have ClusterIP addresses

``` bash
# Verify services are created
kubectl get services -n humor-game
```

**Expected Output:**

#  Service Status Overview

# All services created with ClusterIP addresses for internal communication

``` bash
NAME       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
postgres   ClusterIP   10.43.123.45    <none>        5432/TCP   5m
redis      ClusterIP   10.43.234.56    <none>        6379/TCP   5m
backend    ClusterIP   10.43.345.67    <none>        3001/TCP   3m
frontend   ClusterIP   10.43.456.78    <none>        80/TCP     3m
```

### Step 3: Check Persistent Storage

#  Check Persistent Storage

# Verify PVCs are bound to persistent volumes

``` bash
# Verify persistent volumes are bound
kubectl get pvc -n humor-game
```

**Expected Output:**

#  Persistent Volume Claims Status

# Confirmation that PVCs are bound to local-path storage

``` bash
NAME           STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
postgres-pvc   Bound    pvc-12345678-abcd-efgh-ijkl-123456789012   5Gi        RWO            local-path     5m
redis-pvc      Bound    pvc-87654321-zyxw-vutr-qpon-098765432109   1Gi        RWO            local-path     5m
```

## Test Application Functionality

### Step 1: Test Backend Health

#  Test Backend Health Endpoint

# Port-forward to backend and test health check

``` bash
# Port-forward to backend service
kubectl port-forward svc/backend -n humor-game 3001:3001 &

# Test health endpoint
curl -s http://localhost:3001/api/health | jq .
```

**Expected Output:**

#  Backend Health Response

# JSON response confirming all services are healthy

``` json
{
  "status": "healthy",
  "services": {
    "database": "connected",
    "redis": "connected"
  },
  "timestamp": "2025-01-15T10:30:00.000Z",
  "uptime": "00:03:45"
}
```

** Pro Tip**: The health endpoint validates both database and Redis
connectivity, which is crucial for Kubernetes readiness probes.

### Step 2: Test Database Connectivity

#  Test PostgreSQL Connection

# Verify database connectivity from within the cluster

``` bash
# Test PostgreSQL connection
kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -d humor_memory_game -c "SELECT version();"
```

**Expected Output:**

#  PostgreSQL Version Check

# Confirmation of database version and connectivity

``` bash
                                                             version
----------------------------------------------------------------------------------------------------------------
 PostgreSQL 15.4 on x86_64-pc-linux-gnu, compiled by gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924, 64-bit
(1 row)
```

#  Verify Database Schema

# Check that all required tables exist in PostgreSQL

``` bash
# Verify database schema
kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -d humor_memory_game -c "\dt"
```

**Expected Output:**

#  Database Tables List

# Confirmation of all application tables in PostgreSQL

``` bash
               List of relations
 Schema |     Name      | Type  |  Owner
--------+---------------+-------+----------
 public | game_sessions | table | gameuser
 public | leaderboard   | table | gameuser
 public | users         | table | gameuser
(3 rows)
```

### Step 3: Test Frontend Access

#  Test Frontend Access

# Port-forward to frontend and verify HTML content

``` bash
# Kill previous port-forward and start frontend
pkill -f "port-forward.*3001"
kubectl port-forward svc/frontend -n humor-game 3000:80 &

# Test frontend content
curl -s http://localhost:3000 | grep -o "<title>.*</title>"
```

**Expected Output:**

#  Frontend HTML Title

# Confirmation that frontend is serving the correct HTML

``` html
<title>Humor Memory Game</title>
```

\[\[ADD IMAGE: Browser screenshot showing game interface via
port-forward\]\]

## Understanding Kubernetes Configuration with Kustomize

### Step 1: Examine Kustomize Structure

Your project uses Kustomize for configuration management:

#  Examine Kustomize Configuration

# Review the base Kustomize configuration structure

``` bash
# View the base kustomization
cat gitops-safe/base/kustomization.yaml
```

**Expected Output:**

#  Kustomize Base Configuration

# Complete base configuration with all application resources

``` yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

metadata:
  name: humor-game-base
  namespace: humor-game

resources:
- configmap.yaml
- pvc.yaml
- postgres-deployment.yaml
- postgres-service.yaml
- redis-deployment.yaml
- redis-service.yaml
- backend-deployment.yaml
- backend-service.yaml
- frontend-deployment.yaml
- frontend-service.yaml
```

### Step 2: Test Kustomize Build

#  Test Kustomize Build

# Build the complete configuration using Kustomize

``` bash
# Build configuration with kustomize
kubectl kustomize gitops-safe/base/
```

**Expected Output:**

``` yaml
apiVersion: v1
kind: ConfigMap
metadata:
  annotations:
    gitops.argoproj.io/description: Base configuration for Humor Game
    gitops.argoproj.io/version: 1.0.0
  name: humor-game-config
  namespace: humor-game
data:
  API_PORT: "3001"
  DB_NAME: humor_memory_game
# ... more resources
```

** Editor Note**: Kustomize allows you to build different
configurations for different environments (dev, staging, prod) from the
same base manifests, which is more maintainable than using Helm
templates.

## Resource Management and Scaling

### Step 1: Check Resource Usage

``` bash
# Monitor resource consumption
kubectl top pods -n humor-game
```

**Expected Output:**

``` bash
NAME                        CPU(cores)   MEMORY(bytes)
backend-6d7f8b9c4e-def56    15m          45Mi
frontend-5a6b7c8d9e-ghi78   1m           8Mi
postgres-7c8b9d4f6d-xyz12   25m          35Mi
redis-849d7b8c5f-abc34      5m           12Mi
```

### Step 2: Examine Resource Limits

``` bash
# Check resource limits and requests
kubectl describe pod -l app=backend -n humor-game | grep -A 5 "Limits:\|Requests:"
```

**Expected Output:**

``` bash
    Limits:
      cpu:     500m
      memory:  512Mi
    Requests:
      cpu:     100m
      memory:  128Mi
```

### Step 3: Test Manual Scaling

``` bash
# Scale backend to 2 replicas
kubectl scale deployment backend --replicas=2 -n humor-game

# Verify scaling
kubectl get pods -l app=backend -n humor-game
```

**Expected Output:**

``` bash
NAME                        READY   STATUS    RESTARTS   AGE
backend-6d7f8b9c4e-def56    1/1     Running   0          10m
backend-6d7f8b9c4e-new789   1/1     Running   0          30s
```

##  Checkpoint

Your Kubernetes deployment is successful when: -  All 4 pods show
`Running` status with `1/1` ready -  All services have `ClusterIP`
assignments\
-  Persistent volumes are `Bound` and have storage allocated - 
Backend health check returns `{"status": "healthy"}` -  Database
contains expected schema (users, game_sessions, leaderboard) - 
Frontend serves HTML content with correct title -  Resource usage is
reasonable (\< 100MB per service)

## Troubleshooting Common Issues

### Issue: Pods Stuck in Pending

**Symptom:**

``` bash
NAME                        READY   STATUS    RESTARTS   AGE
backend-6d7f8b9c4e-def56    0/1     Pending   0          5m
```

**Diagnosis:**

``` bash
# Check pod events
kubectl describe pod -l app=backend -n humor-game

# Check node resources
kubectl describe nodes
```

**Common Causes:** - Insufficient cluster resources - Image pull
failures - Persistent volume issues

**Fix:**

``` bash
# Check available resources
kubectl top nodes

# Restart cluster if needed
k3d cluster stop dev-cluster
k3d cluster start dev-cluster
```

### Issue: CrashLoopBackOff

**Symptom:**

``` bash
NAME                        READY   STATUS             RESTARTS   AGE
backend-6d7f8b9c4e-def56    0/1     CrashLoopBackOff   3          5m
```

**Diagnosis:**

``` bash
# Check pod logs
kubectl logs deployment/backend -n humor-game

# Check previous container logs
kubectl logs deployment/backend -n humor-game --previous
```

**Common Causes:** - Database connection failures - Missing environment
variables - Application startup errors

**Fix:**

``` bash
# Verify database is ready
kubectl get pods -l app=postgres -n humor-game

# Check configuration
kubectl get configmap humor-game-config -n humor-game -o yaml

# Restart deployment
kubectl rollout restart deployment/backend -n humor-game
```

### Issue: Service Not Accessible

**Symptom:** Port-forward fails or returns connection errors

**Diagnosis:**

``` bash
# Check service endpoints
kubectl get endpoints -n humor-game

# Verify service selector matches pod labels
kubectl get pods -n humor-game --show-labels
kubectl describe svc backend -n humor-game
```

**Fix:**

``` bash
# Ensure labels match between service and deployment
# Check k8s/backend.yaml for selector consistency
```

## Clean Up Resources

### Graceful Cleanup

``` bash
# Stop port-forwards
pkill -f port-forward

# Delete application resources
kubectl delete namespace humor-game

# Verify cleanup
kubectl get pods -n humor-game
```

**Expected Output:**

``` bash
No resources found in humor-game namespace.
```

### Complete Cluster Reset

``` bash
# Delete entire cluster if needed
k3d cluster delete dev-cluster

# Recreate for fresh start
k3d cluster create dev-cluster \
  --servers 1 \
  --agents 2 \
  --port "8080:80@loadbalancer" \
  --port "8090:443@loadbalancer"
```

## What You Learned

You've successfully deployed a production-ready application to
Kubernetes:

**Kubernetes Fundamentals:** - **Cluster Management**: Created and
managed multi-node k3d cluster - **Resource Deployment**: Applied
manifests for namespaces, deployments, services - **Persistent
Storage**: Configured PVCs for database persistence - **Configuration
Management**: Used ConfigMaps and Secrets for environment variables -
**Networking**: Implemented service discovery and internal communication

**Production Patterns:** - **Health Checks**: Implemented readiness and
liveness probes - **Resource Limits**: Configured CPU and memory
constraints - **Image Management**: Built and loaded custom application
images - **Scaling**: Manual replica scaling for high availability -
**Security**: Namespace isolation and proper secret handling

**Configuration Management:** - **Kustomize**: Declarative configuration
management for different environments - **GitOps Ready**: Structure that
supports automated deployment workflows - **Environment Separation**:
Base configurations with overlay capabilities

**Operational Skills:** - **Troubleshooting**: Systematic diagnosis of
pod and service issues - **Monitoring**: Resource usage tracking and
performance analysis - **Debugging**: Log analysis and event inspection
techniques

This Kubernetes deployment provides the foundation for production
operations. You now understand how applications run in orchestrated
environments and can manage complex, multi-service systems reliably.

------------------------------------------------------------------------

**Next**: [Chapter 6: Production Networking and
Ingress](06-ingress-networking.md) - Make your application accessible
from the internet **Previous**: [Chapter 4: Local Multi-Container
Development](04-local-compose.md) - Testing your application stack
locally

# Chapter 6: Production Networking and Ingress

*Make your application accessible from the internet with
production-grade networking*

------------------------------------------------------------------------

## What You'll Learn

- Deploy and configure NGINX Ingress Controller
- Set up domain-based routing for your application
- Implement SSL/TLS termination and security headers
- Configure load balancing and traffic management
- Test production networking patterns

## Time Required: 45 minutes

## Prerequisites: [Chapter 5: Kubernetes Basics](05-kubernetes-basics.md)

------------------------------------------------------------------------

## Why This Matters

Kubernetes services by default are only accessible within the cluster.
Ingress controllers act as the gateway that routes external traffic to
your applications. Understanding ingress is crucial because it's how
users actually reach your application in production.

**Professional Context**: Every production Kubernetes deployment uses
ingress controllers. They handle SSL termination, load balancing, and
traffic routing - critical functions for any web application.

## Understanding Kubernetes Networking

### Service Types Overview

``` bash
# ClusterIP (default): Internal cluster access only
# NodePort: Access via node IP and port (limited, not production)
# LoadBalancer: Cloud provider load balancer (expensive)
# Ingress: Layer 7 routing with SSL, domains, paths (production choice)
```

### Current Application Network Architecture

    Internet  Ingress Controller  Services  Pods
                                            
       HTTPS    Load Balancer    Internal    Application
       Port 443  + SSL Termination  ClusterIP  Containers

## Deploy NGINX Ingress Controller

### Step 1: Install NGINX Ingress

#  Add NGINX Ingress Helm Repository

# Add and update the official NGINX Ingress Controller repository

``` bash
# Add NGINX ingress helm repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

**Expected Output:**

#  Helm Repository Update

# Confirmation of NGINX Ingress repository addition and update

``` bash
"ingress-nginx" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "ingress-nginx" chart repository
Update Complete. Happy Helming!
```

#  Install NGINX Ingress Controller

# Deploy NGINX Ingress Controller with LoadBalancer service

``` bash
# Install NGINX ingress controller
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --set controller.service.type=LoadBalancer \
  --set controller.service.loadBalancerIP="" \
  --wait
```

**Expected Output:**

#  NGINX Ingress Installation

# Successful deployment of NGINX Ingress Controller

``` bash
Release "ingress-nginx" does not exist. Installing it now.
NAME: ingress-nginx
LAST DEPLOYED: 2025-01-15T10:30:00Z
NAMESPACE: ingress-nginx
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

** Pro Tip**: k3d automatically maps ports 8080:80 and 8090:443 from
your cluster to localhost, so the LoadBalancer will be accessible on
these ports.

### Step 2: Verify Ingress Controller

#  Verify Ingress Controller Pods

# Check that NGINX Ingress Controller pods are running

``` bash
# Check ingress controller pods
kubectl get pods -n ingress-nginx
```

**Expected Output:**

#  Ingress Controller Pod Status

# Confirmation that NGINX Ingress Controller is running

``` bash
NAME                                        READY   STATUS    RESTARTS   AGE
ingress-nginx-controller-7844b9db77-xyz12   1/1     Running   0          2m
```

#  Check Ingress Controller Service

# Verify LoadBalancer service configuration

``` bash
# Check ingress controller service
kubectl get svc -n ingress-nginx
```

**Expected Output:**

#  Ingress Controller Services

# LoadBalancer and admission webhook services configuration

``` bash
NAME                                 TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
ingress-nginx-controller             LoadBalancer   10.43.123.45    172.18.0.2    80:30080/TCP,443:30443/TCP   2m
ingress-nginx-controller-admission   ClusterIP      10.43.234.56    <none>        443/TCP                      2m
```

## Configure Application Ingress

### Step 3: Create Ingress Resource

#  Create Application Ingress Resource

# Define ingress rules for frontend and backend services

``` bash
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

#  Apply Ingress Configuration

# Deploy the ingress resource to the cluster

``` bash
# Apply the ingress resource
kubectl apply -f k8s/ingress.yaml
```

**Expected Output:**

#  Ingress Resource Created

# Confirmation of ingress resource deployment

``` bash
ingress.networking.k8s.io/humor-game-ingress created
```

#  Verify Ingress Status

# Check that ingress is created and has an address

``` bash
# Verify ingress is created
kubectl get ingress -n humor-game
```

**Expected Output:**

#  Ingress Status Overview

# Confirmation of ingress with LoadBalancer address

``` bash
NAME                  CLASS   HOSTS                    ADDRESS      PORTS   AGE
humor-game-ingress    nginx   gameapp.local,localhost  172.18.0.2   80      1m
```

### Step 5: Configure Local DNS (Optional)

For local testing with `gameapp.local`:

#  Configure Local DNS Resolution

# Add local domain mapping for testing

``` bash
# Add entry to /etc/hosts (macOS/Linux)
echo "127.0.0.1 gameapp.local" | sudo tee -a /etc/hosts

# Or for Windows, edit C:\Windows\System32\drivers\etc\hosts
# Add: 127.0.0.1 gameapp.local
```

## Test Application Access

### Step 6: Test HTTP Access

#  Test HTTP Access via Ingress

# Test backend API through ingress controller

``` bash
# Test via localhost
curl -H "Host: localhost" http://localhost:8080/api/health
```

**Expected Output:**

#  Backend Health via Ingress

# Successful API response through ingress controller

``` json
{
  "status": "healthy",
  "services": {
    "database": "connected",
    "redis": "connected"
  },
  "timestamp": "2025-01-15T10:30:00.000Z"
}
```

#  Test Custom Domain Access

# Test API access using custom domain name

``` bash
# Test via gameapp.local (if configured)
curl http://gameapp.local:8080/api/health
```

#  Test Frontend Access via Ingress

# Verify frontend is accessible through ingress controller

``` bash
# Test frontend access
curl -s http://localhost:8080 | grep -o "<title>.*</title>"
```

**Expected Output:**

#  Frontend HTML via Ingress

# Confirmation that frontend is served through ingress

``` html
<title>Humor Memory Game</title>
```

### Step 7: Test in Browser

Open your browser and navigate to: - `http://localhost:8080` - Should
show the game interface - `http://localhost:8080/api/health` - Should
show health status - `http://gameapp.local:8080` (if configured) -
Should work the same

\[\[ADD IMAGE: Browser showing the game interface accessible via
ingress\]\]

## Configure Advanced Ingress Features

### Step 8: Add Rate Limiting

#  Add Rate Limiting to Ingress

# Configure NGINX rate limiting for API protection

``` bash
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

#  Add Security Headers to Ingress

# Configure security headers for enhanced protection

``` bash
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

#  Test Rate Limiting

# Verify rate limiting is working by making multiple requests

``` bash
# Test rate limiting (make many requests quickly)
for i in {1..10}; do
  curl -w "Status: %{http_code}\n" -o /dev/null -s http://localhost:8080/api/health
done
```

#  Test Security Headers

# Verify security headers are being sent by ingress

``` bash
# Test security headers
curl -I http://localhost:8080
```

**Expected Output:**

#  Security Headers Response

# Confirmation of security headers in HTTP response

``` bash
HTTP/1.1 200 OK
Date: Tue, 15 Jan 2025 10:30:00 GMT
Content-Type: text/html
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
```

## Global Access with Cloudflare Tunnels

### Step 11: Set Up Cloudflare Tunnel (Production)

** What is Cloudflare Tunnel?** Cloudflare Tunnels create a secure
connection from your local machine to Cloudflare's global network,
allowing anyone worldwide to access your application without exposing
your local network to the internet.

**Think of it like:** A secure tunnel that connects your local
development server to the world through Cloudflare's global network.

**Prerequisites:** - **Cloudflare Account**: Free account at
[cloudflare.com](https://cloudflare.com) - **Domain**: Any domain you
own (or use a free subdomain service) - **Zero Trust**: Enable in
Cloudflare dashboard (free tier available) - **`cloudflared` CLI**:
Command-line tool for tunnel management

**Install cloudflared:**

#  Install Cloudflare Tunnel CLI

# Install cloudflared for tunnel management

``` bash
# macOS
brew install cloudflare/cloudflare/cloudflared

# Linux
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin/
```

**Authenticate with Cloudflare:**

#  Cloudflare Authentication

# Login to Cloudflare and download certificates

``` bash
# Login to Cloudflare
cloudflared tunnel login

# This opens browser for authentication
# Select your domain (e.g., gameapp.games)
# Downloads certificate to ~/.cloudflared/
```

** What happens during authentication:** 1. **Browser opens** to
Cloudflare login page 2. **Select your domain** from the list (this
authorizes the tunnel) 3. **Certificate downloads** to `~/.cloudflared/`
folder 4. **Tunnel is authorized** to create connections for your domain

**Create tunnel:**

#  Create Cloudflare Tunnel

# Create a new tunnel for secure access

``` bash
# Create tunnel
cloudflared tunnel create gameapp-tunnel

# Output: Tunnel gameapp-tunnel created with ID: [TUNNEL_ID]
# Save the ID for configuration
```

** Understanding the tunnel creation:** - **Tunnel name**:
`gameapp-tunnel` (you can choose any name) - **Tunnel ID**: A unique
identifier (like `abc123-def456-ghi789`) - **Credentials file**:
`~/.cloudflared/[TUNNEL_ID].json` (contains authentication keys) -
**Purpose**: This tunnel will route traffic from the internet to your
local services

**Configure tunnel:**

#  Configure Cloudflare Tunnel

# Set up tunnel routing for multiple services

``` bash
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

** Understanding the configuration:** - **`tunnel`**: Name of your
tunnel (must match what you created) - **`credentials-file`**: Path to
your tunnel's authentication file - **`ingress`**: Routing rules that
map internet domains to local services - `app.gameapp.games`  Your main
application (port 8080) - `prometheus.app.gameapp.games`  Monitoring
(port 9090) - `grafana.app.gameapp.games`  Dashboards (port 3000) -
`argocd.app.gameapp.games`  GitOps (port 8090) - `http_status:404` 
Default fallback for unmatched requests

**Route tunnel:**

#  Route Tunnel DNS Records

# Create DNS records for tunnel access

``` bash
# Route tunnel to your domain
cloudflared tunnel route dns gameapp-tunnel app.gameapp.games
cloudflared tunnel route dns gameapp-tunnel prometheus.app.gameapp.games
cloudflared tunnel route dns gameapp-tunnel grafana.app.gameapp.games
cloudflared tunnel route dns gameapp-tunnel argocd.app.gameapp.games
```

** What DNS routing does:** - **Creates DNS records** in Cloudflare
for your subdomains - **Points subdomains** to your tunnel (not your
local IP) - **Enables HTTPS** automatically with Cloudflare
certificates - **Makes services accessible** from anywhere in the
world - **Example**: `app.gameapp.games` now points to your local port
8080 via the tunnel

**Run tunnel:**

#  Start Cloudflare Tunnel

# Launch tunnel for global access

``` bash
# Start tunnel (keep running)
cloudflared tunnel run gameapp-tunnel

# Or run as service
cloudflared tunnel --config ~/.cloudflared/config.yml run gameapp-tunnel
```

**Expected Output:**

``` bash
2025-01-15T10:30:00Z INF Starting tunnel tunnelID=[TUNNEL_ID]
2025-01-15T10:30:01Z INF Connection established
2025-01-15T10:30:02Z INF Route propagating
```

### Step 12: Test Global Access

``` bash
# Test global access (replace with your domain)
curl https://app.gameapp.games/api/health
curl https://prometheus.app.gameapp.games
curl https://grafana.app.gameapp.games
curl https://argocd.app.gameapp.games
```

**Expected Results:** - Application accessible globally via HTTPS -
Automatic SSL certificates from Cloudflare - DDoS protection and CDN
acceleration - No need to expose Kubernetes cluster directly

## Production Domain Configuration

### Step 13: Configure for Production Domain

For production, you would configure a real domain like `gameapp.games`:

``` yaml
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

**\[TODO\]** Add cert-manager installation and configuration for
automatic SSL certificates.

## Monitor Ingress Performance

### Step 12: Check Ingress Metrics

``` bash
# View ingress controller logs
kubectl logs -l app.kubernetes.io/name=ingress-nginx -n ingress-nginx --tail=20
```

**Expected Output:**

``` bash
2025/01/15 10:30:00 [info] 123#123: Using the pollfd connection method
2025/01/15 10:30:01 [notice] 123#123: nginx/1.21.6
2025/01/15 10:30:01 [notice] 123#123: built with OpenSSL 1.1.1q  5 Jul 2022
192.168.1.100 - - [15/Jan/2025:10:30:02 +0000] "GET /api/health HTTP/1.1" 200 156 "-" "curl/7.79.1"
```

``` bash
# Check ingress controller metrics (if metrics enabled)
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller-metrics 9090:10254 &
curl http://localhost:9090/metrics | grep nginx_ingress
```

##  Checkpoint

Your ingress networking is working when: -  NGINX ingress controller
pods are running in `ingress-nginx` namespace -  Ingress resource
shows ADDRESS assigned (usually cluster IP) - 
`curl http://localhost:8080/api/health` returns healthy status - 
Frontend is accessible at `http://localhost:8080` in browser - 
Backend API is accessible at `http://localhost:8080/api/*` -  Rate
limiting and security headers are applied -  Ingress logs show
successful requests

## Troubleshooting Ingress Issues

### Issue: Ingress Shows No Address

**Symptom:**

``` bash
NAME                  CLASS   HOSTS         ADDRESS   PORTS   AGE
humor-game-ingress    nginx   localhost     <none>    80      5m
```

**Diagnosis:**

``` bash
# Check ingress controller service
kubectl get svc -n ingress-nginx

# Check k3d port mappings
docker ps | grep k3d
```

**Fix:**

``` bash
# Ensure k3d was created with correct port mappings
k3d cluster delete dev-cluster
k3d cluster create dev-cluster --port "8080:80@loadbalancer" --port "8090:443@loadbalancer"
```

### Issue: 404 Not Found

**Symptom:** Ingress returns 404 for all requests

**Diagnosis:**

``` bash
# Check ingress paths and backend services
kubectl describe ingress humor-game-ingress -n humor-game

# Verify services exist and have endpoints
kubectl get svc -n humor-game
kubectl get endpoints -n humor-game
```

**Fix:**

``` bash
# Ensure backend services are running
kubectl get pods -n humor-game

# Check service selector matches pod labels
kubectl describe svc frontend -n humor-game
kubectl get pods -n humor-game --show-labels
```

### Issue: Backend API Not Accessible

**Symptom:** Frontend loads but `/api/*` returns 502

**Diagnosis:**

``` bash
# Check backend service health
kubectl logs -l app=backend -n humor-game --tail=20

# Test backend service directly
kubectl port-forward svc/backend -n humor-game 3001:3001 &
curl http://localhost:3001/api/health
```

**Fix:**

``` bash
# Ensure backend is healthy
kubectl get pods -l app=backend -n humor-game

# Check ingress backend configuration
kubectl describe ingress humor-game-ingress -n humor-game
```

## Production Considerations

### SSL/TLS Configuration

For production deployments:

``` bash
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

``` bash
# Scale ingress controller for HA
helm upgrade ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.replicaCount=3 \
  --set controller.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].topologyKey=kubernetes.io/hostname
```

## What You Learned

You've implemented production-grade networking:

**Ingress Fundamentals:** - **Layer 7 Routing**: Host and path-based
traffic routing - **SSL Termination**: Handling HTTPS at the ingress
layer - **Load Balancing**: Distributing traffic across multiple pods -
**Traffic Management**: Rate limiting and request/response modification

**Production Patterns:** - **Domain Configuration**: Real-world domain
and DNS setup - **Security Headers**: Browser security protection -
**Monitoring Integration**: Metrics and logging for troubleshooting -
**High Availability**: Multi-replica ingress controllers

**Networking Skills:** - **Kubernetes Services**: Understanding
ClusterIP, NodePort, LoadBalancer - **Ingress Controllers**: NGINX
configuration and management - **DNS Integration**: Local and production
domain configuration - **Certificate Management**: SSL/TLS automation
with cert-manager

This networking setup provides the foundation for production traffic
handling. Your application is now accessible from the internet with
proper security and performance characteristics.

------------------------------------------------------------------------

**Next**: [Chapter 7: CI/CD Pipeline Implementation](07-ci-cd.md) -
Automate your deployment workflow **Previous**: [Chapter 5: Kubernetes
Basics](05-kubernetes-basics.md) - Deploying your application to
Kubernetes

# Chapter 7: CI/CD Pipeline Implementation

*Build a production-ready continuous integration and deployment pipeline
with GitOps integration*

------------------------------------------------------------------------

## What You'll Learn

- Design and implement CI/CD pipelines with GitHub Actions
- Set up automated testing, security scanning, and quality gates
- Configure container registry integration and image management
- Implement GitOps-native deployment workflows
- Build proper CI/CD security and secrets management

## Time Required: 30 minutes

## Prerequisites: [Chapter 6: Production Networking and Ingress](06-ingress-networking.md)

------------------------------------------------------------------------

## Why This Matters

Manual deployments don't scale and create consistency problems.
Professional software teams deploy multiple times per day using
automated pipelines that ensure quality, security, and reliability.
Learning to build these pipelines is essential for any DevOps engineer.

**Career Impact**: Companies look for engineers who understand the full
software delivery lifecycle. CI/CD pipeline knowledge is fundamental for
DevOps, Platform Engineering, and SRE roles.

** Pro Tip**: Good CI/CD pipelines catch problems before they reach
production, saving teams hours of debugging and customer-facing issues.

## Understanding CI/CD vs GitOps

Your implementation combines traditional CI/CD with GitOps for the best
of both worlds:

       Code Change          CI/CD Tests          GitOps Repo   
       (Git Push)       Build Images     Update Tags   

                                                     ArgoCD Sync   
                                                     to Cluster    

**Traditional CI/CD**: Tests  Build  Deploy directly to cluster
**GitOps CI/CD**: Tests  Build  Update Git  GitOps tool deploys

## Current Implementation Analysis

###  Production-Ready Pipeline Status

Your CI/CD pipeline is now **fully functional and production-ready**.
Here's what it accomplishes:

** Current Capabilities:** 1. **GitHub Container Registry**: Uses
`ghcr.io` for secure image storage 2. **GitOps Integration**: Updates
manifests and triggers ArgoCD deployment 3. **Security Scanning**: Trivy
vulnerability scanning with SARIF upload 4. **Smart Image Tagging**:
Uses commit SHA for precise versioning 5. **Database Integration**:
Properly configures database connections via ConfigMaps and Secrets 6.
**Multi-Environment Support**: Works with local k3d and production
clusters

### Pipeline Scope and Limitations

** What CI/CD Pipeline DOES:** - **Builds and pushes** container
images to GitHub Container Registry - **Updates GitOps manifests** with
new image tags - **Triggers ArgoCD** to deploy to Kubernetes cluster -
**Runs security scans** and quality checks - **Deploys to Kubernetes**
cluster level

** What CI/CD Pipeline DOES NOT Do:** - **No Cloudflare Integration**:
Requires manual tunnel setup - **No Global Access**: Only deploys to
cluster, not globally accessible - **No External DNS**: DNS routing must
be configured separately

## Database Connection in CI/CD Pipeline

### How Database Integration Works

Your CI/CD pipeline properly handles database connections through
Kubernetes configuration:

** Database Connection Flow:**

    CI/CD Pipeline  Build Images  Update Manifests  ArgoCD Deploy  Kubernetes Pods
                                                                        
                                                                  Environment Variables
                                                                        
                                                                  ConfigMap + Secrets
                                                                        
                                                                  Database Connection Pool
                                                                        
                                                                  PostgreSQL Service

** Database Configuration in Pipeline:**

#  Database Configuration in CI/CD

# How database connections are managed through the pipeline

``` yaml
# Backend deployment gets these environment variables
env:
  - name: DB_HOST
    value: "postgres"  # Kubernetes service name
  - name: DB_NAME
    valueFrom:
      configMapKeyRef:
        name: humor-game-config
        key: DB_NAME
  - name: DB_USER
    valueFrom:
      configMapKeyRef:
        name: humor-game-config
        key: DB_USER
  - name: DB_PASSWORD
    valueFrom:
      secretKeyRef:
        name: humor-game-secrets
        key: DB_PASSWORD
```

** Key Points:** - **ConfigMap**: Contains non-sensitive database
configuration - **Secrets**: Contains sensitive data like passwords -
**Service Discovery**: Uses Kubernetes service name `postgres` -
**Connection Pooling**: Handles multiple concurrent connections -
**Automatic Schema**: Database initializes with proper schema on startup

## Implement the Production CI/CD Pipeline

### Step 1: Examine the Pipeline Structure

#  Examine CI/CD Pipeline Structure

# Review the new GitHub Actions workflow configuration

``` bash
# Check the new CI/CD pipeline
cat .github/workflows/ci.yml | head -20
```

**Expected Output:**

#  CI/CD Pipeline Configuration

# GitHub Actions workflow with container registry and triggers

``` yaml
name:  Continuous Integration

on:
  push:
    branches: [ main, develop, feature/* ]
  pull_request:
    branches: [ main, develop ]
  workflow_dispatch:

env:
  # Use GitHub Container Registry (free for public repos)
  REGISTRY: ghcr.io
  IMAGE_NAME_BACKEND: ${{ github.repository }}-backend
  IMAGE_NAME_FRONTEND: ${{ github.repository }}-frontend
```

### Step 2: Understand Pipeline Stages

The pipeline has 5 main stages:

#  View Pipeline Job Structure

# Examine the different stages of the CI/CD pipeline

``` bash
# View the job structure
grep -A 2 "jobs:" .github/workflows/ci.yml
```

**Expected Output:**

#  CI/CD Pipeline Jobs Overview

# Five main stages of the automated pipeline

``` yaml
jobs:
  test:
    name:  Test Application
  
  security-scan:
    name:  Security Scan
    
  build-and-push:
    name:  Build and Push Images
    
  update-gitops:
    name:  Update GitOps Repository
    
  notify:
    name:  Notify Team
```

### Step 3: Enable GitHub Container Registry

Your repository needs permissions to push to GitHub Container Registry:

**Via GitHub UI:** 1. Go to your repository  Settings  Actions 
General 2. Under "Workflow permissions" select "Read and write
permissions" 3. Check "Allow GitHub Actions to create and approve pull
requests"

\[\[ADD IMAGE: GitHub repository settings showing workflow
permissions\]\]

**Verify with CLI:** \#  Verify GitHub Container Registry Access \#
Test authentication to GitHub Container Registry

``` bash
# Check if you can access the registry
echo ${{ secrets.GITHUB_TOKEN }} | docker login ghcr.io -u ${{ github.actor }} --password-stdin
```

### Step 4: Test the Complete Pipeline

Let's trigger the pipeline and watch it work:

#  Trigger CI/CD Pipeline Test

# Make a change to test the complete pipeline workflow

``` bash
# Make a simple change to trigger the pipeline
echo "<!-- CI/CD test change $(date) -->" >> README.md

# Commit and push to trigger the workflow
git add README.md
git commit -m "test: trigger CI/CD pipeline demonstration"
git push origin main
```

**What happens next:** 1. **GitHub Actions** detects the push and starts
the workflow 2. **Test Stage** runs unit tests and linting (parallel
with security scan) 3. **Security Scan** runs Trivy vulnerability
scanning 4. **Build Stage** creates and pushes images to GitHub
Container Registry 5. **GitOps Update** modifies manifests with new
image tags and commits changes 6. **ArgoCD Sync** (if configured)
detects Git changes and deploys to cluster 7. **Database Connection** is
established using ConfigMap and Secret values 8. **Application** becomes
available at cluster level (not globally accessible)

### Step 5: Monitor Pipeline Execution

**Watch in GitHub UI:** 1. Go to your repository  Actions tab 2. Click
on the running workflow 3. Watch each job complete

\[\[ADD IMAGE: GitHub Actions workflow running with all stages\]\]

**Expected Timeline:**

#  CI/CD Pipeline Timeline

# Estimated execution times for each pipeline stage

``` bash
 Test Application         (2-3 minutes)
 Security Scan            (1-2 minutes, parallel with test)
 Build and Push Images    (3-5 minutes)
 Update GitOps Repository (30 seconds)
 Notify Team              (10 seconds)
```

## Understanding Each Pipeline Stage

### Stage 1: Test Application

#  Test Application Stage Configuration

# GitHub Actions job for running tests and linting

``` yaml
test:
  name:  Test Application
  runs-on: ubuntu-latest
  
  steps:
    - name:  Checkout code
      uses: actions/checkout@v4
      
    - name:  Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'
```

**What it does:** - Runs unit tests for both frontend and backend -
Lints code for consistency - Fails fast if basic quality checks don't
pass - Uses npm cache for faster builds

### Stage 2: Security Scanning

#  Security Scanning Stage Configuration

# Trivy vulnerability scanner integration

``` yaml
security-scan:
  name:  Security Scan
  runs-on: ubuntu-latest
  
  steps:
    - name:  Run Trivy vulnerability scanner
      uses: aquasecurity/trivy-action@master
      with:
        scan-type: 'fs'
        scan-ref: '.'
```

**What it does:** - Scans your code for known vulnerabilities - Checks
dependencies for security issues - Creates security reports in GitHub -
Blocks deployment if critical vulnerabilities found

### Stage 3: Build and Push Images

#  Build and Push Images Stage Configuration

# Docker image building and registry push

``` yaml
build-and-push:
  name:  Build and Push Images
  runs-on: ubuntu-latest
  needs: [test, security-scan]
  if: github.event_name == 'push' && (github.ref == 'refs/heads/main' || github.ref == 'refs/heads/develop')
```

**What it does:** - Only runs on main/develop branches (not PRs) -
Builds Docker images for frontend and backend - Tags images with branch
name and commit SHA - Pushes to GitHub Container Registry - Uses layer
caching for faster builds

**Image Tagging Strategy:**

#  Docker Image Tagging Strategy

# Multiple tags for different deployment scenarios

``` bash
# Images get multiple tags:
ghcr.io/your-username/repo-backend:main-a1b2c3d    # Branch + short SHA
ghcr.io/your-username/repo-backend:main           # Latest for branch
ghcr.io/your-username/repo-backend:latest         # Latest for default branch
```

### Stage 4: Update GitOps Repository

#  Update GitOps Repository Stage Configuration

# Automated GitOps manifest updates for deployment

``` yaml
update-gitops:
  name:  Update GitOps Repository
  runs-on: ubuntu-latest
  needs: build-and-push
  if: github.ref == 'refs/heads/main'
```

**What it does:** - Updates image tags in GitOps manifests - Changes
`imagePullPolicy` to `Always` for production - Commits changes back to
the repository - Triggers ArgoCD to deploy new images

**Key Innovation:**

#  GitOps Manifest Update Process

# Automated image tag updates using yq

``` bash
# Updates actual image references in GitOps files:
yq eval '.spec.template.spec.containers[0].image = "ghcr.io/repo-backend:main-a1b2c3d"' -i gitops-safe/base/backend-deployment.yaml
```

## Configure GitHub Repository Settings

### Step 6: Set Up Repository Permissions

**Required Settings:**

#  GitHub Repository Permissions

# Automatic configuration for CI/CD workflow access

``` bash
# These are automatically configured when you enable workflow permissions:
# - GITHUB_TOKEN with write access to packages
# - Permission to commit back to repository
# - Access to GitHub Container Registry
```

**Verify Settings:** 1. Repository  Settings  Actions  General 2.
Workflow permissions: "Read and write permissions"  3. "Allow GitHub
Actions to create and approve pull requests" 

### Step 7: Optional - Add Custom Secrets

For production deployments, you might add:

#  Optional Custom Secrets Configuration

# Additional secrets for production deployments

``` bash
# Add repository secrets (optional):
# Settings  Secrets and variables  Actions  New repository secret

SLACK_WEBHOOK_URL=https://hooks.slack.com/services/...
CUSTOM_REGISTRY_TOKEN=your-private-registry-token
DEPLOYMENT_SSH_KEY=ssh-private-key-for-deployments
```

## Test the Complete Workflow

### Step 8: Create a Feature Branch Workflow

#  Create Feature Branch Workflow

# Test CI/CD pipeline with feature branch development

``` bash
# Create a feature branch
git checkout -b feature/test-pipeline

# Make a code change
echo "console.log('Pipeline test');" >> backend/server.js

# Commit and push
git add backend/server.js
git commit -m "feat: add pipeline test logging"
git push origin feature/test-pipeline
```

**Expected Behavior:** - Tests run  - Security scan runs  - Images
do NOT build (only main/develop builds images) - No GitOps update
(feature branches don't deploy)

### Step 9: Create a Pull Request

#  Create Pull Request

# Test CI/CD pipeline with pull request workflow

``` bash
# Create PR via GitHub UI or CLI
gh pr create --title "Test: Pipeline demonstration" --body "Testing the complete CI/CD workflow"
```

**Expected Behavior:** - Tests run on PR  - Security scan runs \
- Shows status checks in PR - Blocks merge if tests fail

### Step 10: Merge and Deploy

``` bash
# Merge the PR (via GitHub UI or CLI)
gh pr merge --merge

# Switch back to main
git checkout main
git pull origin main
```

**Expected Behavior:** - Full pipeline runs  - Images build and push
 - GitOps manifests update  - ArgoCD syncs changes 

## Monitor and Verify Deployment

### Step 11: Check Container Registry

``` bash
# View your pushed images
# Go to: github.com/YOUR_USERNAME/YOUR_REPO/packages

# Or check locally
docker pull ghcr.io/YOUR_USERNAME/devops-home-lab-2025-backend:latest
```

### Step 12: Verify GitOps Updates

``` bash
# Check that GitOps manifests were updated
git log --oneline -n 5
```

**Expected Output:**

``` bash
a1b2c3d  Deploy: Update images to a1b2c3d
e4f5g6h feat: add pipeline test logging
i7j8k9l test: trigger CI/CD pipeline demonstration
```

``` bash
# Check the actual image tags in manifests
grep "image:" gitops-safe/base/backend-deployment.yaml
grep "image:" gitops-safe/base/frontend-deployment.yaml
```

**Expected Output:**

``` yaml
image: ghcr.io/your-username/devops-home-lab-2025-backend:main-a1b2c3d
image: ghcr.io/your-username/devops-home-lab-2025-frontend:main-a1b2c3d
```

### Step 13: Verify Cluster Deployment

``` bash
# Check if ArgoCD deployed the new images
kubectl describe deployment backend -n humor-game | grep Image
kubectl describe deployment frontend -n humor-game | grep Image
```

**Expected Output:**

``` bash
    Image:      ghcr.io/your-username/devops-home-lab-2025-backend:main-a1b2c3d
    Image:      ghcr.io/your-username/devops-home-lab-2025-frontend:main-a1b2c3d
```

##  Checkpoint

Your CI/CD pipeline is working correctly when: -  **Tests run
automatically** on every push and PR -  **Security scanning**
completes without blocking issues -  **Images build and push** to
GitHub Container Registry on main/develop -  **GitOps manifests
update** with new image tags automatically -  **ArgoCD detects
changes** and syncs to cluster -  **Application pods restart** with
new container images -  **Database connections** work properly with
ConfigMap/Secret values -  **Pipeline provides clear feedback** on
success/failure

## Understanding Pipeline Scope

### What Your CI/CD Pipeline Achieves

** Complete Application Deployment:** - **Container Images**: Built
and stored in GitHub Container Registry - **Kubernetes Deployment**:
Automated via GitOps and ArgoCD - **Database Integration**: Proper
connection configuration - **Service Discovery**: Uses Kubernetes
service names - **Configuration Management**: ConfigMaps and Secrets -
**Health Checks**: Application health monitoring

** What Requires Manual Setup:** - **Global Access**: Cloudflare
tunnel setup (see Chapter 6) - **External DNS**: Domain configuration in
Cloudflare - **SSL Certificates**: Handled by Cloudflare automatically -
**Production Monitoring**: Requires additional setup

## Troubleshooting CI/CD Issues

### Issue: Permission Denied to GitHub Container Registry

**Symptom:**

``` bash
Error: failed to solve: failed to push ghcr.io/username/repo:tag: unexpected status: 403 Forbidden
```

**Fix:**

``` bash
# 1. Check repository workflow permissions
# Go to Settings  Actions  General  Workflow permissions
# Select "Read and write permissions"

# 2. Ensure package exists or can be created
# Go to repository  Packages tab
# Verify no conflicting package permissions
```

### Issue: GitOps Update Fails

**Symptom:**

``` bash
Error: nothing to commit, working tree clean
```

**Cause:** No actual changes in image tags

**Fix:**

``` bash
# Check if image actually changed
git log --oneline | grep "Deploy:"

# Verify new images were built
# Check GitHub Packages for new tags
```

### Issue: Tests Fail in CI but Pass Locally

**Symptom:** Tests pass on your machine but fail in GitHub Actions

**Diagnosis:**

``` bash
# Check test logs in GitHub Actions
# Look for environment differences:
# - Node.js version differences
# - Missing environment variables
# - Database connection issues
```

**Fix:**

``` bash
# Ensure test dependencies are in package.json
cd backend && npm test

# Add test database setup if needed
# Check environment variable requirements
```

### Issue: ArgoCD Doesn't Sync New Images

**Symptom:** GitOps manifests update but ArgoCD doesn't deploy

**Diagnosis:**

``` bash
# Check ArgoCD application status
kubectl get applications -n argocd

# Check if ArgoCD is polling repository
argocd app get humor-game-local --refresh
```

**Fix:**

``` bash
# Manual sync if needed
argocd app sync humor-game-local

# Or enable auto-sync
kubectl patch application humor-game-local -n argocd --type='merge' -p='{"spec":{"syncPolicy":{"automated":{"selfHeal":false,"prune":false}}}}'
```

### Issue: Database Connection Fails After Deployment

**Symptom:** Application pods start but can't connect to database

**Diagnosis:**

``` bash
# Check if PostgreSQL pod is running
kubectl get pods -n humor-game | grep postgres

# Check database logs
kubectl logs -n humor-game deployment/postgres

# Check backend logs for connection errors
kubectl logs -n humor-game deployment/backend
```

**Fix:**

``` bash
# Verify ConfigMap and Secret exist
kubectl get configmap humor-game-config -n humor-game
kubectl get secret humor-game-secrets -n humor-game

# Check if database service is accessible
kubectl exec -n humor-game deployment/backend -- nslookup postgres

# Test database connection manually
kubectl exec -n humor-game deployment/backend -- node -e "
const { Pool } = require('pg');
const pool = new Pool({
  host: 'postgres',
  database: 'humor_memory_game',
  user: 'gameuser',
  password: 'gamepass123'
});
pool.query('SELECT NOW()').then(res => console.log(' DB Connected:', res.rows[0])).catch(err => console.error(' DB Error:', err));
"
```

## Advanced CI/CD Patterns

### Multi-Environment Deployment

``` yaml
# Add staging deployment stage
deploy-staging:
  name:  Deploy to Staging
  runs-on: ubuntu-latest
  needs: build-and-push
  if: github.ref == 'refs/heads/develop'
  
  steps:
    - name:  Update staging manifests
      run: |
        yq eval '.spec.template.spec.containers[0].image = "${{ env.REGISTRY }}/${{ env.IMAGE_NAME_BACKEND }}:develop-${{ steps.short-sha.outputs.sha }}"' -i gitops-safe/overlays/staging/backend-patch.yaml
```

### Deployment Approval Gates

``` yaml
production-deploy:
  name:  Production Deployment
  runs-on: ubuntu-latest
  needs: deploy-staging
  environment: production  # Requires manual approval
  
  steps:
    - name:  Deploy to production
      run: |
        echo "Deploying to production..."
```

### Rollback Automation

``` yaml
rollback:
  name:  Rollback on Failure
  runs-on: ubuntu-latest
  if: failure()
  
  steps:
    - name:  Revert GitOps changes
      run: |
        git revert HEAD --no-edit
        git push origin main
```

## What You Learned

You've implemented a production-grade CI/CD pipeline:

**CI/CD Fundamentals:** - **Automated Testing**: Unit tests, linting,
and quality gates - **Security Integration**: Vulnerability scanning and
compliance checks - **Container Management**: Building, tagging, and
distributing images - **GitOps Integration**: Updating infrastructure as
code automatically - **Monitoring and Notifications**: Pipeline
visibility and team communication

**Production Patterns:** - **Branch-based Workflows**: Different
behavior for feature/main/develop branches - **Image Tagging Strategy**:
Semantic versioning with commit traceability - **Security by Default**:
Automated scanning and secure credential management - **Fail-fast
Principles**: Early detection of issues before deployment - **Audit
Trails**: Complete history of deployments through Git commits

**Advanced Concepts:** - **Multi-stage Pipelines**: Parallel execution
for efficiency - **Conditional Deployment**: Environment-specific
deployment logic - **Infrastructure as Code**: Treating deployment
configuration as versioned code - **Container Registry Management**:
Secure image distribution and lifecycle

**Career-Ready Skills:** - **DevOps Engineering**: Complete
understanding of software delivery pipelines - **Platform Engineering**:
Building developer-friendly deployment experiences - **Site
Reliability**: Implementing reliable, repeatable deployment processes -
**Security Engineering**: Integrating security throughout the software
lifecycle

This CI/CD implementation follows industry best practices and scales to
enterprise requirements. You now understand how modern software teams
deliver features safely and reliably to production.

------------------------------------------------------------------------

**Next**: [Chapter 8: Observability](08-observability.md) - Monitor and
alert on your application's health and performance **Previous**:
[Chapter 6: Production Networking and
Ingress](06-ingress-networking.md) - Making your application accessible
from the internet

# Chapter 8: Observability - Monitoring and Logging

*Implement production-grade monitoring with Prometheus and Grafana for
complete system visibility*

------------------------------------------------------------------------

## What You'll Learn

- Deploy Prometheus for metrics collection and alerting
- Configure Grafana with custom dashboards and visualizations
- Implement application metrics and business KPIs
- Set up logging aggregation and analysis
- Build production monitoring strategies

## Time Required: 90 minutes

## Prerequisites: [Chapter 7: CI/CD Pipeline Implementation](07-ci-cd.md)

------------------------------------------------------------------------

## Why This Matters

You can't manage what you can't measure. Observability is what separates
amateur deployments from production systems. When something breaks at 3
AM, monitoring tells you what went wrong, where, and how to fix it.

**Professional Context**: Site Reliability Engineers (SREs) at Google,
Netflix, and other tech giants rely on comprehensive observability to
maintain 99.99% uptime. These same patterns are now standard across the
industry.

** Pro Tip**: The three pillars of observability are metrics (what
happened), logs (detailed context), and traces (request flow). This
chapter focuses on metrics and logs.

## Understanding Observability Architecture

#  Observability Architecture Overview

# Complete monitoring stack with metrics collection and visualization

       Application      Prometheus        Grafana      
       Metrics              Scrapes &            Dashboards    
       (/metrics)           Stores               & Alerts      

       Node Metrics         Alert Rules          Notification  
       (CPU, Memory)        & Thresholds         Channels      

## Deploy Prometheus Monitoring Stack

### Step 1: Create Monitoring Namespace

#  Create Monitoring Namespace

# Set up dedicated namespace for monitoring components

``` bash
# Create dedicated monitoring namespace
kubectl create namespace monitoring
```

**Expected Output:**

#  Monitoring Namespace Created

# Confirmation of monitoring namespace creation

``` bash
namespace/monitoring created
```

### Step 2: Deploy Prometheus

#  Deploy Prometheus Configuration

# Apply Prometheus monitoring stack to the cluster

``` bash
# Apply Prometheus configuration
kubectl apply -f k8s/monitoring.yaml
```

**Expected Output:**

#  Prometheus Resources Created

# Confirmation of Prometheus deployment components

``` bash
configmap/prometheus-config created
deployment.apps/prometheus created
service/prometheus created
persistentvolumeclaim/prometheus-pvc created
```

#  Wait for Prometheus Readiness

# Ensure Prometheus pod is fully initialized

``` bash
# Wait for Prometheus to be ready
kubectl wait --for=condition=Ready pods -l app=prometheus -n monitoring --timeout=300s
```

**Expected Output:**

#  Prometheus Pod Ready

# Confirmation that Prometheus is running and ready

``` bash
pod/prometheus-7c8b9d4f6d-xyz12 condition met
```

### Step 3: Verify Prometheus Deployment

#  Check Prometheus Pod Status

# Verify Prometheus deployment is healthy

``` bash
# Check Prometheus pod status
kubectl get pods -n monitoring
```

**Expected Output:**

#  Prometheus Pod Status

# Confirmation of healthy Prometheus deployment

``` bash
NAME                          READY   STATUS    RESTARTS   AGE
prometheus-7c8b9d4f6d-xyz12   1/1     Running   0          2m
```

#  Access Prometheus Web UI

# Port-forward to Prometheus for web interface access

``` bash
# Access Prometheus UI
kubectl port-forward svc/prometheus -n monitoring 9090:9090 &
```

**Access Prometheus:** - URL: `http://localhost:9090` - Check Status 
Targets to see discovered services

\[\[ADD IMAGE: Prometheus UI showing discovered targets and service
discovery\]\]

## Deploy Grafana Dashboard Platform

### Step 4: Deploy Grafana

#  Check Grafana Configuration

# Verify if Grafana is included in monitoring setup

``` bash
# Check if Grafana is included in monitoring.yaml
grep -A 10 "name: grafana" k8s/monitoring.yaml
```

If Grafana isn't included, add it:

#  Add Grafana Deployment Configuration

# Complete Grafana setup with persistent storage

``` bash
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

#  Apply Updated Monitoring Configuration

# Deploy Grafana with the updated monitoring setup

``` bash
# Apply updated monitoring configuration
kubectl apply -f k8s/monitoring.yaml
```

### Step 5: Access Grafana

#  Access Grafana Web Interface

# Wait for Grafana readiness and set up port-forwarding

``` bash
# Wait for Grafana to be ready
kubectl wait --for=condition=Ready pods -l app=grafana -n monitoring --timeout=300s

# Port-forward to Grafana
kubectl port-forward svc/grafana -n monitoring 3000:3000 &
```

**Access Grafana:** - URL: `http://localhost:3000` - Username: `admin` -
Password: `admin`

\[\[ADD IMAGE: Grafana login screen and initial dashboard\]\]

## Configure Prometheus Data Sources

### Step 6: Add Prometheus Data Source to Grafana

**In Grafana UI:** 1. Go to Configuration  Data Sources 2. Click "Add
data source" 3. Select "Prometheus" 4. Set URL: `http://prometheus:9090`
5. Click "Save & Test"

**Expected Result:** "Data source is working" message

### Step 7: Verify Metrics Collection

**In Prometheus UI** (`http://localhost:9090`):

#  Prometheus Query Examples

# Test metrics collection with sample queries

``` bash
# Query application metrics
up{job="humor-game-backend"}

# Query node metrics
node_cpu_seconds_total

# Query Kubernetes metrics
kube_pod_info
```

**Expected Results:** - Backend health metrics should show `1` (up) -
Node metrics should show CPU usage data - Kubernetes metrics should show
pod information

## Create Application Dashboards

### Step 8: Import Kubernetes Dashboard

**In Grafana UI:** 1. Click "+"  Import 2. Enter Dashboard ID: `15757`
(Kubernetes cluster monitoring) 3. Click "Load" 4. Select Prometheus
data source 5. Click "Import"

\[\[ADD IMAGE: Grafana Kubernetes dashboard showing cluster metrics\]\]

### Step 9: Create Custom Application Dashboard

**In Grafana UI:** 1. Click "+"  Create  Dashboard 2. Add Panel 
Query

**Key Metrics to Add:**

#  Prometheus Query Language Examples

# Key metrics for application monitoring

``` promql
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

#  Test Application Metrics Endpoint

# Verify if application exposes Prometheus metrics

``` bash
# Test metrics endpoint
curl http://localhost:8080/metrics
```

If metrics aren't available, add them to your backend:

**\[TODO\]** Add application metrics implementation guide for Node.js
backend with prom-client library.

## Set Up Logging

### Step 11: Deploy Logging Stack (Optional)

For production logging, you might deploy the ELK stack or similar:

#  Logging Stack Configuration Example

# Production logging setup with ELK or Loki stack

``` bash
# Example logging configuration (not included in basic setup)
# This would typically include Elasticsearch, Logstash, and Kibana
# or alternatives like Loki, Promtail, and Grafana
```

### Step 12: View Application Logs

#  View Application Logs

# Access and monitor application logs from Kubernetes

``` bash
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

#  Create Prometheus Alert Rules

# Configure alerting rules for critical system events

``` bash
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

#  Apply Alert Rules Configuration
# Deploy Prometheus alert rules to the cluster

```bash
# Apply alert rules
kubectl apply -f k8s/alert-rules.yaml
```

### Step 14: Configure Alertmanager (Optional)

#  Configure Alertmanager for Notifications

# Set up email and webhook alerting with Alertmanager

``` bash
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

#  Performance Monitoring Queries

# Key metrics for application performance monitoring

``` promql
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

``` promql
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

**Service Level Indicators (SLIs):** - Availability: `up` metric -
Latency: 95th percentile response time - Error Rate: 5xx responses /
total requests - Throughput: Requests per second

**Service Level Objectives (SLOs):** - 99.9% availability - 95% of
requests \< 200ms - Error rate \< 0.1% - Handle 1000 RPS

### Step 18: Set Up Monitoring Runbooks

Create documentation for common issues:

``` bash
# Example runbook entry
# Alert: HighErrorRate
# Severity: Critical
# Investigation Steps:
# 1. Check application logs: kubectl logs -l app=backend -n humor-game
# 2. Verify database connectivity: kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -c "SELECT 1"
# 3. Check service endpoints: kubectl get endpoints -n humor-game
# 4. Review recent deployments: kubectl rollout history deployment/backend -n humor-game
```

##  Checkpoint

Your observability stack is working when: -  Prometheus UI shows all
application targets as "UP" -  Grafana displays metrics from
Prometheus data source -  Kubernetes cluster dashboard shows accurate
cluster metrics -  Application logs are accessible via kubectl
commands -  Custom dashboards display application-specific metrics -
 Alert rules are configured and firing appropriately -  Memory and
storage usage are within reasonable limits

## Troubleshooting Monitoring Issues

### Issue: Prometheus Can't Scrape Targets

**Symptom:** Targets show as "DOWN" in Prometheus

**Diagnosis:**

``` bash
# Check if application metrics endpoint exists
kubectl port-forward svc/backend -n humor-game 3001:3001 &
curl http://localhost:3001/metrics

# Check Prometheus configuration
kubectl describe configmap prometheus-config -n monitoring
```

**Fix:**

``` bash
# Ensure application exposes metrics endpoint
# Check service discovery configuration
# Verify network policies allow Prometheus access
```

### Issue: Grafana Shows "No Data"

**Symptom:** Dashboards display but show no metrics

**Diagnosis:**

``` bash
# Test Prometheus data source connection
# Check Prometheus UI for available metrics
# Verify query syntax in Grafana panels
```

**Fix:**

``` bash
# Correct data source URL in Grafana
# Update dashboard queries to match available metrics
# Check time range in dashboard
```

### Issue: High Storage Usage

**Symptom:** Prometheus consuming excessive disk space

**Diagnosis:**

``` bash
# Check Prometheus storage usage
kubectl exec -it deployment/prometheus -n monitoring -- du -sh /prometheus

# Check retention policies
kubectl describe deployment prometheus -n monitoring
```

**Fix:**

``` bash
# Configure retention policy
# Add storage limits to deployment
# Implement metric filtering to reduce cardinality
```

## Advanced Monitoring Access

### Step 17: Set Up Monitoring Ingress

**Access monitoring services via ingress (no port-forwarding needed):**

``` bash
# Apply monitoring ingress
kubectl apply -f k8s/monitoring-ingress.yaml

# Check ingress status
kubectl get ingress -n monitoring
```

**Expected Output:**

``` bash
NAME                    CLASS   HOSTS                              ADDRESS      PORTS   AGE
monitoring-ingress      nginx   prometheus.gameapp.local,grafana.gameapp.local   172.18.0.2   80      1m
```

**Access URLs:** - Prometheus: `http://prometheus.gameapp.local:8080` -
Grafana: `http://grafana.gameapp.local:8080`

### Step 18: Configure Monitoring Authentication

**Set up basic authentication for monitoring services:**

``` bash
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

``` bash
# Import advanced dashboard
kubectl port-forward svc/grafana -n monitoring 3000:3000 &

# In Grafana UI:
# 1. Go to +  Import
# 2. Upload: k8s/advanced-custom-dashboard.json
# 3. Select Prometheus data source
# 4. Click Import
```

**Key dashboard panels:** - Application performance metrics -
Infrastructure resource usage - Business KPIs (game sessions, user
activity) - Error rate trends - Response time percentiles

### Step 20: Production Monitoring Setup

**Configure monitoring for production access:**

``` bash
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

``` bash
# Example Jaeger deployment (not included in basic setup)
# This would add distributed tracing capabilities
# kubectl apply -f https://github.com/jaegertracing/jaeger/releases/download/v1.50.0/jaeger.yaml
```

### Log Aggregation

``` bash
# Example Loki + Promtail setup
# Provides centralized logging with Grafana integration
# kubectl apply -f https://raw.githubusercontent.com/grafana/loki/main/production/kustomize/loki.yaml
```

### Prometheus RBAC Configuration

**Set up proper RBAC for Prometheus:**

``` bash
# Apply Prometheus RBAC
kubectl apply -f k8s/prometheus-rbac.yaml

# Verify service account permissions
kubectl get clusterrole prometheus -o yaml
kubectl get clusterrolebinding prometheus -o yaml
```

## What You Learned

You've implemented comprehensive observability:

**Monitoring Fundamentals:** - **Metrics Collection**: Prometheus
scraping and storage - **Visualization**: Grafana dashboards and panel
configuration - **Alerting**: Alert rules and notification channels -
**Service Discovery**: Automatic target discovery in Kubernetes

**Production Patterns:** - **SLI/SLO Monitoring**: Service level
indicators and objectives - **Business Metrics**: KPIs and user behavior
tracking - **Infrastructure Monitoring**: Resource usage and capacity
planning - **Log Management**: Centralized logging and analysis

**Operational Skills:** - **Dashboard Design**: Creating meaningful
visualizations - **Alert Configuration**: Setting up actionable alerts -
**Troubleshooting**: Using metrics to diagnose issues - **Capacity
Planning**: Understanding resource trends and growth

**Career-Ready Capabilities:** - **Site Reliability Engineering**:
Production monitoring and alerting - **DevOps Operations**: Complete
observability implementation - **Performance Engineering**: Application
and infrastructure optimization - **Incident Response**: Using
observability data for faster resolution

This monitoring setup provides the visibility needed for production
operations. You now understand how to maintain system reliability and
quickly identify and resolve issues.

------------------------------------------------------------------------

**Next**: [Chapter 9: GitOps - Automated Deployments](09-gitops.md) -
Implement GitOps workflows with ArgoCD **Previous**: [Chapter 7: CI/CD
Pipeline Implementation](07-ci-cd.md) - Building automated deployment
pipelines

# Chapter 9: GitOps - Automated Deployments

*Implement production-grade GitOps workflows with ArgoCD for reliable,
auditable deployments*

------------------------------------------------------------------------

## What You'll Learn

- Set up ArgoCD for GitOps automation
- Configure proper GitOps repository structure with Kustomize
- Implement automated image updates in CI/CD pipeline
- Demonstrate drift detection and self-healing capabilities
- Build a complete GitOps workflow from commit to deployment

## Time Required: 60 minutes

## Prerequisites: [Chapter 8: Observability](08-observability.md)

------------------------------------------------------------------------

## Why This Matters

GitOps is how modern companies deploy at scale. Instead of manual
`kubectl apply` commands, your Git repository becomes the single source
of truth for your infrastructure. When you commit changes, they
automatically deploy. When someone makes manual changes, GitOps detects
and corrects them.

**Professional Context**: Companies like Weave, Intuit, and CNCF
recommend GitOps because it provides audit trails, consistency, and
reliability that manual deployments can't match.

** Pro Tip**: GitOps means "If you want to deploy something, commit it
to Git. If you want to rollback, revert the commit." This simple
principle revolutionizes deployment reliability.

## Understanding GitOps Workflow

       Developer            Git Repo             ArgoCD        
       Commits          Source of        Watches &     
       Changes              Truth                Syncs         

                                                     Kubernetes    
                                                     Cluster       
                                                     Updates       

### Current Implementation Issues

Before we fix them, let's understand what's wrong with your current
setup:

1.  **Empty argocd-application-local.yaml** - No configuration
2.  **Incomplete kustomize overlays** - Missing resources\
3.  **CI/CD pushes directly to cluster** - Bypasses GitOps
4.  **No image update mechanism** - Manual image tag updates required

## Fix and Enhance ArgoCD Implementation

### Step 1: Install ArgoCD

``` bash
# Create ArgoCD namespace
kubectl create namespace argocd

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for ArgoCD to be ready
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s
```

**Expected Output:**

``` bash
namespace/argocd created
customresourcedefinition.apiextensions.k8s.io/applications.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/applicationsets.argoproj.io created
# ... many more resources
pod/argocd-application-controller-0 condition met
pod/argocd-dex-server-xxx condition met
pod/argocd-redis-xxx condition met
pod/argocd-repo-server-xxx condition met
pod/argocd-server-xxx condition met
```

### Step 2: Access ArgoCD UI

``` bash
# Get initial admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo  # Add newline
```

**Expected Output:**

``` bash
Xy9K8mNpQrS4vZ2E
```

``` bash
# Port-forward to ArgoCD server
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
```

**Access ArgoCD:** - URL: `https://localhost:8080` - Username: `admin`\
- Password: (from previous command) - ** Accept the self-signed
certificate warning**

\[\[ADD IMAGE: ArgoCD login screen with admin credentials\]\]

### Step 3: Create GitOps Project

``` bash
# Apply the ArgoCD project configuration
kubectl apply -f gitops-safe/argocd-project.yaml
```

**Expected Output:**

``` bash
appproject.argoproj.io/humor-game-safe created
```

**What this does:** - Creates a restricted project for your
application - Limits which repositories and clusters ArgoCD can access -
Defines resource whitelists for security - Prevents accidental
cluster-wide changes

### Step 4: Deploy GitOps Application (Local Development)

``` bash
# Apply the local ArgoCD application
kubectl apply -f gitops-safe/argocd-application-local.yaml
```

**Expected Output:**

``` bash
application.argoproj.io/humor-game-local created
```

### Step 5: Verify ArgoCD Application

``` bash
# Check ArgoCD application status
kubectl get applications -n argocd
```

**Expected Output:**

``` bash
NAME                SYNC STATUS   HEALTH STATUS   REVISION   PROJECT
humor-game-local    OutOfSync     Healthy         HEAD       humor-game-safe
```

** Pro Tip**: "OutOfSync" is expected initially because ArgoCD detects
differences between Git and your current cluster state.

## Understanding the GitOps Repository Structure

### Current Structure Analysis

``` bash
# Examine your gitops-safe directory structure
tree gitops-safe/
```

**Expected Output:**

``` bash
gitops-safe/
 argocd-application-local.yaml
 argocd-application.yaml
 argocd-project.yaml
 base/
    backend-deployment.yaml
    backend-service.yaml
    configmap.yaml
    frontend-deployment.yaml
    frontend-service.yaml
    kustomization.yaml
    postgres-deployment.yaml
    postgres-service.yaml
    pvc.yaml
    redis-deployment.yaml
    redis-service.yaml
 overlays/
     dev/
         kustomization.yaml
```

### Step 6: Test Kustomize Configuration

``` bash
# Build the base configuration
kubectl kustomize gitops-safe/base/ | head -20
```

**Expected Output:**

``` yaml
apiVersion: v1
kind: ConfigMap
metadata:
  annotations:
    gitops.argoproj.io/description: Base configuration for Humor Game
    gitops.argoproj.io/version: 1.0.0
  name: humor-game-config
  namespace: humor-game
data:
  API_PORT: "3001"
  DB_NAME: humor_memory_game
  DB_USER: gameuser
  NODE_ENV: production
  REDIS_HOST: redis
```

``` bash
# Build the dev overlay configuration
kubectl kustomize gitops-safe/overlays/dev/ | head -20
```

**Expected Output:**

``` yaml
apiVersion: v1
kind: ConfigMap
metadata:
  annotations:
    argocd.argoproj.io/tracking-id: humor-game-monitor:/kustomization.yaml
    gitops.argoproj.io/description: Base configuration for Humor Game
    gitops.argoproj.io/version: 1.0.0
  labels:
    app.kubernetes.io/instance: dev
    app.kubernetes.io/managed-by: argocd
    app.kubernetes.io/name: humor-game
    app.kubernetes.io/part-of: gitops-demo
  name: humor-game-config
  namespace: humor-game
```

## Demonstrate GitOps in Action

### Step 7: Sync Application in ArgoCD

**In ArgoCD UI:** 1. Click on the `humor-game-local` application 2.
Click "SYNC" button 3. Select "SYNCHRONIZE" to apply changes

\[\[ADD IMAGE: ArgoCD sync process showing the sync button and
confirmation\]\]

**Or via CLI:**

``` bash
# Install ArgoCD CLI (optional)
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Login to ArgoCD CLI
argocd login localhost:8080 --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure

# Sync the application
argocd app sync humor-game-local
```

**Expected Output:**

``` bash
TIMESTAMP                  GROUP        KIND   NAMESPACE                  NAME    STATUS    HEALTH        HOOK  MESSAGE
2025-01-15T10:30:00+00:00            ConfigMap  humor-game        humor-game-config    Synced  Healthy              
2025-01-15T10:30:01+00:00   apps  Deployment  humor-game              backend    Synced  Healthy              
2025-01-15T10:30:02+00:00   apps  Deployment  humor-game             frontend    Synced  Healthy              
2025-01-15T10:30:03+00:00   apps  Deployment  humor-game             postgres    Synced  Healthy              
2025-01-15T10:30:04+00:00   apps  Deployment  humor-game                redis    Synced  Healthy
```

### Step 8: Demonstrate Drift Detection

Now let's show ArgoCD's most powerful feature - drift detection:

``` bash
# Manually change something in the cluster (simulate drift)
kubectl scale deployment backend --replicas=3 -n humor-game

# Check what happened
kubectl get deployments -n humor-game
```

**Expected Output:**

``` bash
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
backend    3/3     3            3           5m
frontend   1/1     1            1           5m
postgres   1/1     1            1           5m
redis      1/1     1            1           5m
```

**In ArgoCD UI:** - The application will show "OutOfSync" status -
You'll see the difference between Git (1 replica) and cluster (3
replicas) - ArgoCD detects this drift automatically

\[\[ADD IMAGE: ArgoCD showing OutOfSync status with drift details\]\]

### Step 9: Test Self-Healing (Optional)

``` bash
# Enable auto-sync for demonstration
kubectl patch application humor-game-local -n argocd --type='merge' -p='{"spec":{"syncPolicy":{"automated":{"prune":false,"selfHeal":true}}}}'

# Wait and watch ArgoCD automatically fix the drift
kubectl get deployments -n humor-game -w
```

**Expected Output:**

``` bash
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
backend    3/3     3            3           5m
backend    3/1     1            3           5m    # ArgoCD starts correcting
backend    1/1     1            1           5m    # Back to desired state
```

** Pro Tip**: In production, you might disable self-healing for
critical applications and only enable it for non-critical workloads.

## Implement Complete CI/CD GitOps Workflow

### Step 10: Fix CI/CD Pipeline

Your current CI/CD pipeline has issues. I've created a fixed version in
`.github/workflows/ci.yml`:

**Key Improvements:** 1. **Uses GitHub Container Registry** (free for
public repos) 2. **Updates GitOps manifests** instead of direct
deployment 3. **Proper image tagging** with commit SHA 4. **Security
scanning** with Trivy 5. **Automated GitOps updates** after successful
builds

### Step 11: Test the Complete Workflow

**Make a code change:**

``` bash
# Make a simple change to test the workflow
echo "<!-- GitOps test change -->" >> frontend/src/index.html

# Commit and push
git add frontend/src/index.html
git commit -m "test: GitOps workflow demonstration"
git push origin main
```

**What happens:** 1. **GitHub Actions runs** CI/CD pipeline 2. **Tests
execute** and security scanning runs 3. **Docker images build** and push
to GitHub Container Registry 4. **GitOps manifests update** with new
image tags 5. **ArgoCD detects** the Git changes 6. **ArgoCD syncs** new
images to cluster

### Step 12: Monitor the Deployment

**Watch the GitHub Actions:** - Go to your repository  Actions tab -
Watch the workflow execute through all stages

**Watch ArgoCD:** - ArgoCD UI will show the application syncing - New
image tags will appear in the deployment

**Verify in cluster:**

``` bash
# Check that new images are deployed
kubectl describe deployment backend -n humor-game | grep Image
kubectl describe deployment frontend -n humor-game | grep Image
```

## Production GitOps Configuration

### Step 13: Configure Production Application

For production, use the separate application configuration:

``` bash
# Review the production configuration
cat gitops-safe/argocd-application.yaml
```

**Key Differences:** - Points to `main` branch (more stable) - Uses dev
overlay for environment-specific configuration - More restrictive sync
policies - Better suited for production workflows

### Step 14: Environment-Specific Configuration

``` bash
# Create production overlay (example)
mkdir -p gitops-safe/overlays/prod

# Production-specific kustomization
cat > gitops-safe/overlays/prod/kustomization.yaml << EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../../base

commonLabels:
  app.kubernetes.io/name: humor-game
  app.kubernetes.io/instance: prod
  app.kubernetes.io/part-of: gitops-demo
  app.kubernetes.io/managed-by: argocd
  environment: production

patchesStrategicMerge:
- replica-patch.yaml

images:
- name: humor-game-backend
  newTag: main-1.0.0
- name: humor-game-frontend  
  newTag: main-1.0.0
EOF

# Production replica configuration
cat > gitops-safe/overlays/prod/replica-patch.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 3
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 2
EOF
```

##  Checkpoint

Your GitOps implementation is working when: -  ArgoCD UI shows
`humor-game-local` application as "Synced" and "Healthy" -  Manual
cluster changes are detected as "OutOfSync" -  Kustomize builds
produce valid Kubernetes manifests -  CI/CD pipeline successfully
updates GitOps manifests -  ArgoCD automatically syncs new image tags
from Git -  Application pods restart with new images after CI/CD
runs -  All configuration is version-controlled in Git

## Troubleshooting GitOps Issues

### Issue: ArgoCD Application Shows "Unknown" Health

**Symptom:**

``` bash
NAME                SYNC STATUS   HEALTH STATUS   REVISION
humor-game-local    Synced        Unknown         HEAD
```

**Diagnosis:**

``` bash
# Check ArgoCD application details
kubectl describe application humor-game-local -n argocd

# Check ArgoCD server logs
kubectl logs deployment/argocd-server -n argocd
```

**Fix:**

``` bash
# Refresh the application
argocd app get humor-game-local --refresh

# Or delete and recreate
kubectl delete application humor-game-local -n argocd
kubectl apply -f gitops-safe/argocd-application-local.yaml
```

### Issue: Kustomize Build Fails

**Symptom:**

``` bash
Error: accumulating resources: accumulation err='merging resources from 'backend-deployment.yaml': may not add resource with an already registered id
```

**Diagnosis:**

``` bash
# Check for duplicate resources in kustomization.yaml
kubectl kustomize gitops-safe/base/ --dry-run
```

**Fix:**

``` bash
# Ensure no duplicate resource names in kustomization.yaml
# Remove any duplicate entries in the resources list
```

### Issue: CI/CD Pipeline Fails to Push Images

**Symptom:** GitHub Actions shows authentication errors to container
registry

**Fix:**

``` bash
# Ensure your repository has the necessary permissions
# Go to Settings  Actions  General  Workflow permissions
# Select "Read and write permissions"
# Check "Allow GitHub Actions to create and approve pull requests"
```

### Issue: Image Updates Don't Trigger ArgoCD Sync

**Symptom:** CI/CD updates manifests but ArgoCD doesn't sync

**Diagnosis:**

``` bash
# Check if ArgoCD is polling the repository
argocd app get humor-game-local

# Check repository connection
argocd repo get https://github.com/YOUR_USERNAME/DevOps-Home-Lab-2025.git
```

**Fix:**

``` bash
# Manually refresh the repository
argocd app get humor-game-local --refresh

# Or enable webhooks (advanced)
# Configure GitHub webhooks to notify ArgoCD of changes
```

## Advanced GitOps Troubleshooting

### Issue: ArgoCD Application Health Issues

**Symptom:** Application shows "Unknown" or "Degraded" health

**Diagnosis:**

``` bash
# Check application health details
kubectl describe application humor-game-local-dev -n argocd

# Check resource health
kubectl get all -n humor-game
kubectl describe pods -n humor-game
```

**Common Fixes:**

``` bash
# 1. Refresh application
kubectl patch application humor-game-local-dev -n argocd \
  --type='merge' \
  -p='{"metadata": {"annotations": {"argocd.argoproj.io/refresh": "hard"}}}'

# 2. Force sync with prune disabled
kubectl patch application humor-game-local-dev -n argocd \
  --type='merge' \
  -p='{"operation": {"sync": {"syncOptions": ["Prune=false"]}}}'

# 3. Check Kustomize build
kubectl kustomize gitops-safe/overlays/dev/
```

### Issue: GitOps Repository Access Problems

**Symptom:** ArgoCD can't access Git repository

**Diagnosis:**

``` bash
# Check repository connectivity
kubectl logs -l app.kubernetes.io/name=argocd-server -n argocd | grep -i "repository"

# Check Git credentials
kubectl get secret argocd-repo -n argocd -o yaml
```

**Fixes:**

``` bash
# 1. Update repository credentials
kubectl create secret generic argocd-repo \
  --from-literal=username=YOUR_GITHUB_USERNAME \
  --from-literal=password=YOUR_GITHUB_TOKEN \
  -n argocd

# 2. Restart ArgoCD server
kubectl rollout restart deployment/argocd-server -n argocd
```

### Issue: Kustomize Build Failures

**Symptom:** ArgoCD shows "Build Error" status

**Diagnosis:**

``` bash
# Test Kustomize build locally
kubectl kustomize gitops-safe/overlays/dev/

# Check for YAML syntax errors
kubectl apply --dry-run=client -k gitops-safe/overlays/dev/
```

**Fixes:**

``` bash
# 1. Fix YAML syntax errors
# Check each YAML file for indentation and syntax

# 2. Verify resource references
kubectl get configmap -n humor-game
kubectl get secret -n humor-game

# 3. Check resource dependencies
kubectl describe configmap humor-game-config -n humor-game
```

## What You Learned

You've implemented a complete GitOps workflow:

**GitOps Fundamentals:** - **Declarative Configuration**: Infrastructure
defined in Git as code - **Automated Sync**: ArgoCD watches Git and
applies changes automatically - **Drift Detection**: Identifies manual
changes and can auto-correct them - **Audit Trail**: Complete history of
deployments through Git commits - **Rollback Capability**: Simple git
revert to rollback deployments

**Production Patterns:** - **Environment Separation**: Using Kustomize
overlays for different environments - **Security Controls**: AppProject
restrictions and RBAC integration - **Image Management**: Automated
image tag updates in CI/CD pipeline - **Multi-stage Workflow**: Tests 
Build  Update GitOps  Deploy

**Operational Skills:** - **ArgoCD Management**: Installing,
configuring, and operating ArgoCD - **Kustomize Configuration**:
Building flexible, reusable Kubernetes manifests - **CI/CD
Integration**: Connecting traditional pipelines with GitOps workflows -
**Troubleshooting**: Diagnosing and fixing common GitOps issues

**Career-Ready Capabilities:** - **DevOps Engineering**: Complete
understanding of modern deployment workflows - **Platform Engineering**:
Building developer-friendly deployment platforms - **Site Reliability**:
Implementing reliable, auditable deployment processes - **Security**:
Understanding GitOps security implications and controls

This GitOps implementation mirrors what major tech companies use for
production deployments. You now understand how to build reliable,
auditable, and automated deployment pipelines that scale to serve
millions of users.

------------------------------------------------------------------------

**Next**: [Chapter 10: Production Hardening and
Security](10-prod-hardening.md) - Secure your application for production
deployment **Previous**: [Chapter 8:
Observability](08-observability.md) - Monitoring and alerting for
production systems

# Chapter 10: Production Hardening and Security

*Secure your application for production deployment with enterprise-grade
security practices*

------------------------------------------------------------------------

## What You'll Learn

- Implement Kubernetes security contexts and resource limits
- Configure network policies for micro-segmentation
- Set up horizontal pod autoscaling (HPA) for reliability
- Apply security best practices and vulnerability management
- Build production-ready security configurations

## Time Required: 45 minutes

## Prerequisites: [Chapter 9: GitOps - Automated Deployments](09-gitops.md)

------------------------------------------------------------------------

## Why This Matters

Security isn't optional in production. This chapter teaches you the
security hardening practices used by companies handling sensitive data.
A single security misconfiguration can cost companies millions in
breaches and downtime.

**Professional Context**: Security is everyone's responsibility in
DevOps. Platform engineers design secure defaults, and understanding
these patterns is crucial for any production deployment.

** Pro Tip**: Security hardening is about reducing attack surface and
implementing defense-in-depth. Each layer of security makes it harder
for attackers to compromise your system.

## Understanding Kubernetes Security Model

       Network              Pod Security         Resource      
       Policies             Context              Limits        
       (Network)            (Runtime)            (CPU/Memory)  

       Service              RBAC                 Image         
       Accounts             Permissions          Security      

## Implement Security Contexts

### Step 1: Apply Security Contexts

``` bash
# Apply security contexts to all pods
kubectl apply -f k8s/security-context.yaml
```

**Expected Output:**

``` bash
deployment.apps/backend configured
deployment.apps/frontend configured
deployment.apps/postgres configured
deployment.apps/redis configured
```

### Step 2: Examine Security Context Configuration

``` bash
# Check applied security contexts
kubectl describe deployment backend -n humor-game | grep -A 10 "Security Context"
```

**Expected Output:**

``` bash
    Security Context:
      runAsNonRoot:             true
      runAsUser:                1001
      runAsGroup:               1001
      readOnlyRootFilesystem:   true
      allowPrivilegeEscalation: false
      capabilities:
        drop:
        - ALL
```

### Step 3: Verify Security Settings

``` bash
# Test that containers run as non-root
kubectl exec deployment/backend -n humor-game -- id
```

**Expected Output:**

``` bash
uid=1001 gid=1001 groups=1001
```

``` bash
# Verify read-only filesystem
kubectl exec deployment/backend -n humor-game -- touch /test-file || echo "Good: Read-only filesystem working"
```

**Expected Output:**

``` bash
touch: cannot touch '/test-file': Read-only file system
Good: Read-only filesystem working
```

## Configure Network Policies

### Step 4: Apply Network Policies

``` bash
# Apply network micro-segmentation
kubectl apply -f k8s/network-policies.yaml
```

**Expected Output:**

``` bash
networkpolicy.networking.k8s.io/deny-all created
networkpolicy.networking.k8s.io/allow-frontend-to-backend created
networkpolicy.networking.k8s.io/allow-backend-to-database created
networkpolicy.networking.k8s.io/allow-backend-to-redis created
networkpolicy.networking.k8s.io/allow-ingress-to-frontend created
networkpolicy.networking.k8s.io/allow-monitoring created
```

### Step 5: Test Network Isolation

``` bash
# Test that network policies are working
# This should fail (blocked by network policy)
kubectl run test-pod --image=busybox --rm -it -- sh -c "wget -qO- --timeout=5 http://postgres.humor-game.svc.cluster.local:5432 || echo 'Connection blocked by network policy'"
```

**Expected Output:**

``` bash
Connection blocked by network policy
pod "test-pod" deleted
```

``` bash
# Test that legitimate traffic works
kubectl exec deployment/backend -n humor-game -- curl -s http://postgres:5432 > /dev/null && echo "Backend can reach database"
```

**Expected Output:**

``` bash
Backend can reach database
```

## Set Up Resource Limits and Quotas

### Step 6: Apply Resource Limits

``` bash
# Check current resource limits
kubectl describe deployment backend -n humor-game | grep -A 10 "Limits\|Requests"
```

**Expected Output:**

``` bash
    Limits:
      cpu:     500m
      memory:  512Mi
    Requests:
      cpu:     100m
      memory:  128Mi
```

### Step 7: Create Resource Quotas

``` bash
# Create namespace resource quotas
cat > k8s/resource-quota.yaml << 'EOF'
apiVersion: v1
kind: ResourceQuota
metadata:
  name: humor-game-quota
  namespace: humor-game
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 4Gi
    limits.cpu: "4"
    limits.memory: 8Gi
    pods: "10"
    persistentvolumeclaims: "4"
    services: "5"
EOF

kubectl apply -f k8s/resource-quota.yaml
```

**Expected Output:**

``` bash
resourcequota/humor-game-quota created
```

``` bash
# Verify quota is applied
kubectl describe quota humor-game-quota -n humor-game
```

**Expected Output:**

``` bash
Name:                   humor-game-quota
Namespace:              humor-game
Resource                Used  Hard
--------                ----  ----
limits.cpu              2     4
limits.memory           1280Mi 8Gi
pods                    4     10
requests.cpu            400m  2
requests.memory         512Mi 4Gi
```

## Implement Horizontal Pod Autoscaling

### Step 8: Deploy HPA

``` bash
# Apply horizontal pod autoscaler
kubectl apply -f k8s/hpa.yaml
```

**Expected Output:**

``` bash
horizontalpodautoscaler.autoscaling/backend-hpa created
horizontalpodautoscaler.autoscaling/frontend-hpa created
```

### Step 9: Verify HPA Configuration

``` bash
# Check HPA status
kubectl get hpa -n humor-game
```

**Expected Output:**

``` bash
NAME           REFERENCE            TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
backend-hpa    Deployment/backend   <unknown>/70%   2         10        1          1m
frontend-hpa   Deployment/frontend  <unknown>/70%   2         5         1          1m
```

** Pro Tip**: `<unknown>` is normal initially. HPA needs
metrics-server data which takes a few minutes to populate.

### Step 10: Test Autoscaling

``` bash
# Generate load to test autoscaling (optional)
kubectl run load-generator --image=busybox --rm -it -- sh -c "while true; do wget -q -O- http://frontend.humor-game.svc.cluster.local; done"
```

**After a few minutes, check scaling:**

``` bash
kubectl get hpa -n humor-game
kubectl get pods -n humor-game
```

**Expected to see additional replicas if load is high enough.**

## Secrets Management

### Step 11: Rotate Secrets

``` bash
# Generate new database password
NEW_DB_PASSWORD=$(openssl rand -base64 32)

# Update secret (in production, use external secret management)
kubectl patch secret humor-game-secrets -n humor-game -p="{\"data\":{\"DB_PASSWORD\":\"$(echo -n $NEW_DB_PASSWORD | base64)\"}}"

# Restart deployments to pick up new secret
kubectl rollout restart deployment/backend -n humor-game
kubectl rollout restart deployment/postgres -n humor-game
```

### Step 12: Implement Secret Scanning

``` bash
# Scan repository for leaked secrets (example with truffleHog)
# docker run --rm -v "$(pwd):/pwd" trufflesecurity/trufflehog:latest filesystem /pwd
echo "Run secret scanning in CI/CD pipeline"
```

## Image Security

### Step 13: Scan Container Images

``` bash
# Scan images for vulnerabilities (example with Trivy)
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image humor-game-backend:latest

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image humor-game-frontend:latest
```

### Step 14: Implement Image Policy

``` bash
# Example Pod Security Policy (deprecated) or Pod Security Standards
cat > k8s/pod-security-policy.yaml << 'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: humor-game
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
EOF

kubectl apply -f k8s/pod-security-policy.yaml
```

## Monitoring Security Events

### Step 15: Add Security Monitoring

``` bash
# Add security-related Prometheus alerts
cat > k8s/security-alerts.yaml << 'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: security-alert-rules
  namespace: monitoring
data:
  security.rules: |
    groups:
    - name: security.rules
      rules:
      - alert: PodSecurityViolation
        expr: increase(pod_security_violations_total[5m]) > 0
        for: 0m
        labels:
          severity: warning
        annotations:
          summary: Pod security policy violation detected
          
      - alert: HighPrivilegedPodCount
        expr: kube_pod_container_info{container_id!="",security_context_privileged="true"} > 0
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: Privileged pod detected
          
      - alert: RootUserDetected
        expr: kube_pod_container_info{container_id!="",security_context_run_as_user="0"} > 0
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: Container running as root user detected
EOF

kubectl apply -f k8s/security-alerts.yaml
```

## Backup and Disaster Recovery

### Step 16: Implement Database Backups

``` bash
# Create backup job for PostgreSQL
cat > k8s/backup-job.yaml << 'EOF'
apiVersion: batch/v1
kind: CronJob
metadata:
  name: postgres-backup
  namespace: humor-game
spec:
  schedule: "0 2 * * *"  # Daily at 2 AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: postgres-backup
            image: postgres:15-alpine
            command:
            - /bin/bash
            - -c
            - |
              pg_dump -h postgres -U gameuser -d humor_memory_game > /backup/backup-$(date +%Y%m%d-%H%M%S).sql
              # In production, upload to S3/GCS/Azure Storage
            env:
            - name: PGPASSWORD
              valueFrom:
                secretKeyRef:
                  name: humor-game-secrets
                  key: DB_PASSWORD
            volumeMounts:
            - name: backup-storage
              mountPath: /backup
          volumes:
          - name: backup-storage
            persistentVolumeClaim:
              claimName: backup-pvc
          restartPolicy: OnFailure
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: backup-pvc
  namespace: humor-game
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
EOF

kubectl apply -f k8s/backup-job.yaml
```

## Compliance and Auditing

### Step 17: Enable Audit Logging

``` bash
# Audit logging is typically configured at the cluster level
# Example audit policy (would be applied to kube-apiserver)
cat > audit-policy.yaml << 'EOF'
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata
  resources:
  - group: ""
    resources: ["secrets", "configmaps"]
- level: Request
  resources:
  - group: ""
    resources: ["pods", "services"]
  namespaces: ["humor-game", "monitoring"]
EOF

echo "In production, configure kube-apiserver with:"
echo "--audit-log-path=/var/log/audit.log"
echo "--audit-policy-file=/etc/kubernetes/audit-policy.yaml"
```

### Step 18: Document Security Configurations

``` bash
# Create security documentation
cat > SECURITY.md << 'EOF'
# Security Configuration

## Security Controls Implemented

### Pod Security
- Non-root user execution (UID 1001)
- Read-only root filesystem
- No privilege escalation
- Dropped all capabilities
- Resource limits enforced

### Network Security
- Network policies implementing micro-segmentation
- Ingress-only external access
- Internal service communication restricted

### Resource Management
- CPU and memory limits on all containers
- Namespace resource quotas
- Horizontal pod autoscaling

### Secrets Management
- Kubernetes secrets for sensitive data
- Regular secret rotation procedures
- No hardcoded credentials

### Image Security
- Regular vulnerability scanning
- Non-root base images
- Minimal attack surface

### Monitoring
- Security event monitoring
- Alert rules for policy violations
- Audit logging enabled

## Security Checklist

- [ ] All containers run as non-root
- [ ] Read-only filesystems enabled
- [ ] Network policies applied
- [ ] Resource limits configured
- [ ] Secrets properly managed
- [ ] Images scanned for vulnerabilities
- [ ] Monitoring and alerting active
- [ ] Backup procedures in place
- [ ] Documentation up to date

## Incident Response

In case of security incident:
1. Isolate affected components
2. Check audit logs
3. Review monitoring alerts
4. Follow incident response playbook
5. Document lessons learned
EOF
```

##  Checkpoint

Your production hardening is complete when: -  All pods run with
security contexts (non-root, read-only filesystem) -  Network policies
enforce micro-segmentation -  Resource limits and quotas are
configured -  HPA is configured and responsive to load -  Secrets
are properly managed and rotated -  Images pass security scanning - 
Security monitoring and alerting is active -  Backup procedures are
implemented -  Security documentation is complete

## Troubleshooting Security Issues

### Issue: Pods Fail to Start After Security Context

**Symptom:**

``` bash
NAME                        READY   STATUS             RESTARTS   AGE
backend-7c8b9d4f6d-xyz12    0/1     CrashLoopBackOff   3          2m
```

**Diagnosis:**

``` bash
# Check pod events
kubectl describe pod -l app=backend -n humor-game

# Check logs
kubectl logs -l app=backend -n humor-game
```

**Common Causes:** - Application needs write access to specific
directories - Process runs as root in container image - Required file
permissions

**Fix:**

``` bash
# Add writable volumes for application needs
# Update Dockerfile to use non-root user
# Adjust security context if absolutely necessary
```

### Issue: Network Policy Blocks Legitimate Traffic

**Symptom:** Application components can't communicate

**Diagnosis:**

``` bash
# Test connectivity between pods
kubectl exec deployment/backend -n humor-game -- curl frontend:80

# Check network policy rules
kubectl describe networkpolicy -n humor-game
```

**Fix:**

``` bash
# Review and adjust network policy selectors
# Ensure all required traffic flows are allowed
# Test connectivity after changes
```

### Issue: HPA Not Scaling

**Symptom:** High load but no additional replicas

**Diagnosis:**

``` bash
# Check HPA events
kubectl describe hpa backend-hpa -n humor-game

# Verify metrics server
kubectl top pods -n humor-game
```

**Fix:**

``` bash
# Ensure metrics-server is installed and working
# Verify resource requests are set on containers
# Check if resource thresholds are appropriate
```

## Global Production Deployment

### Step 19: Multi-Region Deployment Strategy

**Deploy to multiple regions for high availability:**

``` bash
# Primary region (East US)
kubectl config use-context east-us-cluster
kubectl apply -k gitops-safe/overlays/prod-primary/

# Secondary region (West US) 
kubectl config use-context west-us-cluster
kubectl apply -k gitops-safe/overlays/prod-secondary/
```

**Configure cross-region replication:**

``` bash
# Set up database replication
kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -d humor_memory_game -c "
CREATE PUBLICATION cross_region_replication FOR ALL TABLES;
"

# Configure Redis replication
kubectl exec -it deployment/redis -n humor-game -- redis-cli CONFIG SET replicaof west-us-redis 6379
```

### Step 20: Global Load Balancing

**Configure Azure Front Door for global traffic distribution:**

``` bash
# Create Front Door profile
az afd profile create \
  --profile-name gameapp-frontdoor \
  --resource-group production-rg \
  --sku Standard_AzureFrontDoor

# Configure backend pools
az afd endpoint create \
  --endpoint-name gameapp-global \
  --profile-name gameapp-frontdoor \
  --resource-group production-rg \
  --enabled-state Enabled
```

**Health probe configuration:**

``` bash
# Configure health probes for automatic failover
az afd origin-group create \
  --origin-group-name gameapp-origins \
  --profile-name gameapp-frontdoor \
  --resource-group production-rg \
  --probe-path /api/health \
  --probe-protocol Http \
  --probe-interval-in-seconds 30
```

### Step 21: Disaster Recovery Testing

**Test failover procedures:**

``` bash
# Simulate primary region failure
kubectl scale deployment backend --replicas=0 -n humor-game --context east-us-cluster

# Verify traffic routes to secondary region
curl https://gameapp.games/api/health

# Restore primary region
kubectl scale deployment backend --replicas=2 -n humor-game --context east-us-cluster

# Verify traffic returns to primary
curl https://gameapp.games/api/health
```

## Advanced Security Patterns

### Service Mesh Security

``` bash
# Example Istio security policies (not included in basic setup)
# Would provide mutual TLS and fine-grained access control
```

### External Secret Management

``` bash
# Example integration with HashiCorp Vault or AWS Secrets Manager
# kubectl apply -f https://raw.githubusercontent.com/external-secrets/external-secrets/main/deploy/crds/bundle.yaml
```

### Policy as Code

``` bash
# Example OPA Gatekeeper policies
# Enforce security policies declaratively across the cluster
```

### Global Security Hardening

**Implement global security policies:**

``` bash
# Apply global network policies
kubectl apply -f k8s/global-network-policies.yaml

# Configure global RBAC
kubectl apply -f k8s/global-rbac.yaml

# Set up global security scanning
kubectl apply -f k8s/security-scanning.yaml
```

## What You Learned

You've implemented comprehensive production security:

**Security Fundamentals:** - **Runtime Security**: Security contexts and
privilege restrictions - **Network Security**: Micro-segmentation and
traffic control - **Resource Security**: Limits, quotas, and
autoscaling - **Data Security**: Secrets management and encryption

**Production Patterns:** - **Defense in Depth**: Multiple layers of
security controls - **Least Privilege**: Minimal permissions and access
rights - **Monitoring and Alerting**: Security event detection -
**Compliance**: Audit logging and documentation

**Operational Security:** - **Incident Response**: Procedures for
security events - **Vulnerability Management**: Image scanning and
patching - **Backup and Recovery**: Data protection strategies -
**Documentation**: Security runbooks and procedures

**Career-Ready Skills:** - **Security Engineering**: Implementing
enterprise security controls - **Compliance**: Meeting regulatory and
audit requirements - **Risk Management**: Identifying and mitigating
security risks - **Incident Response**: Handling security events
professionally

This security implementation follows industry best practices and
prepares your application for production deployment with
enterprise-grade security controls.

------------------------------------------------------------------------

**Next**: [Chapter 11: Deployment
Strategies](11-deployment-strategies.md) - Implement zero-downtime
deployment patterns **Previous**: [Chapter 9: GitOps - Automated
Deployments](09-gitops.md) - GitOps workflows with ArgoCD

# Chapter 11: Deployment Strategies

*Implement zero-downtime deployment patterns for reliable production
releases*

------------------------------------------------------------------------

## What You'll Learn

- Understand different deployment strategies and their use cases
- Implement rolling updates with Kubernetes
- Configure readiness and liveness probes for safe deployments
- Test deployment rollback procedures
- Design deployment strategies for different application types

## Time Required: 30 minutes

## Prerequisites: [Chapter 10: Production Hardening and Security](10-prod-hardening.md)

------------------------------------------------------------------------

## Why This Matters

How you deploy applications determines whether your users experience
downtime during updates. Professional deployment strategies ensure
continuous availability while reducing the risk of introducing bugs to
production.

**Professional Context**: Companies like Netflix deploy thousands of
times per day using sophisticated deployment strategies. Understanding
these patterns is essential for any production system.

** Pro Tip**: The best deployment strategy depends on your application
architecture, user tolerance for downtime, and rollback requirements.

## Understanding Deployment Strategies

### Deployment Strategy Comparison

  -------------------------------------------------------------------------------------
  Strategy         Downtime   Resource Usage   Rollback Speed   Risk     Use Case
  ---------------- ---------- ---------------- ---------------- -------- --------------
  **Recreate**     High       Low              Fast             High     Development

  **Rolling        None       Medium           Medium           Medium   Most
  Update**                                                               applications

  **Blue-Green**   None       High             Instant          Low      Critical
                                                                         systems

  **Canary**       None       Medium           Medium           Low      Risk-averse
  -------------------------------------------------------------------------------------

### Current Implementation

Your Kubernetes deployment already uses **Rolling Updates** by default:

``` yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 25%
    maxSurge: 25%
```

## Examine Current Rolling Update Strategy

### Step 1: Check Current Deployment Strategy

``` bash
# Check current deployment strategy
kubectl describe deployment backend -n humor-game | grep -A 5 "StrategyType"
```

**Expected Output:**

``` bash
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
```

``` bash
# Check rollout history
kubectl rollout history deployment/backend -n humor-game
```

**Expected Output:**

``` bash
deployment.apps/backend 
REVISION  CHANGE-CAUSE
1         <none>
```

### Step 2: Examine Health Checks

``` bash
# Check readiness and liveness probes
kubectl describe deployment backend -n humor-game | grep -A 10 "Liveness\|Readiness"
```

**Expected Output:**

``` bash
    Liveness:     http-get http://:3001/api/health delay=30s timeout=5s period=10s #success=1 #failure=3
    Readiness:    http-get http://:3001/api/health delay=10s timeout=5s period=5s #success=1 #failure=3
```

## Test Rolling Update Deployment

### Step 3: Trigger a Rolling Update

``` bash
# Update backend with a new environment variable to trigger rolling update
kubectl patch deployment backend -n humor-game -p='{"spec":{"template":{"metadata":{"annotations":{"deployment.kubernetes.io/revision":"2"}}}}}'
```

**Expected Output:**

``` bash
deployment.apps/backend patched
```

``` bash
# Watch the rolling update in real-time
kubectl rollout status deployment/backend -n humor-game -w
```

**Expected Output:**

``` bash
Waiting for deployment "backend" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "backend" rollout to finish: 1 old replicas are pending termination...
deployment "backend" successfully rolled out
```

### Step 4: Monitor Pod Transitions

``` bash
# In another terminal, watch pods during rollout
kubectl get pods -n humor-game -l app=backend -w
```

**Expected to see:**

``` bash
NAME                       READY   STATUS    RESTARTS   AGE
backend-7c8b9d4f6d-old12   1/1     Running   0          5m
backend-9f2c4e8a1b-new34   0/1     Pending   0          0s
backend-9f2c4e8a1b-new34   0/1     ContainerCreating   0          1s
backend-9f2c4e8a1b-new34   1/1     Running   0          15s
backend-7c8b9d4f6d-old12   1/1     Terminating   0          5m
```

** Pro Tip**: Notice how the new pod becomes ready before the old pod
terminates. This ensures zero downtime.

## Implement Advanced Health Checks

### Step 5: Configure Startup Probes

``` bash
# Add startup probe for slow-starting applications
cat > startup-probe-patch.yaml << 'EOF'
spec:
  template:
    spec:
      containers:
      - name: backend
        startupProbe:
          httpGet:
            path: /api/health
            port: 3001
          initialDelaySeconds: 10
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 10
EOF

kubectl patch deployment backend -n humor-game --patch-file startup-probe-patch.yaml
```

### Step 6: Test Health Check Behavior

``` bash
# Simulate an unhealthy application
kubectl exec deployment/backend -n humor-game -- kill -STOP 1

# Watch how Kubernetes handles the unhealthy pod
kubectl get pods -n humor-game -l app=backend -w
```

**Expected behavior:** Kubernetes will mark the pod as not ready and
eventually restart it.

``` bash
# Restore the application
kubectl exec deployment/backend -n humor-game -- kill -CONT 1
```

## Configure Blue-Green Deployment (Simulation)

### Step 7: Simulate Blue-Green Strategy

``` bash
# Create a "green" version of your deployment
kubectl get deployment backend -n humor-game -o yaml > backend-green.yaml

# Edit the green deployment
sed -i 's/name: backend/name: backend-green/g' backend-green.yaml
sed -i 's/app: backend/app: backend-green/g' backend-green.yaml

# Deploy green version
kubectl apply -f backend-green.yaml
```

### Step 8: Test Blue-Green Switch

``` bash
# Check both versions are running
kubectl get pods -n humor-game -l app=backend
kubectl get pods -n humor-game -l app=backend-green
```

``` bash
# Switch traffic by updating service selector
kubectl patch service backend -n humor-game -p='{"spec":{"selector":{"app":"backend-green"}}}'

# Test the switch
curl -H "Host: localhost" http://localhost:8080/api/health
```

``` bash
# Switch back to blue (original)
kubectl patch service backend -n humor-game -p='{"spec":{"selector":{"app":"backend"}}}'

# Clean up green deployment
kubectl delete deployment backend-green -n humor-game
```

## Implement Canary Deployment Pattern

### Step 9: Set Up Canary Deployment

``` bash
# Scale down main deployment
kubectl scale deployment backend --replicas=2 -n humor-game

# Create canary deployment (1 replica with new version)
cat > backend-canary.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend-canary
  namespace: humor-game
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
      version: canary
  template:
    metadata:
      labels:
        app: backend
        version: canary
    spec:
      containers:
      - name: backend
        image: humor-game-backend:latest
        env:
        - name: CANARY_VERSION
          value: "true"
        # ... rest of container spec similar to main deployment
EOF

kubectl apply -f backend-canary.yaml
```

### Step 10: Test Canary Traffic Distribution

``` bash
# Check traffic distribution (should be ~33% canary, 67% main)
for i in {1..10}; do
  kubectl exec deployment/backend -n humor-game -- curl -s http://backend:3001/api/health | grep -o '"version":"[^"]*"' || echo "main"
done
```

**Expected:** Mix of main and canary responses

## Configure Deployment Rollback

### Step 11: Test Deployment Rollback

``` bash
# Check rollout history
kubectl rollout history deployment/backend -n humor-game
```

``` bash
# Simulate a bad deployment
kubectl set image deployment/backend backend=nginx:alpine -n humor-game

# Watch it fail
kubectl rollout status deployment/backend -n humor-game --timeout=60s
```

**Expected:** Deployment will hang because nginx doesn't pass health
checks

``` bash
# Rollback to previous version
kubectl rollout undo deployment/backend -n humor-game

# Verify rollback
kubectl rollout status deployment/backend -n humor-game
```

**Expected Output:**

``` bash
deployment "backend" successfully rolled out
```

### Step 12: Automated Rollback with Health Checks

``` bash
# Configure automatic rollback on failed health checks
kubectl patch deployment backend -n humor-game -p='{"spec":{"progressDeadlineSeconds":300}}'
```

## Implement Deployment Validation

### Step 13: Create Deployment Tests

``` bash
# Create smoke test script
cat > deployment-smoke-test.sh << 'EOF'
#!/bin/bash
set -e

echo "Running deployment smoke tests..."

# Test health endpoint
HEALTH_RESPONSE=$(curl -s -w "%{http_code}" http://localhost:8080/api/health -o /tmp/health_response)
if [ "$HEALTH_RESPONSE" != "200" ]; then
    echo "Health check failed with status: $HEALTH_RESPONSE"
    exit 1
fi

# Test frontend
FRONTEND_RESPONSE=$(curl -s -w "%{http_code}" http://localhost:8080 -o /tmp/frontend_response)
if [ "$FRONTEND_RESPONSE" != "200" ]; then
    echo "Frontend check failed with status: $FRONTEND_RESPONSE"
    exit 1
fi

# Test API functionality
API_RESPONSE=$(curl -s -w "%{http_code}" http://localhost:8080/api/leaderboard -o /tmp/api_response)
if [ "$API_RESPONSE" != "200" ]; then
    echo "API check failed with status: $API_RESPONSE"
    exit 1
fi

echo "All smoke tests passed!"
EOF

chmod +x deployment-smoke-test.sh
```

### Step 14: Run Deployment Validation

``` bash
# Run smoke tests
./deployment-smoke-test.sh
```

**Expected Output:**

``` bash
Running deployment smoke tests...
All smoke tests passed!
```

## Monitoring Deployment Health

### Step 15: Monitor Deployment Metrics

``` bash
# Check deployment health in Prometheus
kubectl port-forward svc/prometheus -n monitoring 9090:9090 &

# Query deployment success rate
curl -s 'http://localhost:9090/api/v1/query?query=kube_deployment_status_replicas_available{deployment="backend"}' | jq .
```

### Step 16: Set Up Deployment Alerts

``` bash
# Add deployment monitoring alerts
cat > deployment-alerts.yaml << 'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: deployment-alert-rules
  namespace: monitoring
data:
  deployment.rules: |
    groups:
    - name: deployment.rules
      rules:
      - alert: DeploymentReplicasMismatch
        expr: kube_deployment_spec_replicas != kube_deployment_status_replicas_available
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: Deployment has mismatched replicas
          description: "Deployment {{ $labels.deployment }} has {{ $value }} available replicas, expected {{ $labels.spec_replicas }}"
      
      - alert: DeploymentRolloutStuck
        expr: kube_deployment_status_condition{condition="Progressing",status="false"} == 1
        for: 10m
        labels:
          severity: critical
        annotations:
          summary: Deployment rollout is stuck
          description: "Deployment {{ $labels.deployment }} rollout is not progressing"
EOF

kubectl apply -f deployment-alerts.yaml
```

##  Checkpoint

Your deployment strategy is production-ready when: -  Rolling updates
complete without downtime -  Health checks prevent bad deployments
from receiving traffic -  Rollback procedures work quickly and
reliably -  Deployment validation tests pass consistently -  Canary
deployments can route percentage-based traffic -  Monitoring alerts
fire for deployment issues -  Documentation covers all deployment
procedures

## Troubleshooting Deployment Issues

### Issue: Rolling Update Hangs

**Symptom:** Deployment shows "Waiting for deployment rollout to finish"

**Diagnosis:**

``` bash
# Check deployment events
kubectl describe deployment backend -n humor-game

# Check pod events
kubectl describe pods -l app=backend -n humor-game
```

**Common Causes:** - Readiness probe failures - Resource constraints -
Image pull errors

**Fix:**

``` bash
# Check resource availability
kubectl top nodes

# Verify health check endpoints
kubectl logs -l app=backend -n humor-game

# Rollback if necessary
kubectl rollout undo deployment/backend -n humor-game
```

### Issue: Health Checks Fail After Deployment

**Symptom:** Pods restart frequently or show not ready

**Diagnosis:**

``` bash
# Check probe configuration
kubectl describe deployment backend -n humor-game | grep -A 5 "Liveness\|Readiness"

# Check application logs
kubectl logs -l app=backend -n humor-game --previous
```

**Fix:**

``` bash
# Adjust probe timing if application needs more startup time
# Verify health check endpoint works correctly
# Update application to handle health checks properly
```

### Issue: Slow Rollbacks

**Symptom:** Rollback takes too long during incidents

**Diagnosis:**

``` bash
# Check rollout history size
kubectl rollout history deployment/backend -n humor-game

# Check deployment strategy settings
kubectl describe deployment backend -n humor-game | grep Strategy
```

**Fix:**

``` bash
# Optimize rolling update settings
# Implement blue-green for critical applications
# Pre-position rollback versions
```

## Advanced Deployment Patterns

### Feature Flags

``` bash
# Example using environment variables for feature flags
kubectl patch deployment backend -n humor-game -p='{"spec":{"template":{"spec":{"containers":[{"name":"backend","env":[{"name":"FEATURE_NEW_GAME_MODE","value":"enabled"}]}]}}}}'
```

### Multi-Region Deployments

``` bash
# Example multi-region deployment coordination
# Deploy to staging region first
# Validate with automated tests
# Deploy to production regions with staggered rollout
```

### Database Migration Coordination

``` bash
# Example database migration strategy
# 1. Deploy backward-compatible schema changes
# 2. Deploy application code
# 3. Remove old schema elements in next release
```

## What You Learned

You've implemented professional deployment strategies:

**Deployment Fundamentals:** - **Rolling Updates**: Zero-downtime
deployments with gradual replacement - **Health Checks**: Preventing bad
deployments from receiving traffic - **Rollback Procedures**: Quick
recovery from failed deployments - **Deployment Validation**: Automated
testing of deployment success

**Advanced Patterns:** - **Blue-Green Deployments**: Instant traffic
switching for critical systems - **Canary Releases**: Risk mitigation
through gradual rollouts - **Feature Flags**: Decoupling deployment from
feature activation - **Multi-Environment Coordination**: Staged
deployment across environments

**Operational Excellence:** - **Monitoring and Alerting**: Visibility
into deployment health - **Automated Validation**: Smoke tests and
health verification - **Documentation**: Runbooks for deployment
procedures - **Incident Response**: Quick rollback and recovery
procedures

**Career-Ready Skills:** - **Release Engineering**: Managing complex
deployment pipelines - **Site Reliability**: Maintaining service
availability during deployments - **Risk Management**: Balancing
deployment speed with reliability - **Operational Excellence**: Building
repeatable, reliable deployment processes

These deployment strategies enable you to release software safely and
efficiently, maintaining high availability while minimizing risk to
production systems.

------------------------------------------------------------------------

**Next**: [Chapter 12: Troubleshooting Production
Issues](12-troubleshooting.md) - Diagnose and resolve complex system
problems **Previous**: [Chapter 10: Production Hardening and
Security](10-prod-hardening.md) - Securing applications for production

# Chapter 12: Troubleshooting Production Issues

*Master systematic troubleshooting techniques for complex Kubernetes and
application problems*

------------------------------------------------------------------------

## What You'll Learn

- Develop systematic troubleshooting methodologies
- Use kubectl and monitoring tools for diagnosis
- Debug common Kubernetes and application issues
- Build troubleshooting runbooks and documentation
- Practice incident response procedures

## Time Required: 45 minutes

## Prerequisites: [Chapter 11: Deployment Strategies](11-deployment-strategies.md)

------------------------------------------------------------------------

## Why This Matters

Production systems fail in complex ways. The ability to quickly diagnose
and resolve issues is what separates experienced engineers from
beginners. This chapter teaches you the systematic approach that
professionals use to handle production incidents.

**Professional Context**: Mean Time To Recovery (MTTR) is a key SRE
metric. Companies measure engineer effectiveness by how quickly they can
diagnose and fix production issues.

** Pro Tip**: Good troubleshooting is about following a systematic
methodology, not just trying random fixes. Professionals gather
information first, then form hypotheses.

## Systematic Troubleshooting Methodology

### The OODA Loop for Troubleshooting

    Observe  Orient  Decide  Act

1.  **Observe**: Gather symptoms and data
2.  **Orient**: Form hypotheses based on evidence
3.  **Decide**: Choose the most likely cause to investigate
4.  **Act**: Test the hypothesis and gather more data

## Essential Troubleshooting Commands

### Step 1: Master Core Diagnostic Commands

``` bash
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

``` bash
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

``` bash
NAME                        READY   STATUS    RESTARTS   AGE
backend-7c8b9d4f6d-xyz12    0/1     Pending   0          5m
```

**Diagnostic Commands:**

``` bash
# Check pod events
kubectl describe pod backend-7c8b9d4f6d-xyz12 -n humor-game

# Check node resources
kubectl describe nodes
kubectl top nodes
```

**Common Causes & Fixes:**

``` bash
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

``` bash
NAME                        READY   STATUS             RESTARTS   AGE
backend-7c8b9d4f6d-xyz12    0/1     CrashLoopBackOff   5          10m
```

**Diagnostic Commands:**

``` bash
# Check container logs
kubectl logs backend-7c8b9d4f6d-xyz12 -n humor-game
kubectl logs backend-7c8b9d4f6d-xyz12 -n humor-game --previous

# Check container exit codes
kubectl describe pod backend-7c8b9d4f6d-xyz12 -n humor-game | grep "Exit Code"
```

**Common Causes & Fixes:**

``` bash
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

``` bash
# Test service connectivity
kubectl run debug-pod --image=busybox --rm -it -- sh

# Inside debug pod:
# wget -qO- --timeout=5 http://backend.humor-game.svc.cluster.local:3001/api/health
# nslookup backend.humor-game.svc.cluster.local
```

**Common Causes & Fixes:**

``` bash
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

``` bash
# Check ingress controller
kubectl get pods -n ingress-nginx
kubectl logs -l app.kubernetes.io/name=ingress-nginx -n ingress-nginx

# Check ingress resource
kubectl describe ingress humor-game-ingress -n humor-game
```

**Fixes:**

``` bash
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

``` bash
NAME           STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
postgres-pvc   Pending                                      local-path     5m
```

**Diagnostic Commands:**

``` bash
# Check PVC events
kubectl describe pvc postgres-pvc -n humor-game

# Check storage class
kubectl get storageclass
kubectl describe storageclass local-path
```

**Fixes:**

``` bash
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

``` bash
# Check resource usage
kubectl top pods -n humor-game
kubectl top nodes

# Check application metrics
curl http://localhost:8080/api/health
curl http://localhost:8080/metrics
```

**Investigation Steps:**

``` bash
# 1. Database performance
kubectl exec -it deployment/postgres -n humor-game -- psql -U gameuser -d humor_memory_game -c "SELECT * FROM pg_stat_activity;"

# 2. Cache hit rates
kubectl exec -it deployment/redis -n humor-game -- redis-cli info stats

# 3. Application logs for slow queries
kubectl logs -l app=backend -n humor-game | grep -i "slow\|timeout"
```

## Incident Response Procedures

### Step 3: Create Incident Response Runbook

``` bash
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

``` bash
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

``` bash
# Simulate memory pressure (careful in production!)
kubectl run memory-hog --image=progrium/stress --rm -it -- --vm 1 --vm-bytes 2G --timeout 60s

# Monitor impact
kubectl top nodes
kubectl get pods -n humor-game
```

#### Scenario 3: Image Pull Failure

``` bash
# Simulate bad image
kubectl set image deployment/backend backend=nonexistent:latest -n humor-game

# Observe and rollback
kubectl get pods -n humor-game -w
kubectl rollout undo deployment/backend -n humor-game
```

## Advanced Debugging Techniques

### Step 5: Debug Pod Filesystem

``` bash
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

``` bash
# ArgoCD shows application as OutOfSync
kubectl get applications -n argocd
```

**Diagnosis:**

``` bash
# Check ArgoCD application status
kubectl describe application humor-game-app -n argocd

# Check sync status
kubectl get application humor-game-app -n argocd -o yaml | grep -A 10 "status"
```

**Common Causes & Fixes:**

``` bash
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

``` bash
# Check sync logs
kubectl logs -l app.kubernetes.io/name=argocd-server -n argocd | grep -i "sync"

# Check application events
kubectl get events -n argocd --sort-by=.metadata.creationTimestamp
```

**Fixes:**

``` bash
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

``` bash
# Check tunnel status
cloudflared tunnel list

# Check tunnel logs
cloudflared tunnel run gameapp-tunnel --loglevel debug
```

**Fixes:**

``` bash
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

``` bash
# Check Prometheus targets
kubectl port-forward svc/prometheus -n monitoring 9090:9090 &
curl http://localhost:9090/api/v1/targets

# Check service discovery
kubectl get pods -n humor-game --show-labels
kubectl get svc -n humor-game
```

**Fixes:**

``` bash
# 1. Restart Prometheus
kubectl rollout restart deployment/prometheus -n monitoring

# 2. Check service annotations
kubectl describe svc backend -n humor-game | grep -A 5 "Annotations"

# 3. Verify metrics endpoint
kubectl exec -it deployment/backend -n humor-game -- curl localhost:3001/metrics
```

### Step 6: Network Debugging

``` bash
# Create debugging pod with network tools
kubectl run netdebug --image=nicolaka/netshoot --rm -it -- bash

# Inside netdebug pod:
# nslookup backend.humor-game.svc.cluster.local
# telnet backend.humor-game.svc.cluster.local 3001
# curl -v http://backend.humor-game.svc.cluster.local:3001/api/health
```

### Step 7: Resource Debugging

``` bash
# Check resource limits and usage
kubectl describe pods -n humor-game | grep -A 5 "Limits\|Requests"

# Check HPA behavior
kubectl describe hpa -n humor-game

# Check events for resource issues
kubectl get events -n humor-game | grep -i "insufficient\|evicted\|oom"
```

## Monitoring Integration

### Step 8: Use Prometheus for Troubleshooting

``` bash
# Access Prometheus for metrics investigation
kubectl port-forward svc/prometheus -n monitoring 9090:9090 &

# Key queries for troubleshooting:
# up{job="humor-game-backend"}                    # Service availability
# rate(http_requests_total[5m])                   # Request rate
# container_memory_usage_bytes                    # Memory usage
# kube_pod_container_status_restarts_total        # Restart count
```

### Step 9: Create Troubleshooting Dashboards

``` bash
# Create Grafana dashboard for troubleshooting
# Include panels for:
# - Pod status and restarts
# - Resource usage trends
# - Error rate trends
# - Network connectivity
# - Database performance
```

##  Checkpoint

Your troubleshooting capabilities are ready when: -  You can
systematically diagnose pod, network, and storage issues - 
Troubleshooting toolkit script provides quick cluster overview - 
Incident response runbook covers common scenarios -  You can use
kubectl effectively for debugging -  Monitoring integration supports
troubleshooting workflows -  You've practiced common failure
scenarios -  Documentation captures tribal knowledge

## Building Troubleshooting Expertise

### Troubleshooting Checklist

``` bash
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

1.  **Cascading Failures**: One component failure causes others to fail
2.  **Resource Exhaustion**: CPU/memory/disk limits reached
3.  **Configuration Drift**: Manual changes not reflected in code
4.  **Dependency Failures**: External services unavailable
5.  **Deployment Issues**: Bad releases causing instability

## What You Learned

You've developed professional troubleshooting skills:

**Troubleshooting Methodology:** - **Systematic Approach**: OODA loop
for structured problem-solving - **Information Gathering**: Using
kubectl and monitoring for diagnosis - **Hypothesis Testing**:
Scientific approach to finding root causes - **Documentation**:
Capturing knowledge for future incidents

**Technical Skills:** - **Kubernetes Debugging**: Pod, service, and
ingress troubleshooting - **Application Debugging**: Log analysis and
performance investigation - **Network Debugging**: Connectivity and
routing problem resolution - **Resource Debugging**: CPU, memory, and
storage issue diagnosis

**Operational Excellence:** - **Incident Response**: Structured approach
to production incidents - **Runbook Creation**: Documenting procedures
for common issues - **Post-Incident Learning**: Continuous improvement
through reflection - **Team Communication**: Effective incident
communication patterns

**Career-Ready Capabilities:** - **Site Reliability Engineering**:
Production system troubleshooting - **DevOps Operations**: End-to-end
system debugging - **Platform Engineering**: Infrastructure problem
resolution - **Technical Leadership**: Guiding teams through complex
incidents

These troubleshooting skills are essential for maintaining production
systems and are highly valued by employers looking for experienced
engineers who can handle complex technical challenges.

------------------------------------------------------------------------

**Next**: [Chapter 13: Interview Preparation
Guide](13-interview-prep.md) - Leverage your project experience for
DevOps engineering interviews **Previous**: [Chapter 11: Deployment
Strategies](11-deployment-strategies.md) - Zero-downtime deployment
patterns

# Chapter 13: Interview Preparation Guide

*Leverage your project experience for DevOps engineering interviews*

------------------------------------------------------------------------

## What You'll Learn

- Present your project effectively in technical interviews
- Answer common DevOps interview questions with confidence
- Demonstrate hands-on experience with real examples
- Prepare for system design and architecture discussions
- Build compelling narratives around your technical skills

## Time Required: 30 minutes

## Prerequisites: Complete Chapters 1-12

------------------------------------------------------------------------

## Why This Matters

Technical interviews for DevOps roles focus on practical experience, not
just theoretical knowledge. Your Humor Memory Game project demonstrates
real production skills that employers value. This chapter helps you
articulate that experience effectively.

**Professional Context**: Hiring managers look for candidates who can
hit the ground running. Your project proves you understand the complete
software delivery lifecycle from development to production.

** Pro Tip**: The best interview answers combine technical depth with
business impact. Always connect your technical choices to real-world
outcomes.

## Project Overview for Interviews

### Elevator Pitch (30 seconds)

*"I built a production-grade Kubernetes application that demonstrates
end-to-end DevOps practices. The project includes a multi-service
Node.js memory game with PostgreSQL and Redis, deployed using GitOps
with ArgoCD, comprehensive monitoring with Prometheus and Grafana, and
production security hardening. It showcases the complete journey from
local development to global production deployment."*

### Key Technical Achievements

**Infrastructure:** -  **Multi-service Kubernetes deployment** with 4
microservices -  **GitOps automation** with ArgoCD for reliable
deployments -  **Production monitoring** with Prometheus and Grafana
dashboards -  **Security hardening** with network policies and
security contexts -  **CI/CD pipeline** with automated testing and
deployment

**Career Impact:** -  **Portfolio project** demonstrating
enterprise-grade DevOps skills -  **Production experience** with real
monitoring and troubleshooting -  **System design knowledge** of
scalable application architecture -  **Operational skills** for
maintaining production systems

## Common Interview Questions and Answers

### Technical Architecture Questions

**Q: "Walk me through the architecture of your Kubernetes project."**

**Your Answer:** *"I designed a production-ready architecture with four
main components. The frontend is a vanilla JavaScript application served
by nginx, which communicates with a Node.js backend API. The backend
connects to PostgreSQL for persistent data and Redis for caching. All
components run in Kubernetes with proper resource limits, health checks,
and security contexts.*

*For external access, I use an nginx ingress controller with SSL
termination. The monitoring stack includes Prometheus for metrics
collection and Grafana for visualization. GitOps deployment is handled
by ArgoCD, which watches a Git repository and automatically syncs
changes to the cluster.*

*The entire system is designed for high availability with horizontal pod
autoscaling, network policies for security, and comprehensive
observability for troubleshooting."*

**Follow-up topics to be ready for:** - Database connection pooling and
optimization - Cache invalidation strategies - Service discovery in
Kubernetes - Load balancing and traffic routing

**Q: "How do you ensure zero-downtime deployments?"**

**Your Answer:** *"I implemented rolling updates with proper readiness
and liveness probes. The readiness probe ensures new pods only receive
traffic when they're fully ready to serve requests. The liveness probe
detects unhealthy pods and restarts them automatically.*

*The rolling update strategy uses maxUnavailable: 25% and maxSurge: 25%,
which means Kubernetes gradually replaces old pods with new ones while
maintaining service availability. I also configured startup probes for
the backend to handle slow initialization.*

*For database schema changes, I use a blue-green approach where I deploy
backward-compatible changes first, then remove deprecated fields in a
subsequent release. This ensures the application can always connect to
the database during transitions."*

### DevOps Process Questions

**Q: "Describe your CI/CD pipeline."**

**Your Answer:** *"My pipeline follows GitOps principles with four main
stages. First, code changes trigger automated tests including unit
tests, linting, and security scanning with Trivy. Second, successful
tests trigger image builds that are tagged with commit SHA and pushed to
GitHub Container Registry.*

*Third, the pipeline automatically updates the GitOps repository with
new image tags, which creates an audit trail of all deployments.
Finally, ArgoCD detects the Git changes and syncs them to the Kubernetes
cluster.*

*This approach separates build and deployment concerns, provides
complete traceability, and enables easy rollbacks by reverting Git
commits. The entire process is automated but includes manual approval
gates for production deployments."*

**Q: "How do you monitor and troubleshoot your application?"**

**Your Answer:** *"I use a comprehensive observability stack. Prometheus
collects metrics from the application, Kubernetes cluster, and
infrastructure. The Node.js backend exposes custom metrics for business
KPIs like game completions and user registrations.*

*Grafana dashboards display the four golden signals: latency, traffic,
errors, and saturation. I created custom dashboards for application
performance, infrastructure health, and business metrics.*

*For troubleshooting, I follow a systematic approach: check pod status,
review recent events, analyze logs, and verify service connectivity.
I've documented common issues and their solutions in runbooks, and I use
kubectl extensively for real-time diagnosis."*

### Security and Operations Questions

**Q: "What security measures did you implement?"**

**Your Answer:** *"I implemented defense-in-depth security with multiple
layers. At the pod level, all containers run as non-root users with
read-only filesystems and dropped capabilities. Resource limits prevent
resource exhaustion attacks.*

*For network security, I use network policies to implement
micro-segmentation, ensuring that only authorized service-to-service
communication is allowed. The ingress controller handles SSL termination
and security headers.*

*Secrets are managed through Kubernetes secrets rather than environment
variables, and I've implemented regular security scanning of container
images. The monitoring system alerts on security events like privilege
escalation attempts or policy violations."*

**Q: "How do you handle disasters and incidents?"**

**Your Answer:** *"I designed the system with resilience in mind. Data
is backed up regularly with automated PostgreSQL dumps, and I use
persistent volumes for stateful services. The GitOps approach means I
can recreate the entire environment from Git repositories.*

*For incident response, I have documented runbooks for common scenarios
and maintain monitoring dashboards that help identify issues quickly.
The horizontal pod autoscaler handles traffic spikes automatically, and
I can quickly scale services manually if needed.*

*Post-incident, I conduct blameless post-mortems to identify
improvements and update runbooks with new learnings. The goal is to
learn from every incident and make the system more resilient."*

## System Design Questions

### Q: "How would you scale this application to handle 10x traffic?"

**Your Answer:** *"I'd approach this systematically across multiple
layers. First, I'd implement horizontal scaling with more aggressive HPA
settings and add node autoscaling to handle the increased pod count.*

*For the database layer, I'd implement read replicas to distribute query
load and connection pooling to handle more concurrent connections
efficiently. Redis clustering would handle cache scaling.*

*At the application level, I'd implement caching at multiple layers: CDN
for static assets, Redis for application data, and potentially
application-level caching for expensive operations.*

*Infrastructure-wise, I'd move to a multi-region deployment with
geographic load balancing, implement database sharding if needed, and
use managed services for databases to handle scaling automatically.*

*The monitoring system would need enhancement with more detailed metrics
and automated alerting for capacity planning."*

### Q: "Design a multi-environment deployment strategy."

**Your Answer:** *"I'd extend the current GitOps approach with
environment-specific overlays using Kustomize. The structure would have
a base configuration and overlays for dev, staging, and production
environments.*

*Development would use a single replica for each service with relaxed
resource limits. Staging would mirror production configuration but with
smaller resource allocations. Production would have multiple replicas,
strict resource limits, and additional security controls.*

*The CI/CD pipeline would deploy to environments in sequence: dev 
staging  production, with automated testing at each stage. Production
deployments would require manual approval and include comprehensive
smoke tests.*

*Environment isolation would be achieved through separate namespaces and
network policies, with different monitoring and alerting configurations
for each environment."*

## Behavioral Questions

### Q: "Tell me about a time you had to troubleshoot a complex issue."

**Your Answer:** *"While implementing the GitOps workflow, I encountered
a problem where ArgoCD would detect configuration changes but
deployments would fail silently. The application would show as 'Synced'
but pods weren't updating.*

*I started by checking ArgoCD logs and noticed permission errors. I
discovered that the service account didn't have sufficient RBAC
permissions to update deployments. The issue was subtle because ArgoCD
could read the configurations but couldn't apply changes.*

*I systematically verified each component: the Git repository was
correct, the Kustomize build worked locally, but the cluster sync
failed. By reviewing the ArgoCD project configuration, I found the
missing RBAC permissions.*

*The solution was updating the ClusterRole to include deployment update
permissions. This taught me the importance of understanding RBAC in
Kubernetes and testing GitOps workflows thoroughly. I now always verify
permissions as part of the setup process."*

### Q: "How do you stay current with DevOps technologies?"

**Your Answer:** *"I believe in hands-on learning combined with
community engagement. For this project, I chose technologies based on
current industry standards: Kubernetes for orchestration, Prometheus for
monitoring, and GitOps for deployment.*

*I regularly read the CNCF landscape updates and follow key maintainers
on platforms like Twitter and LinkedIn. I also participate in local
Kubernetes meetups and watch conference talks from KubeCon.*

*Most importantly, I apply new concepts in practice. This project let me
experiment with ArgoCD, which I hadn't used before, and implement
security practices I'd read about but never applied.*

*I maintain a learning backlog of technologies I want to explore next,
like service mesh with Istio and advanced monitoring with distributed
tracing."*

## Technical Deep Dives

### Q: "Explain how your monitoring system works."

**Your Answer:** *"The monitoring architecture follows the pull model.
Prometheus scrapes metrics from multiple sources: the Node.js
application exposes custom metrics on /metrics, Kubernetes API provides
cluster metrics, and node-exporter provides infrastructure metrics.*

*I configured service discovery so Prometheus automatically finds new
pods with the proper annotations. The application metrics include RED
metrics (Rate, Errors, Duration) and business metrics like game sessions
and user activity.*

*Grafana connects to Prometheus as a data source and displays multiple
dashboards: infrastructure overview, application performance, and
business KPIs. I use PromQL for complex queries and set up alerting
rules for critical thresholds.*

*The system includes retention policies to manage storage and
performance. In production, I'd add log aggregation with tools like Loki
for complete observability."*

### Q: "How does your GitOps workflow ensure reliability?"

**Your Answer:** *"GitOps provides reliability through declarative
configuration and audit trails. All infrastructure changes go through
Git, which provides version control, peer review, and rollback
capabilities.*

*ArgoCD continuously compares the cluster state with Git and can detect
configuration drift. If someone makes manual changes, ArgoCD shows the
difference and can automatically correct it.*

*The workflow includes health checks at every stage: CI tests before
merging, image scanning after building, and smoke tests after
deployment. Failed deployments are automatically rolled back.*

*The separation of build and deployment phases means deployments are
more predictable. Image builds happen once and the same artifact is
deployed across environments, reducing environment-specific issues.*

*For disaster recovery, I can recreate the entire environment from Git
repositories, ensuring we never lose configuration state."*

## Portfolio Presentation Tips

### Demonstrating Your Project

**Live Demo Script:** 1. **Show the application** running and explain
the user experience 2. **Display Grafana dashboards** to show monitoring
in action 3. **Trigger a deployment** through GitOps to show automation
4. **Demonstrate troubleshooting** by scaling a service and showing
metrics 5. **Show security features** like network policies and resource
limits

**Key Points to Emphasize:** - This is a **production-ready system**,
not a learning exercise - You understand the **complete software
delivery lifecycle** - You can **operate and maintain** complex
systems - You've implemented **industry best practices** for security
and reliability

### Documentation to Prepare

**GitHub Repository:** - Clear README with setup instructions -
Architecture diagrams and screenshots - Comprehensive troubleshooting
guide - Links to live demos (if available)

**Interview Portfolio:** - Project overview slides - Architecture
diagrams - Key metrics and achievements - Lessons learned and
improvements planned

## Mock Interview Practice

### Technical Interview Simulation

**Practice these scenarios:** 1. **System design discussion**: Draw the
architecture on a whiteboard 2. **Troubleshooting exercise**: Walk
through diagnosing a pod failure 3. **Security deep dive**: Explain your
defense-in-depth approach 4. **Scaling discussion**: How to handle 10x
traffic growth 5. **GitOps explanation**: Why you chose this deployment
approach

### Questions to Ask Interviewers

**Show your engagement and understanding:** 1. *"What's your current
approach to infrastructure automation?"* 2. *"How do you handle secrets
management in your Kubernetes environments?"* 3. *"What monitoring and
alerting strategies do you use?"* 4. *"How do you ensure security
compliance in your deployments?"* 5. *"What's your deployment frequency
and rollback strategy?"*

## What You've Accomplished

Your project demonstrates professional-level DevOps skills:

**Technical Competencies:** - **Container Orchestration**: Kubernetes
deployment and management - **Infrastructure as Code**: Declarative
configuration with GitOps - **Monitoring and Observability**:
Production-grade metrics and alerting - **Security**: Enterprise
security controls and best practices - **CI/CD**: Automated testing and
deployment pipelines

**Operational Excellence:** - **System Design**: Scalable, resilient
architecture - **Troubleshooting**: Systematic problem-solving
approach - **Documentation**: Comprehensive runbooks and guides - **Best
Practices**: Industry-standard patterns and procedures

**Career Readiness:** - **Portfolio Project**: Demonstrable production
skills - **Real Experience**: Hands-on with enterprise technologies -
**Problem-Solving**: Ability to handle complex technical challenges -
**Communication**: Can explain technical decisions and trade-offs

This project provides concrete examples for every major aspect of DevOps
engineering interviews. You're prepared to discuss architecture,
operations, security, and troubleshooting with the confidence that comes
from hands-on experience.

------------------------------------------------------------------------

**Next**: [Appendix A: Glossary of Terms](appendix-a-glossary.md) -
Technical terms and definitions **Previous**: [Chapter 12:
Troubleshooting Production Issues](12-troubleshooting.md) - Systematic
problem-solving techniques

# Chapter 14: Next Steps - Your DevOps Journey

*From learning to production: Building your DevOps career*

------------------------------------------------------------------------

## What You'll Learn

- Career pathways in DevOps and platform engineering
- Advanced topics to explore next
- Building a professional portfolio
- Contributing to open source projects
- Continuous learning strategies

## Time Required: 15 minutes

## Prerequisites: All previous chapters completed

------------------------------------------------------------------------

## Congratulations! You've Built Something Amazing

You've successfully deployed a production-grade application stack that
demonstrates enterprise-level DevOps practices. This isn't just a
tutorial completion - you've built a portfolio project that showcases
real-world skills.

### What You've Accomplished

**Technical Achievements:** -  Multi-service application with proper
separation of concerns -  Kubernetes orchestration with production
configurations -  Comprehensive monitoring and observability - 
GitOps automation with ArgoCD -  Global accessibility through CDN
integration -  Security hardening with network policies -  Automated
CI/CD pipeline with security scanning

**Professional Skills:** -  Infrastructure as Code practices - 
Troubleshooting complex distributed systems -  Documentation and
knowledge sharing -  Security-first mindset -  Automation and
efficiency focus

## Career Pathways in DevOps

### DevOps Engineer Roles

**Junior DevOps Engineer (\$70,000 - \$90,000)** - Focus on CI/CD
pipeline maintenance - Basic Kubernetes operations - Monitoring and
alerting setup - Infrastructure automation scripts

**Mid-Level DevOps Engineer (\$90,000 - \$130,000)** - Architecture
design and implementation - Advanced Kubernetes features (HPA, network
policies) - Security hardening and compliance - Team collaboration and
mentoring

**Senior DevOps Engineer (\$130,000 - \$180,000)** - Platform
architecture and strategy - Cross-team collaboration and leadership -
Advanced automation and tooling - Incident response and post-mortem
analysis

**Principal/Staff Engineer (\$180,000+)** - Technical strategy and
vision - Cross-functional team leadership - Advanced system design -
Industry thought leadership

### Specialization Paths

**Site Reliability Engineering (SRE)** - Focus on reliability,
performance, and scalability - Advanced monitoring and alerting - Chaos
engineering and resilience testing - Capacity planning and cost
optimization

**Platform Engineering** - Developer experience and productivity -
Internal tooling and automation - Self-service infrastructure -
Developer workflow optimization

**Security Engineering** - DevSecOps and security automation -
Compliance and governance - Threat modeling and risk assessment -
Security tooling and processes

**Cloud Architecture** - Multi-cloud strategies - Cost optimization and
governance - Advanced networking and security - Disaster recovery and
business continuity

## Advanced Topics to Explore

### Immediate Next Steps (1-3 months)

**Service Mesh Implementation** - Istio or Linkerd for advanced
networking - Traffic management and security policies - Observability
and distributed tracing - Canary deployments and traffic splitting

**Advanced Kubernetes Features** - Custom Resource Definitions (CRDs) -
Operators for application lifecycle management - Advanced scheduling and
resource management - Multi-cluster management strategies

**Infrastructure as Code** - Terraform for cloud resource management -
Pulumi for programmatic infrastructure - Crossplane for
Kubernetes-native infrastructure - Policy as Code with Open Policy Agent
(OPA)

### Medium-term Goals (3-6 months)

**Observability and Monitoring** - Distributed tracing with Jaeger or
Zipkin - Log aggregation with ELK stack - Advanced Prometheus and
Grafana techniques - Chaos engineering with Chaos Monkey

**Security and Compliance** - Container image scanning and vulnerability
management - Runtime security with Falco - Compliance frameworks (SOC 2,
PCI DSS) - Zero-trust security models

**Advanced Automation** - GitOps with Flux or ArgoCD advanced features -
Policy engines and governance - Advanced CI/CD patterns - Infrastructure
testing and validation

### Long-term Aspirations (6+ months)

**Cloud-Native Architecture** - Serverless and event-driven
architectures - Microservices patterns and anti-patterns - Event
sourcing and CQRS - Advanced data patterns

**Leadership and Strategy** - Technical leadership and mentoring -
Architecture decision records (ADRs) - Cross-functional team
collaboration - Industry conference speaking

## Building Your Professional Portfolio

### GitHub Portfolio Strategy

**Project Organization**

    your-username/
     devops-portfolio/
        kubernetes-production-app/     # This project
        terraform-infrastructure/      # Infrastructure as Code
        monitoring-dashboards/          # Grafana dashboards
        automation-scripts/             # DevOps utilities
     learning-projects/
        docker-mastery/                # Docker deep dive
        kubernetes-security/           # Security hardening
        ci-cd-patterns/               # Pipeline examples
     contributions/
         kubernetes/                    # K8s contributions
         prometheus/                    # Monitoring tools
         argocd/                       # GitOps tools

**Documentation Standards** - Comprehensive README files with
architecture diagrams - Step-by-step setup instructions -
Troubleshooting guides and common issues - Performance benchmarks and
metrics - Security considerations and best practices

### Professional Networking

**Online Communities** - Kubernetes Slack channels (#kubernetes-users,
#prometheus) - DevOps subreddit and Discord servers - LinkedIn DevOps
groups - GitHub discussions and issues

**Local Meetups and Conferences** - Kubernetes Community Days - DevOps
meetups in your area - Cloud-native conferences (KubeCon, PromCon) -
Local tech user groups

**Contributing to Open Source** - Start with documentation
improvements - Bug fixes and feature requests - Creating useful tools
and utilities - Mentoring other contributors

## Continuous Learning Strategies

### Structured Learning Paths

**Certification Programs** - Certified Kubernetes Administrator (CKA) -
Certified Kubernetes Security Specialist (CKS) - AWS Certified DevOps
Engineer - Google Cloud Professional DevOps Engineer

**Hands-on Practice** - Build increasingly complex projects - Contribute
to open source projects - Participate in coding challenges - Create your
own tools and utilities

**Knowledge Sharing** - Write technical blog posts - Create video
tutorials - Speak at meetups and conferences - Mentor junior developers

### Staying Current

**Industry Resources** - CNCF landscape and project updates - Kubernetes
release notes and features - DevOps tooling announcements - Security
advisories and updates

**Learning Platforms** - Linux Academy / A Cloud Guru - Pluralsight
DevOps courses - Kubernetes.io official documentation - Cloud provider
learning paths

## Real-World Application

### Applying These Skills

**At Your Current Job** - Propose infrastructure improvements -
Implement monitoring and alerting - Automate manual processes - Improve
deployment pipelines

**In Interviews** - Use this project as a talking point - Demonstrate
problem-solving skills - Show understanding of production systems -
Discuss trade-offs and alternatives

**For Freelance/Consulting** - Offer DevOps transformation services -
Help companies migrate to Kubernetes - Implement monitoring and
observability - Provide security assessments

## Common Career Mistakes to Avoid

### Technical Mistakes

- Focusing only on tools without understanding principles
- Not documenting your work and decisions
- Ignoring security and compliance requirements
- Not implementing proper monitoring and alerting

### Career Mistakes

- Not building a professional network
- Not contributing to open source projects
- Not staying current with industry trends
- Not developing soft skills alongside technical skills

## Your DevOps Journey Continues

### Immediate Actions (This Week)

1.  **Update your LinkedIn** with DevOps skills and this project
2.  **Create a portfolio website** showcasing your projects
3.  **Join DevOps communities** and start participating
4.  **Plan your next project** based on areas you want to explore

### This Month

1.  **Apply for DevOps positions** using this project as experience
2.  **Start contributing** to open source projects
3.  **Attend local meetups** and network with professionals
4.  **Begin certification study** for your chosen path

### This Quarter

1.  **Complete a certification** in your chosen specialization
2.  **Build a second project** focusing on different technologies
3.  **Write technical content** and share your knowledge
4.  **Mentor someone** just starting their DevOps journey

## Final Thoughts

You've built something remarkable. This project demonstrates not just
technical skills, but the mindset and approach of a professional DevOps
engineer. You understand:

- **Systems thinking**: How components work together
- **Automation mindset**: Eliminating manual processes
- **Security awareness**: Building secure systems by design
- **Monitoring importance**: Observing and understanding system behavior
- **Documentation value**: Making systems maintainable
- **Continuous improvement**: Always looking for better ways

These are the qualities that make great DevOps engineers. You're not
just following tutorials - you're thinking like a platform engineer who
designs systems for scale, reliability, and maintainability.

**Your journey from beginner to production-ready DevOps engineer is
complete. Now it's time to apply these skills in the real world and
continue growing.**

------------------------------------------------------------------------

**Previous**: [Chapter 13: Interview
Preparation](13-interview-prep/chapter.md) - Preparing for DevOps
interviews **Back to**: [Chapter 1: Introduction](01-intro/chapter.md) -
What you've built and learned
