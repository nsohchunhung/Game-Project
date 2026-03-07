# Local Development Documentation

This directory contains all documentation for local development, testing, and learning with Docker Compose and local Kubernetes.

## 📚 Documentation Index

### 🎯 Learning Path (Follow in Order)

| Step | Guide | Description |
|------|-------|-------------|
| **0** | [Learning Path Overview](./00-overview.md) | Complete tutorial roadmap and architecture |
| **1** | [Prerequisites Setup](./01-prereqs.md) | Install Docker, Kubernetes tools, and dev environment |
| **2** | [Docker Multi-Container App](./02-compose.md) | Build your first containerized application |
| **3** | [Kubernetes Production Deployment](./03-k8s-basics.md) | Deploy apps on Kubernetes with databases |
| **4** | [Internet Access & Networking](./04-ingress.md) | Make your app accessible from the internet |
| **5** | [Performance Monitoring](./05-observability.md) | Track app health with Prometheus & Grafana |
| **6** | [Automated Deployments](./06-gitops.md) | Deploy with GitOps automation |

### 📖 Reference Guides

- **[Troubleshooting](./08-troubleshooting.md)** - Common issues and solutions
- **[FAQ](./09-faq.md)** - Frequently asked questions
- **[Glossary](./10-glossary.md)** - Terms and definitions explained
- **[Decision Notes](./11-decision-notes.md)** - Architecture decisions and rationale
- **[Customization Guide](./customization-guide.md)** - Customize configuration and settings
- **[User Guide](./user-guide.md)** - How to access and use the application
- **[Maintenance Guide](./maintenance-guide.md)** - Maintain and update your local environment

## 🚀 Quick Start

### Docker Compose (Simplest)
```bash
docker-compose up -d
# Access at http://localhost:8080
```

### Local Kubernetes (k3d)
```bash
# Create cluster
k3d cluster create humor-game

# Deploy application
kubectl apply -f k8s/

# Access via port-forward
kubectl port-forward svc/frontend -n humor-game 8080:80
```

## 🎯 Learning Objectives

By following these guides, you will learn:
- ✅ Container orchestration with Docker and Kubernetes
- ✅ Multi-container application architecture
- ✅ Kubernetes deployments, services, and ingress
- ✅ Monitoring and observability with Prometheus/Grafana
- ✅ GitOps workflows with ArgoCD
- ✅ Production-ready security practices

## ⏱️ Time Investment

- **Fast Track**: 2-3 hours (experienced users)
- **Guided Learning**: 5-8 hours (recommended for beginners)
- **Deep Dive**: 10+ hours (with all exercises and experiments)

## 🔗 Related Documentation

- **[AWS Deployment](../aws/README.md)** - Production AWS infrastructure
- **[Main Documentation](../README.md)** - Complete documentation hub

