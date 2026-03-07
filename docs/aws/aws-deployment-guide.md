# AWS Deployment Guide

This guide walks you through deploying the Humor Memory Game to AWS using the modularized Terraform infrastructure.

## Architecture Overview

The AWS infrastructure includes:

- **Hub and Spoke VPC Architecture**: Central hub VPC with spoke VPCs for different services
- **Private EKS Cluster**: Accessible only via bastion host
- **Multi-AZ Deployment**: High availability across 3 availability zones
- **VPC Endpoints**: Private connectivity to AWS services (ECR, S3, etc.)
- **Autoscaling**: Cluster autoscaler and HPA for cost-effective scaling
- **GitOps**: ArgoCD for automated deployments
- **Observability**: Prometheus, Grafana, and CloudWatch integration
- **Security**: DevSecOps with Trivy, Falco, OPA Gatekeeper
- **Self-Hosted CI/CD**: GitHub Actions runner on EC2

## Prerequisites

1. **AWS Account** with appropriate permissions
2. **AWS CLI** configured with credentials
3. **Terraform** >= 1.5.0 installed
4. **kubectl** installed
5. **Helm** 3.x installed
6. **SSH Key Pair** created in AWS EC2
7. **GitHub Personal Access Token** for runner registration

## Step 1: Configure Terraform Variables

1. Copy the example variables file:
   ```bash
   cd terraform
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your values:
   ```hcl
   aws_region  = "us-east-1"
   project_name = "devops-home-lab"
   environment  = "prod"
   
   bastion_key_pair_name = "your-key-pair-name"
   bastion_allowed_cidr_blocks = ["YOUR_IP/32"]  # Restrict to your IP!
   
   github_runner_token = "your-github-runner-token"
   ```

## Step 2: Initialize and Plan

```bash
cd terraform
terraform init
terraform plan
```

Review the plan carefully. It will create:
- Hub and spoke VPCs
- EKS cluster
- Bastion host
- VPC endpoints
- Security groups and IAM roles
- GitHub runner (if enabled)

## Step 3: Apply Infrastructure

```bash
terraform apply
```

This will take approximately 20-30 minutes. The output will include:
- EKS cluster name and endpoint
- Bastion host public IP
- kubectl configuration command

## Step 4: Configure kubectl

From your local machine (or via bastion):

```bash
aws eks update-kubeconfig --region us-east-1 --name devops-home-lab-prod-eks
```

Verify access:
```bash
kubectl get nodes
```

## Step 5: Deploy Cluster Autoscaler

```bash
kubectl apply -f k8s/cluster-autoscaler.yaml
```

Update the cluster name in the deployment if different.

## Step 6: Deploy ArgoCD

ArgoCD should be deployed automatically by Terraform. Verify:

```bash
kubectl get pods -n argocd
```

Access ArgoCD (from bastion):
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Get admin password:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Step 7: Deploy Observability Stack

Prometheus and Grafana should be deployed automatically. Verify:

```bash
kubectl get pods -n monitoring
```

Access Grafana (from bastion):
```bash
kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80
```

Default credentials: admin/admin (change on first login)

## Step 8: Configure GitHub Runner

If you enabled the GitHub runner, it should be automatically configured. Verify in GitHub:
- Settings > Actions > Runners

The runner should appear with the labels you specified.

## Step 9: Create ECR Repositories

```bash
aws ecr create-repository --repository-name devops-home-lab-backend --region us-east-1
aws ecr create-repository --repository-name devops-home-lab-frontend --region us-east-1
```

## Step 10: Configure GitHub Secrets

Add these secrets to your GitHub repository:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_ACCOUNT_ID`

## Step 11: Deploy Application via ArgoCD

1. Access ArgoCD UI (via port-forward from bastion)
2. Create an Application pointing to your GitOps repository
3. Or use the Terraform-created application if `create_application = true`

## Step 12: Deploy Security Tools (Optional)

### OPA Gatekeeper
```bash
helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm install gatekeeper gatekeeper/gatekeeper --namespace gatekeeper-system --create-namespace
kubectl apply -f k8s/security/opa-gatekeeper.yaml
```

### Falco
```bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm install falco falcosecurity/falco --namespace falco --create-namespace
kubectl apply -f k8s/security/falco.yaml
```

## Accessing the Infrastructure

### Via Bastion Host

1. SSH to bastion:
   ```bash
   ssh -i your-key.pem ec2-user@<bastion-public-ip>
   ```

2. From bastion, configure kubectl:
   ```bash
   aws eks update-kubeconfig --region us-east-1 --name devops-home-lab-prod-eks
   ```

3. Access services via port-forward:
   - ArgoCD: `kubectl port-forward svc/argocd-server -n argocd 8080:443`
   - Grafana: `kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80`
   - Prometheus: `kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 9090:9090`

## Cost Optimization

The infrastructure is designed for cost-effectiveness:

- **Spot Instances**: Application node group uses spot instances
- **VPC Endpoints**: Reduces NAT Gateway costs
- **Auto-scaling**: Scales down during low usage
- **Multi-AZ**: HA without over-provisioning

Estimated monthly cost: $150-300 (depending on usage)

## Troubleshooting

### EKS Cluster Not Accessible

1. Verify bastion security group allows your IP
2. Check EKS endpoint configuration (should be private only)
3. Verify kubectl is configured correctly

### GitHub Runner Not Appearing

1. Check runner logs: `ssh to runner and check /home/ec2-user/actions-runner/_diag`
2. Verify GitHub token is valid
3. Check security group allows outbound HTTPS

### ArgoCD Sync Issues

1. Check ArgoCD application status in UI
2. Verify Git repository is accessible
3. Check image pull secrets if using private registry

## Cleanup

To destroy all infrastructure:

```bash
cd terraform
terraform destroy
```

**Warning**: This will delete all resources including data!

## Next Steps

1. Configure custom domain and ingress
2. Set up alerting in Grafana
3. Configure backup for persistent volumes
4. Set up CI/CD pipeline for automated deployments
5. Implement additional security policies

## Support

For issues or questions:
- Check [troubleshooting guide](08-troubleshooting.md)
- Review Terraform module documentation
- Open GitHub issue

