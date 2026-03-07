# Book Images Directory

This directory contains image placeholders referenced throughout the book. When creating the actual book, replace these placeholders with real screenshots and diagrams.

## Image List by Chapter

### Chapter 1: Introduction
- Game interface showing 4x4 card grid with game stats

### Chapter 2: Architecture Overview  
- Complete technical architecture diagram showing all components and connections
- User interaction flow diagram from browser to database
- Learning journey flow progression diagram

### Chapter 3: Environment Setup
- Terminal output showing successful hello-world Docker container
- GitHub repository settings showing workflow permissions

### Chapter 4: Local Multi-Container Development
- Docker build output showing successful image creation
- Browser screenshot showing game interface via Docker Compose

### Chapter 5: Kubernetes Basics
- kubectl get nodes output showing 3-node cluster

### Chapter 6: Production Networking and Ingress
- Browser screenshot showing game interface accessible via ingress

### Chapter 7: CI/CD Pipeline Implementation
- GitHub Actions workflow running with all stages

### Chapter 8: Observability
- Prometheus UI showing discovered targets and service discovery
- Grafana login screen and initial dashboard
- Grafana Kubernetes dashboard showing cluster metrics

### Chapter 9: GitOps
- ArgoCD login screen with admin credentials
- ArgoCD sync process showing the sync button and confirmation
- ArgoCD showing OutOfSync status with drift details

### Chapter 12: Troubleshooting
- kubectl diagnostic command outputs
- Pod failure scenarios and resolution steps

### Chapter 13: Interview Preparation
- Architecture diagrams for interview presentations
- Sample dashboard screenshots

## Image Format Guidelines

- **Screenshots**: PNG format, 1920x1080 or similar high resolution
- **Diagrams**: SVG preferred for scalability, PNG as backup
- **Terminal output**: Use consistent color scheme, readable font size
- **UI screenshots**: Include browser chrome for context
- **Architecture diagrams**: Clear labels, consistent styling

## Capturing Instructions

1. **Terminal Screenshots**: Use consistent theme and font size
2. **Browser Screenshots**: Include URL bar and page title
3. **UI Elements**: Highlight important buttons/fields with arrows or callouts
4. **Diagrams**: Use consistent color scheme matching the project branding
5. **Code Examples**: Syntax highlighting for readability

## File Naming Convention

- `ch01-game-interface.png`
- `ch02-architecture-overview.svg`
- `ch03-docker-hello-world.png`
- `ch05-k8s-nodes.png`
- etc.

When creating the final book, ensure all image references in the markdown files point to the actual image files in this directory.
