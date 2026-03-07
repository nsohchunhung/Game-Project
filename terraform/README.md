# AWS Infrastructure as Code

This directory contains modularized Terraform configurations for deploying the Humor Memory Game to AWS with production-grade infrastructure.

## Architecture Overview

- **Hub and Spoke VPC**: Central hub VPC with spoke VPCs for different environments
- **Private EKS Cluster**: Accessible only via bastion host
- **Multi-AZ Deployment**: High availability across multiple availability zones
- **VPC Endpoints**: Private connectivity to AWS services
- **Autoscaling**: Cluster autoscaler and HPA for cost-effective scaling
- **GitOps**: ArgoCD for automated deployments
- **Observability**: Prometheus, Grafana, CloudWatch integration
- **Security**: DevSecOps with Trivy, Falco, OPA Gatekeeper
- **Self-Hosted CI/CD**: GitHub Actions runner on EC2

## Directory Structure

```
terraform/
├── README.md                 # This file
├── main.tf                   # Root module configuration
├── variables.tf              # Root variables
├── outputs.tf                # Root outputs
├── terraform.tfvars.example  # Example variables file
├── modules/
│   ├── vpc/                  # Hub and spoke VPC architecture
│   ├── eks/                  # EKS cluster with private endpoint
│   ├── bastion/              # Bastion host for secure access
│   ├── vpc-endpoints/        # VPC endpoints for AWS services
│   ├── rds/                  # RDS PostgreSQL (optional, can use EKS)
│   ├── elasticache/         # ElastiCache Redis (optional, can use EKS)
│   ├── observability/       # Prometheus, Grafana, CloudWatch
│   ├── security/            # Security groups, IAM, policies
│   ├── github-runner/       # Self-hosted GitHub Actions runner
│   └── argocd/              # ArgoCD infrastructure
└── environments/
    ├── dev/
    ├── staging/
    └── prod/
```

## Quick Start

1. **Copy example variables file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Edit terraform.tfvars with your values:**
   - AWS region
   - Project name
   - GitHub repository details
   - Domain name (if applicable)

3. **Initialize Terraform:**
   ```bash
   cd terraform
   terraform init
   ```

4. **Plan deployment:**
   ```bash
   terraform plan
   ```

5. **Apply infrastructure:**
   ```bash
   terraform apply
   ```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.5.0
- kubectl installed
- Helm 3.x installed
- Access to create VPCs, EKS clusters, and related resources

## Cost Optimization

- Spot instances for non-critical workloads
- Reserved capacity for predictable workloads
- Auto-scaling to scale down during low usage
- Multi-AZ for HA without over-provisioning
- VPC endpoints to reduce NAT Gateway costs

## Security Features

- Private EKS endpoint (no public access)
- Bastion host for secure access
- VPC endpoints for private AWS service access
- Network policies and security groups
- IAM roles with least privilege
- Secrets management via AWS Secrets Manager
- Encryption at rest and in transit

## Monitoring and Observability

- Prometheus for metrics collection
- Grafana for visualization
- CloudWatch for AWS service metrics
- Centralized logging with CloudWatch Logs
- Alerting via CloudWatch Alarms and PagerDuty/SNS

## GitOps Workflow

1. Code changes trigger CI pipeline
2. Images built and pushed to ECR
3. GitOps repository updated with new image tags
4. ArgoCD detects changes and syncs to cluster
5. Application deployed with zero downtime

## Troubleshooting

See [docs/aws-troubleshooting.md](../../docs/aws-troubleshooting.md) for common issues and solutions.

