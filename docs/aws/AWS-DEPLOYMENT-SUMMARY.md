# AWS Deployment - Complete Infrastructure Summary

## 🎯 Overview

This repository now includes a **production-ready AWS infrastructure** for deploying the Humor Memory Game with enterprise-grade features including:

- ✅ **Modularized Terraform** - Clean, reusable infrastructure modules
- ✅ **Hub and Spoke VPC Architecture** - Centralized networking with isolated environments
- ✅ **Private EKS Cluster** - Accessible only via bastion host
- ✅ **Multi-AZ High Availability** - 3 availability zones for resilience
- ✅ **VPC Endpoints** - Private connectivity to AWS services (no NAT Gateway costs)
- ✅ **Autoscaling** - Cluster autoscaler and HPA for cost optimization
- ✅ **GitOps with ArgoCD** - Automated deployments from Git
- ✅ **Self-Hosted CI/CD** - GitHub Actions runner on EC2
- ✅ **Full Observability** - Prometheus, Grafana, CloudWatch integration
- ✅ **DevSecOps** - Trivy, Falco, OPA Gatekeeper for security
- ✅ **Cost Optimized** - Spot instances, VPC endpoints, auto-scaling

## 📁 Repository Structure

```
terraform/
├── main.tf                    # Root module configuration
├── variables.tf               # Root variables
├── outputs.tf                 # Root outputs
├── terraform.tfvars.example   # Example variables file
├── modules/
│   ├── vpc/                   # Hub and spoke VPC architecture
│   ├── eks/                   # EKS cluster with private endpoint
│   ├── bastion/               # Bastion host for secure access
│   ├── vpc-endpoints/         # VPC endpoints for AWS services
│   ├── security/              # IAM roles, security groups, policies
│   ├── github-runner/         # Self-hosted GitHub Actions runner
│   ├── argocd/                # ArgoCD infrastructure
│   └── observability/         # Prometheus, Grafana, CloudWatch
├── k8s/
│   ├── cluster-autoscaler.yaml
│   └── security/
│       ├── opa-gatekeeper.yaml
│       └── falco.yaml
├── .github/workflows/
│   └── deploy-aws.yml         # CI/CD workflow for self-hosted runner
└── docs/
    ├── aws-deployment-guide.md
    └── aws-architecture.md
```

## 🚀 Quick Start

### 1. Prerequisites

```bash
# Install required tools
brew install terraform kubectl helm awscli  # macOS
# or
sudo apt install terraform kubectl helm awscli  # Linux

# Configure AWS credentials
aws configure

# Create SSH key pair in AWS EC2
aws ecr create-key-pair --key-name devops-home-lab-key --query 'KeyMaterial' --output text > devops-home-lab-key.pem
chmod 400 devops-home-lab-key.pem
```

### 2. Configure Terraform

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

### 3. Deploy Infrastructure

```bash
terraform init
terraform plan
terraform apply
```

### 4. Configure kubectl

```bash
aws eks update-kubeconfig --region us-east-1 --name devops-home-lab-prod-eks
kubectl get nodes
```

### 5. Deploy Application

```bash
# Deploy cluster autoscaler
kubectl apply -f ../k8s/cluster-autoscaler.yaml

# ArgoCD and observability are deployed automatically by Terraform
# Access ArgoCD via port-forward from bastion
```

## 🏗️ Architecture Highlights

### Networking

- **Hub VPC (10.0.0.0/16)**: Central hub with bastion and GitHub runner
- **Spoke VPC (10.1.0.0/16)**: Isolated EKS cluster environment
- **VPC Peering**: Secure connectivity between hub and spoke
- **VPC Endpoints**: Private access to ECR, S3, CloudWatch, etc. (cost savings!)

### Compute

- **EKS Cluster**: Kubernetes 1.28, private endpoint only
- **Node Groups**:
  - System: On-demand t3.medium (2-4 nodes)
  - Application: Spot instances (1-10 nodes, 50-90% cost savings)
- **Bastion**: t3.micro for secure cluster access
- **GitHub Runner**: t3.medium for CI/CD

### Security

- ✅ Private EKS endpoint (no public access)
- ✅ Bastion-only access to cluster
- ✅ VPC endpoints for private AWS service access
- ✅ Network policies for pod-to-pod communication
- ✅ IAM roles with least privilege
- ✅ Encryption at rest (KMS) and in transit (TLS)
- ✅ Image scanning (Trivy) in CI/CD
- ✅ Runtime security (Falco)
- ✅ Policy enforcement (OPA Gatekeeper)

### Observability

- **Prometheus**: Metrics collection (30-day retention)
- **Grafana**: Visualization dashboards
- **CloudWatch**: AWS service metrics and logs
- **EKS Control Plane Logs**: API, audit, authenticator logs

