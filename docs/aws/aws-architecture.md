# AWS Infrastructure Architecture

## Overview

This document describes the AWS infrastructure architecture for deploying the Humor Memory Game with production-grade features.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         Internet                                │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           │ SSH (Port 22)
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                    Hub VPC (10.0.0.0/16)                        │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Public Subnets (AZ1, AZ2, AZ3)                          │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │  │
│  │  │   Bastion    │  │   NAT GW 1   │  │   NAT GW 2   │ │  │
│  │  │   Host       │  │              │  │              │ │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘ │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Private Subnets (AZ1, AZ2, AZ3)                         │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │  │
│  │  │ GitHub       │  │              │  │              │ │  │
│  │  │ Runner        │  │              │  │              │ │  │
│  │  └──────────────┘  └──────────────┘  └──────────────┘ │  │
│  └──────────────────────────────────────────────────────────┘  │
└──────────────────────────┬──────────────────────────────────────┘
                           │ VPC Peering
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│              Spoke VPC - EKS (10.1.0.0/16)                      │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Private Subnets (AZ1, AZ2, AZ3)                         │  │
│  │  ┌──────────────────────────────────────────────────────┐ │  │
│  │  │              EKS Cluster (Private)                   │ │  │
│  │  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐│ │  │
│  │  │  │ Node Group   │  │ Node Group   │  │ Node Group  ││ │  │
│  │  │  │ (System)     │  │ (App Spot)   │  │ (App Spot)  ││ │  │
│  │  │  └──────────────┘  └──────────────┘  └──────────────┘│ │  │
│  │  │                                                         │ │  │
│  │  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐│ │  │
│  │  │  │ ArgoCD       │  │ Prometheus   │  │ Grafana      ││ │  │
│  │  │  └──────────────┘  └──────────────┘  └──────────────┘│ │  │
│  │  │                                                         │ │  │
│  │  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐│ │  │
│  │  │  │ Frontend     │  │ Backend      │  │ PostgreSQL   ││ │  │
│  │  │  └──────────────┘  └──────────────┘  └──────────────┘│ │  │
│  │  │  ┌──────────────┐                                     │ │  │
│  │  │  │ Redis        │                                     │ │  │
│  │  │  └──────────────┘                                     │ │  │
│  │  └──────────────────────────────────────────────────────┘ │  │
│  └──────────────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  VPC Endpoints (Private AWS Service Access)              │  │
│  │  • S3 (Gateway)                                           │  │
│  │  • ECR API (Interface)                                    │  │
│  │  • ECR DKR (Interface)                                   │  │
│  │  • EC2 (Interface)                                        │  │
│  │  • SSM (Interface)                                       │  │
│  │  • CloudWatch Logs (Interface)                           │  │
│  │  • STS (Interface)                                       │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## Components

### Networking

#### Hub VPC (10.0.0.0/16)
- **Purpose**: Central networking hub for shared services
- **Public Subnets**: Bastion host, NAT gateways
- **Private Subnets**: GitHub Actions runner
- **Multi-AZ**: 3 availability zones for HA

#### Spoke VPC - EKS (10.1.0.0/16)
- **Purpose**: Isolated EKS cluster environment
- **Private Subnets**: EKS nodes, no public access
- **VPC Peering**: Connected to hub VPC for access
- **Multi-AZ**: 3 availability zones for HA

### Compute

#### EKS Cluster
- **Version**: Kubernetes 1.28
- **Endpoint**: Private only (no public access)
- **Access**: Via bastion host only
- **Node Groups**:
  - **System**: On-demand instances for system workloads (2-4 nodes)
  - **Application**: Spot instances for cost optimization (1-10 nodes)

#### Bastion Host
- **Instance Type**: t3.micro
- **Purpose**: Secure access point to EKS cluster
- **Access**: SSH from allowed CIDR blocks only
- **Pre-installed**: kubectl, AWS CLI, Docker

#### GitHub Actions Runner
- **Instance Type**: t3.medium
- **Purpose**: Self-hosted CI/CD runner
- **Location**: Private subnet in hub VPC
- **Access**: Outbound to GitHub API only

### Storage

#### EBS Volumes
- **Type**: gp3 (SSD)
- **Encryption**: Enabled at rest
- **Backup**: Via EBS snapshots (optional)

