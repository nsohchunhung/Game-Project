# Local Development Maintenance Guide

Guide for maintaining and updating your local development environment and Kubernetes cluster.

## Table of Contents

1. [Regular Maintenance](#regular-maintenance)
2. [Updating Applications](#updating-applications)
3. [Cleaning Up Resources](#cleaning-up-resources)
4. [Resetting Environment](#resetting-environment)
5. [Troubleshooting](#troubleshooting)

## Regular Maintenance

### Daily Tasks

1. **Check Running Services**:
   ```bash
   # Docker Compose
   docker-compose ps
   
   # Kubernetes
   kubectl get pods --all-namespaces
   ```

2. **Review Logs**:
   ```bash
   # Docker Compose
   docker-compose logs --tail=100
   
   # Kubernetes
   kubectl logs -f deployment/backend -n humor-game
   ```

### Weekly Tasks

1. **Clean Up Docker**:
   ```bash
   # Remove unused images
   docker image prune -a
   
   # Remove unused volumes
   docker volume prune
   
   # Remove unused networks
   docker network prune
   ```

2. **Clean Up Kubernetes**:
   ```bash
   # Remove completed jobs
   kubectl delete job --field-selector=status.successful=1 --all-namespaces
   
   # Remove failed pods
   kubectl delete pod --field-selector=status.phase=Failed --all-namespaces
   ```

3. **Update Tools**:
   ```bash
   # Update kubectl
   brew upgrade kubectl
   
   # Update k3d
   brew upgrade k3d
   
   # Update Helm
   brew upgrade helm
   ```

## Updating Applications

### Docker Compose Updates

1. **Rebuild Images**:
   ```bash
   docker-compose build --no-cache
   docker-compose up -d
   ```

2. **Update Specific Service**:
   ```bash
   docker-compose up -d --no-deps --build backend
   ```

3. **Pull Latest Images**:
   ```bash
   docker-compose pull
   docker-compose up -d
   ```

### Kubernetes Updates

1. **Update Deployment**:
   ```bash
   # Edit deployment
   kubectl edit deployment backend -n humor-game
   
   # Or apply updated YAML
   kubectl apply -f k8s/backend.yaml
   ```

2. **Rolling Update**:
   ```bash
   # Update image
   kubectl set image deployment/backend \
     backend=your-image:new-tag \
     -n humor-game
   
   # Watch rollout
   kubectl rollout status deployment/backend -n humor-game
   ```

3. **Rollback if Needed**:
   ```bash
   kubectl rollout undo deployment/backend -n humor-game
   ```

## Cleaning Up Resources

### Docker Compose Cleanup

```bash
# Stop and remove containers
docker-compose down

# Remove volumes (deletes data!)
docker-compose down -v

# Remove everything including images
docker-compose down --rmi all -v
```

### Kubernetes Cleanup

```bash
# Delete all resources in namespace
kubectl delete namespace humor-game

# Delete specific resources
kubectl delete deployment backend -n humor-game
kubectl delete service backend -n humor-game

# Clean up PVCs
kubectl delete pvc --all -n humor-game

# Clean up completed jobs
kubectl delete job --all -n humor-game
```

### Complete Reset

```bash
# Delete k3d cluster
k3d cluster delete humor-game

# Recreate cluster
k3d cluster create humor-game

# Redeploy
kubectl apply -f k8s/
```

## Resetting Environment

### Full Reset (Docker Compose)

```bash
# Stop everything
docker-compose down -v

# Remove all data
docker volume rm $(docker volume ls -q | grep humor)

# Rebuild and start
docker-compose build
docker-compose up -d
```

### Full Reset (Kubernetes)

```bash
# Delete cluster
k3d cluster delete humor-game

# Remove local images (optional)
docker rmi $(docker images | grep humor-game | awk '{print $3}')

# Recreate cluster
k3d cluster create humor-game

# Redeploy
kubectl apply -f k8s/
```

## Troubleshooting

### Common Maintenance Issues

1. **Port Already in Use**:
   ```bash
   # Find process using port
   lsof -i :8080
   
   # Kill process
   kill -9 <PID>
   ```

2. **Disk Space Issues**:
   ```bash
   # Check Docker disk usage
   docker system df
   
   # Clean up
   docker system prune -a --volumes
   ```

3. **Kubernetes Resources Exhausted**:
   ```bash
   # Check resource usage
   kubectl top nodes
   kubectl top pods --all-namespaces
   
   # Scale down if needed
   kubectl scale deployment backend --replicas=1 -n humor-game
   ```

## Next Steps

- [Troubleshooting Guide](./08-troubleshooting.md) - Detailed troubleshooting
- [User Guide](./user-guide.md) - Using the application
- [Customization Guide](./customization-guide.md) - Customizing configuration

