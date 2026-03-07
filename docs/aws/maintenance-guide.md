# AWS Infrastructure Maintenance Guide

Complete guide for maintaining, updating, and operating the AWS-deployed infrastructure.

## Table of Contents

1. [Regular Maintenance Tasks](#regular-maintenance-tasks)
2. [Updating Infrastructure](#updating-infrastructure)
3. [Updating Applications](#updating-applications)
4. [Backup and Recovery](#backup-and-recovery)
5. [Monitoring and Alerts](#monitoring-and-alerts)
6. [Scaling Operations](#scaling-operations)
7. [Security Updates](#security-updates)
8. [Cost Optimization](#cost-optimization)
9. [Disaster Recovery](#disaster-recovery)

## Regular Maintenance Tasks

### Daily Tasks

1. **Check Application Health**:
   ```bash
   # From bastion
   kubectl get pods -n humor-game
   kubectl get pods -n monitoring
   kubectl get pods -n argocd
   ```

2. **Review Error Logs**:
   ```bash
   # Backend logs
   kubectl logs -f deployment/backend -n humor-game --tail=100
   
   # Check for errors
   kubectl logs deployment/backend -n humor-game | grep -i error
   ```

3. **Monitor Resource Usage**:
   ```bash
   kubectl top nodes
   kubectl top pods --all-namespaces
   ```

### Weekly Tasks

1. **Review Grafana Dashboards**:
   - Access: `kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80`
   - Check: Request rates, error rates, response times
   - Review: Database and Redis connection metrics

2. **Check ArgoCD Sync Status**:
   ```bash
   kubectl get applications -n argocd
   kubectl get applications -n argocd -o wide
   ```

3. **Review AWS Costs**:
   - Check AWS Cost Explorer
   - Review unexpected charges
   - Optimize unused resources

4. **Security Scan**:
   ```bash
   # Check for security updates
   kubectl get pods -n humor-game -o jsonpath='{.items[*].spec.containers[*].image}'
   
   # Review security group rules
   aws ec2 describe-security-groups --filters "Name=tag:Project,Values=devops-home-lab"
   ```

### Monthly Tasks

1. **Update Kubernetes Components**:
   - Review EKS add-on versions
   - Update cluster autoscaler
   - Update ArgoCD, Prometheus, Grafana

2. **Database Maintenance**:
   - Review RDS performance insights
   - Check database size and growth
   - Review slow query logs

3. **Backup Verification**:
   - Verify RDS automated backups
   - Test backup restoration process
   - Review backup retention policies

4. **Documentation Updates**:
   - Update runbooks
   - Document any custom changes
   - Review and update procedures

## Updating Infrastructure

### Terraform Updates

1. **Review Changes**:
   ```bash
   cd terraform/environments/prod
   terraform plan
   ```

2. **Apply Updates**:
   ```bash
   terraform apply
   ```

3. **Verify Changes**:
   ```bash
   # Check EKS cluster
   aws eks describe-cluster --name <cluster-name>
   
   # Check RDS instance
   aws rds describe-db-instances --db-instance-identifier <rds-id>
   ```

### EKS Cluster Updates

1. **Update Cluster Version**:
   ```bash
   # Check current version
   aws eks describe-cluster --name <cluster-name> --query 'cluster.version'
   
   # Update (via Terraform)
   # Edit terraform/variables.tf: eks_cluster_version = "1.29"
   terraform apply
   ```

2. **Update Node Groups**:
   ```bash
   # Scale node groups
   # Edit terraform/environments/prod/terraform.tfvars
   # Update node_groups configuration
   terraform apply
   ```

3. **Update EKS Add-ons**:
   ```bash
   # Check current versions
   aws eks list-addons --cluster-name <cluster-name>
   
   # Update via Terraform (edit addon_versions)
   terraform apply
   ```

### RDS Updates

1. **Update RDS Instance Class**:
   ```bash
   # Edit terraform/environments/prod/terraform.tfvars
   rds_instance_class = "db.t3.small"  # Upgrade from micro
   
   terraform apply
   ```

2. **Update PostgreSQL Version**:
   ```bash
   # Edit terraform/modules/rds/variables.tf
   engine_version = "15.5"  # Update from 15.4
   
   terraform apply
   ```

3. **Enable Performance Insights**:
   ```bash
   # Edit terraform/environments/prod/terraform.tfvars
   rds_performance_insights_enabled = true
   
   terraform apply
   ```

## Updating Applications

### Manual Application Updates

1. **Update Image Tags**:
   ```bash
   # Edit gitops-safe/overlays/aws/kustomization.yaml
   images:
     - name: ghcr.io/osomudeya/devops-home-lab-2025-backend
       newTag: v1.2.0  # Update tag
   ```

2. **Apply Changes**:
   ```bash
   kubectl apply -k gitops-safe/overlays/aws/
   ```

3. **Verify Deployment**:
   ```bash
   kubectl rollout status deployment/backend -n humor-game
   kubectl get pods -n humor-game
   ```

### CI/CD Automated Updates

1. **Push Code Changes**:
   ```bash
   git add .
   git commit -m "Update application"
   git push origin main
   ```

2. **CI/CD Pipeline**:
   - GitHub Actions builds new images
   - Images pushed to ECR
   - GitOps manifests updated
   - ArgoCD automatically syncs

3. **Monitor Deployment**:
   ```bash
   # Watch ArgoCD sync
   kubectl get applications -n argocd -w
   
   # Check pod rollout
   kubectl rollout status deployment/backend -n humor-game
   ```

### Rolling Back Updates

1. **Rollback Deployment**:
   ```bash
   # Rollback to previous version
   kubectl rollout undo deployment/backend -n humor-game
   
   # Rollback to specific revision
   kubectl rollout undo deployment/backend -n humor-game --to-revision=2
   ```

2. **Rollback via ArgoCD**:
   - Access ArgoCD UI
   - Select application
   - Click "History" → Select previous revision → "Sync"

3. **Rollback Infrastructure**:
   ```bash
   # Revert Terraform changes
   terraform plan -out=previous.tfplan
   terraform apply previous.tfplan
   ```

## Backup and Recovery

### RDS Backups

1. **Automated Backups**:
   - Enabled by default (7-day retention)
   - Configured in `terraform/modules/rds/main.tf`
   - Backups run during maintenance window

2. **Manual Backup**:
   ```bash
   aws rds create-db-snapshot \
     --db-instance-identifier <rds-id> \
     --db-snapshot-identifier manual-backup-$(date +%Y%m%d)
   ```

3. **Restore from Backup**:
   ```bash
   # List available snapshots
   aws rds describe-db-snapshots --db-instance-identifier <rds-id>
   
   # Restore from snapshot
   aws rds restore-db-instance-from-db-snapshot \
     --db-instance-identifier <new-rds-id> \
     --db-snapshot-identifier <snapshot-id>
   ```

### Kubernetes State Backup

1. **Export Resources**:
   ```bash
   # Backup all resources
   kubectl get all -n humor-game -o yaml > backup-$(date +%Y%m%d).yaml
   
   # Backup specific resources
   kubectl get configmap,secret -n humor-game -o yaml > config-backup.yaml
   ```

2. **Restore from Backup**:
   ```bash
   kubectl apply -f backup-20240101.yaml
   ```

### Terraform State Backup

1. **State is automatically backed up**:
   - S3 versioning enabled
   - Multiple versions retained
   - Access via AWS Console or CLI

2. **Restore Previous State**:
   ```bash
   # List state versions
   aws s3api list-object-versions \
     --bucket <terraform-state-bucket> \
     --prefix prod/terraform.tfstate
   
   # Restore specific version (via Terraform)
   terraform state pull > current.tfstate
   # Download previous version from S3
   terraform state push previous.tfstate
   ```

## Monitoring and Alerts

### Setting Up Alerts

1. **Grafana Alerts**:
   - Access Grafana: `kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80`
   - Navigate to: Alerting → Alert Rules
   - Create alerts for:
     - High error rate
     - Slow response times
     - Pod failures
     - Database connection issues

2. **CloudWatch Alarms**:
   ```bash
   # Create alarm for RDS CPU
   aws cloudwatch put-metric-alarm \
     --alarm-name rds-high-cpu \
     --alarm-description "Alert when RDS CPU > 80%" \
     --metric-name CPUUtilization \
     --namespace AWS/RDS \
     --statistic Average \
     --period 300 \
     --threshold 80 \
     --comparison-operator GreaterThanThreshold \
     --evaluation-periods 2
   ```

3. **Prometheus Alertmanager**:
   - Configure in `k8s/monitoring/alertmanager-config.yaml`
   - Set up notification channels (email, Slack, PagerDuty)

### Monitoring Checklist

- [ ] Application health endpoints responding
- [ ] Error rates within acceptable range
- [ ] Response times meeting SLA
- [ ] Database connections healthy
- [ ] Redis cache hit rate optimal
- [ ] Pod resource usage normal
- [ ] Node capacity adequate
- [ ] RDS performance metrics normal

## Scaling Operations

### Horizontal Pod Autoscaling (HPA)

1. **Check Current HPA**:
   ```bash
   kubectl get hpa -n humor-game
   ```

2. **Update HPA Configuration**:
   ```yaml
   apiVersion: autoscaling/v2
   kind: HorizontalPodAutoscaler
   metadata:
     name: backend-hpa
   spec:
     minReplicas: 2
     maxReplicas: 10
     metrics:
       - type: Resource
         resource:
           name: cpu
           target:
             type: Utilization
             averageUtilization: 70
   ```

3. **Apply HPA**:
   ```bash
   kubectl apply -f hpa-config.yaml
   ```

### Cluster Autoscaling

1. **Check Autoscaler Status**:
   ```bash
   kubectl logs -n kube-system deployment/cluster-autoscaler
   ```

2. **Update Node Group Scaling**:
   ```bash
   # Edit terraform/environments/prod/terraform.tfvars
   node_groups = {
     application = {
       min_size     = 2   # Increase minimum
       max_size     = 20  # Increase maximum
       desired_size = 5   # Set desired
     }
   }
   
   terraform apply
   ```

### Manual Scaling

```bash
# Scale deployment
kubectl scale deployment backend --replicas=5 -n humor-game

# Scale node group (via AWS Console or CLI)
aws eks update-nodegroup-config \
  --cluster-name <cluster-name> \
  --nodegroup-name <nodegroup-name> \
  --scaling-config minSize=2,maxSize=10,desiredSize=4
```

## Security Updates

### Kubernetes Security

1. **Update Container Images**:
   ```bash
   # Check for vulnerabilities
   trivy image <image-name>:<tag>
   
   # Update to patched versions
   # Edit deployment manifests
   kubectl apply -f updated-deployment.yaml
   ```

2. **Rotate Secrets**:
   ```bash
   # Update secrets in AWS Secrets Manager
   aws secretsmanager update-secret \
     --secret-id <secret-arn> \
     --secret-string '{"DB_PASSWORD":"new_password"}'
   
   # External Secrets Operator will sync automatically
   # Or force sync:
   kubectl delete secret humor-game-secrets -n humor-game
   # External Secrets will recreate it
   ```

3. **Update Security Groups**:
   ```bash
   # Review security group rules
   aws ec2 describe-security-groups --group-ids <sg-id>
   
   # Update via Terraform
   terraform apply
   ```

### RDS Security

1. **Rotate Master Password**:
   ```bash
   # Update in Secrets Manager
   aws secretsmanager update-secret \
     --secret-id <db-password-secret-arn> \
     --secret-string "new_secure_password"
   
   # Update RDS
   aws rds modify-db-instance \
     --db-instance-identifier <rds-id> \
     --master-user-password "new_secure_password" \
     --apply-immediately
   ```

2. **Enable Encryption**:
   - Already enabled by default
   - Verify: `aws rds describe-db-instances --query 'DBInstances[*].StorageEncrypted'`

## Cost Optimization

### Regular Cost Reviews

1. **Review Unused Resources**:
   ```bash
   # List all resources
   aws resourcegroupstaggingapi get-resources \
     --tag-filters Key=Project,Values=devops-home-lab
   ```

2. **Optimize Node Groups**:
   - Use spot instances for non-critical workloads
   - Right-size instance types
   - Enable cluster autoscaler to scale down

3. **Review RDS Usage**:
   ```bash
   # Check RDS metrics
   aws cloudwatch get-metric-statistics \
     --namespace AWS/RDS \
     --metric-name CPUUtilization \
     --dimensions Name=DBInstanceIdentifier,Value=<rds-id> \
     --start-time 2024-01-01T00:00:00Z \
     --end-time 2024-01-02T00:00:00Z \
     --period 3600 \
     --statistics Average
   ```

### Cost Optimization Tips

1. **Use Spot Instances**: Already configured for application node group
2. **VPC Endpoints**: Reduce NAT Gateway costs (already configured)
3. **Auto-scaling**: Scale down during low usage
4. **Reserved Instances**: Consider for predictable workloads
5. **Delete Unused Resources**: Regular cleanup of test resources

## Disaster Recovery

### Recovery Procedures

1. **RDS Failure**:
   ```bash
   # Failover to Multi-AZ standby (automatic)
   # Or restore from snapshot
   aws rds restore-db-instance-from-db-snapshot \
     --db-instance-identifier <new-rds-id> \
     --db-snapshot-identifier <snapshot-id>
   ```

2. **EKS Cluster Failure**:
   ```bash
   # Recreate cluster (last resort)
   terraform destroy -target=module.eks
   terraform apply -target=module.eks
   
   # Restore applications
   kubectl apply -k gitops-safe/overlays/aws/
   ```

3. **Data Loss Recovery**:
   ```bash
   # Restore RDS from point-in-time recovery
   aws rds restore-db-instance-to-point-in-time \
     --source-db-instance-identifier <rds-id> \
     --target-db-instance-identifier <restored-rds-id> \
     --restore-time 2024-01-01T12:00:00Z
   ```

### Disaster Recovery Checklist

- [ ] RDS automated backups enabled
- [ ] Terraform state backed up in S3
- [ ] Kubernetes manifests in Git (GitOps)
- [ ] Secrets stored in AWS Secrets Manager
- [ ] Documentation up to date
- [ ] Recovery procedures tested
- [ ] Contact information documented

## Maintenance Windows

### Recommended Schedule

- **Daily**: Health checks, log reviews
- **Weekly**: Dashboard reviews, cost checks
- **Monthly**: Security updates, backup verification
- **Quarterly**: Major version updates, disaster recovery tests

### Maintenance Window Best Practices

1. **Schedule during low-traffic periods**
2. **Notify users in advance**
3. **Test changes in dev first**
4. **Have rollback plan ready**
5. **Document all changes**

## Troubleshooting Maintenance Issues

### Common Issues

1. **Terraform Apply Fails**:
   ```bash
   # Check state lock
   aws dynamodb describe-table --table-name terraform-locks
   
   # Force unlock if needed (careful!)
   terraform force-unlock <lock-id>
   ```

2. **ArgoCD Sync Fails**:
   ```bash
   # Check ArgoCD logs
   kubectl logs -n argocd deployment/argocd-application-controller
   
   # Force sync
   kubectl patch application <app-name> -n argocd \
     -p '{"operation":{"initiatedBy":{"username":"admin"},"sync":{"revision":"HEAD"}}}' \
     --type=merge
   ```

3. **RDS Update Stuck**:
   ```bash
   # Check RDS status
   aws rds describe-db-instances --db-instance-identifier <rds-id>
   
   # Cancel if needed (careful!)
   aws rds cancel-modify-db-instance --db-instance-identifier <rds-id>
   ```

## Next Steps

- [AWS Deployment Guide](./aws-deployment-guide.md) - Initial deployment
- [Troubleshooting](../local/08-troubleshooting.md) - Common issues
- [Monitoring Access Guide](../monitoring-access-guide.md) - Access monitoring tools