#### EKS Persistent Volumes
- **Storage Class**: EBS CSI driver
- **Provisioning**: Dynamic
- **Backup**: Via Velero (optional)

### Security

#### Network Security
- **Security Groups**: Least privilege access
- **Network Policies**: Kubernetes network policies
- **VPC Endpoints**: Private AWS service access
- **No Internet Gateway**: In spoke VPC (uses VPC endpoints)

#### IAM
- **Roles**: Separate roles for EKS cluster, nodes, bastion, runner
- **Policies**: Least privilege access
- **Service Accounts**: IRSA for pod-level permissions

#### Encryption
- **EKS Secrets**: Encrypted with KMS
- **EBS Volumes**: Encrypted at rest
- **In Transit**: TLS for all communications

### Observability

#### Prometheus
- **Purpose**: Metrics collection
- **Retention**: 30 days
- **Storage**: 50Gi persistent volume

#### Grafana
- **Purpose**: Metrics visualization
- **Storage**: 10Gi persistent volume
- **Access**: Via port-forward from bastion

#### CloudWatch
- **Purpose**: AWS service metrics
- **Integration**: CloudWatch exporter in cluster
- **Logs**: EKS control plane logs

### GitOps

#### ArgoCD
- **Version**: 5.46.7
- **Purpose**: Automated deployments
- **Access**: Via port-forward from bastion
- **Sync**: Automatic or manual (configurable)

### CI/CD

#### GitHub Actions
- **Runner**: Self-hosted on EC2
- **Workflow**: Build → Push to ECR → Update GitOps → ArgoCD syncs
- **Security**: Image scanning with Trivy

### Cost Optimization

1. **Spot Instances**: Application node group uses spot (up to 90% savings)
2. **VPC Endpoints**: Reduces NAT Gateway costs
3. **Auto-scaling**: Scales down during low usage
4. **Multi-AZ**: HA without over-provisioning
5. **Right-sizing**: Appropriate instance types for workloads

### High Availability

1. **Multi-AZ**: All components across 3 availability zones
2. **Auto-scaling**: Cluster autoscaler and HPA
3. **Load Balancing**: Kubernetes service load balancing
4. **Health Checks**: Liveness and readiness probes
5. **Rolling Updates**: Zero-downtime deployments

## Access Patterns

### Developer Access
1. SSH to bastion host
2. Configure kubectl from bastion
3. Access services via port-forward

### CI/CD Access
1. GitHub Actions runner in private subnet
2. Pulls code from GitHub
3. Builds and pushes to ECR
4. Updates GitOps repository
5. ArgoCD syncs to cluster

### Application Access
1. Users → Cloudflare CDN → Application Load Balancer → Ingress → Services
2. All traffic encrypted with TLS

## Security Posture

- ✅ Private EKS endpoint (no public access)
- ✅ Bastion-only access to cluster
- ✅ VPC endpoints for private AWS service access
- ✅ Network policies for pod-to-pod communication
- ✅ IAM roles with least privilege
- ✅ Encryption at rest and in transit
- ✅ Image scanning in CI/CD
- ✅ Runtime security with Falco
- ✅ Policy enforcement with OPA Gatekeeper

## Monitoring and Alerting

- **Metrics**: Prometheus + Grafana
- **Logs**: CloudWatch Logs
- **Alerts**: Prometheus Alertmanager + CloudWatch Alarms
- **Dashboards**: Custom Grafana dashboards

## Disaster Recovery

- **Backup**: EBS snapshots, Velero for Kubernetes resources
- **Multi-AZ**: Automatic failover
- **RTO**: < 1 hour
- **RPO**: < 15 minutes

## Cost Estimate

**Monthly Cost (Estimated)**:
- EKS Cluster: $73/month
- EC2 Instances (bastion, runner, nodes): $50-150/month
- EBS Volumes: $20-50/month
- VPC Endpoints: $30-50/month
- Data Transfer: $10-30/month
- **Total**: ~$150-300/month (depending on usage)

**Cost Optimization**:
- Spot instances: 50-90% savings on compute
- VPC endpoints: Reduces NAT Gateway costs
- Auto-scaling: Scales down during low usage
- Reserved capacity: Additional savings for predictable workloads