### GitOps

- **ArgoCD**: Automated deployments from Git
- **GitHub Actions**: Build → Push to ECR → Update GitOps → ArgoCD syncs
- **Self-Hosted Runner**: Runs in private subnet, no public access needed

## 💰 Cost Optimization

**Estimated Monthly Cost**: $150-300 (depending on usage)

**Cost Optimization Features**:
1. **Spot Instances**: 50-90% savings on application nodes
2. **VPC Endpoints**: Eliminates NAT Gateway costs (~$32/month per NAT)
3. **Auto-scaling**: Scales down during low usage
4. **Right-sizing**: Appropriate instance types
5. **Multi-AZ**: HA without over-provisioning

## 📊 Monitoring and Alerting

- **Metrics**: Prometheus + Grafana
- **Logs**: CloudWatch Logs
- **Alerts**: Prometheus Alertmanager + CloudWatch Alarms
- **Dashboards**: Custom Grafana dashboards

## 🔒 Security Features

1. **Network Security**:
   - Private EKS endpoint
   - Security groups with least privilege
   - Network policies
   - VPC endpoints (no internet gateway in spoke VPC)

2. **Identity and Access**:
   - IAM roles with least privilege
   - IRSA for pod-level permissions
   - Separate roles for each component

3. **Data Protection**:
   - Encryption at rest (KMS)
   - Encryption in transit (TLS)
   - Secrets management (AWS Secrets Manager)

4. **DevSecOps**:
   - Image scanning (Trivy) in CI/CD
   - Runtime security (Falco)
   - Policy enforcement (OPA Gatekeeper)

## 🚦 CI/CD Workflow

1. **Developer pushes code** → GitHub
2. **GitHub Actions triggers** → Self-hosted runner
3. **Build images** → Docker build
4. **Scan images** → Trivy security scan
5. **Push to ECR** → Amazon Elastic Container Registry
6. **Update GitOps** → Update image tags in manifests
7. **ArgoCD syncs** → Automatic deployment to EKS
8. **Monitor** → Prometheus/Grafana dashboards

## 📚 Documentation

- **[AWS Deployment Guide](docs/aws-deployment-guide.md)** - Step-by-step deployment instructions
- **[AWS Architecture](docs/aws-architecture.md)** - Detailed architecture documentation
- **[Terraform README](terraform/README.md)** - Terraform module documentation

## 🛠️ Maintenance

### Updating Infrastructure

```bash
cd terraform
terraform plan
terraform apply
```

### Updating Applications

1. Push code changes
2. CI/CD pipeline automatically builds and deploys
3. ArgoCD syncs changes to cluster

### Accessing Services

All services are accessed via port-forward from bastion:

```bash
# SSH to bastion
ssh -i devops-home-lab-key.pem ec2-user@<bastion-ip>

# Configure kubectl
aws eks update-kubeconfig --region us-east-1 --name devops-home-lab-prod-eks

# Port-forward services
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80
```

## 🧹 Cleanup

To destroy all infrastructure:

```bash
cd terraform
terraform destroy
```

**⚠️ Warning**: This will delete all resources including data!

## 🎓 Learning Resources

This infrastructure demonstrates:

- **Infrastructure as Code**: Modularized Terraform
- **Cloud Architecture**: Hub and spoke VPC, multi-AZ HA
- **Kubernetes**: EKS, node groups, autoscaling
- **GitOps**: ArgoCD automated deployments
- **CI/CD**: Self-hosted runners, automated pipelines
- **Observability**: Prometheus, Grafana, CloudWatch
- **Security**: DevSecOps, network policies, encryption
- **Cost Optimization**: Spot instances, VPC endpoints, auto-scaling

## 🤝 Contributing

Contributions welcome! Areas for improvement:

- Additional Terraform modules
- Enhanced monitoring dashboards
- Additional security policies
- Cost optimization improvements
- Multi-region deployment

## 📞 Support

For issues or questions:
- Check [troubleshooting guide](docs/08-troubleshooting.md)
- Review Terraform module documentation
- Open GitHub issue

## ✅ Checklist

Before deploying to production:

- [ ] Review and customize `terraform.tfvars`
- [ ] Restrict bastion SSH access to your IP
- [ ] Configure GitHub secrets (AWS credentials)
- [ ] Create ECR repositories
- [ ] Review security groups and network policies
- [ ] Configure backup strategy
- [ ] Set up alerting
- [ ] Test disaster recovery procedures
- [ ] Review cost estimates
- [ ] Document runbooks

---

**Built with ❤️ for production-ready AWS deployments**

