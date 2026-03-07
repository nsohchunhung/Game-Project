terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }

  # Optional: Backend configuration for state management
  # Uncomment and configure for remote state
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "devops-home-lab/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Repository  = var.github_repository
    }
  }
}

provider "tls" {}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Local values for common configurations
locals {
  # Common naming prefix
  name_prefix = "${var.project_name}-${var.environment}"

  # Availability zones (use 3 for HA)
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  # VPC CIDR blocks
  hub_vpc_cidr    = var.hub_vpc_cidr
  spoke_vpc_cidrs = var.spoke_vpc_cidrs

  # Common tags
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Hub VPC - Central networking hub
module "vpc_hub" {
  source = "./modules/vpc"

  name                 = "${local.name_prefix}-hub"
  cidr                 = local.hub_vpc_cidr
  availability_zones   = local.azs
  enable_nat_gateway   = true
  single_nat_gateway   = false # Multi-AZ NAT for HA
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Public subnets for bastion, NAT gateways
  public_subnet_cidrs = [
    cidrsubnet(local.hub_vpc_cidr, 4, 0),
    cidrsubnet(local.hub_vpc_cidr, 4, 1),
    cidrsubnet(local.hub_vpc_cidr, 4, 2)
  ]

  # Private subnets for EKS, RDS, etc.
  private_subnet_cidrs = [
    cidrsubnet(local.hub_vpc_cidr, 4, 8),
    cidrsubnet(local.hub_vpc_cidr, 4, 9),
    cidrsubnet(local.hub_vpc_cidr, 4, 10)
  ]

  # Isolated subnets for databases (no internet access)
  isolated_subnet_cidrs = [
    cidrsubnet(local.hub_vpc_cidr, 4, 12),
    cidrsubnet(local.hub_vpc_cidr, 4, 13),
    cidrsubnet(local.hub_vpc_cidr, 4, 14)
  ]

  tags = local.common_tags
}

# Spoke VPC - For EKS cluster (can add more spokes for other services)
module "vpc_spoke_eks" {
  source = "./modules/vpc"

  name                 = "${local.name_prefix}-spoke-eks"
  cidr                 = local.spoke_vpc_cidrs[0]
  availability_zones   = local.azs
  enable_nat_gateway   = false # Use VPC endpoints instead
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Private subnets for EKS nodes
  private_subnet_cidrs = [
    cidrsubnet(local.spoke_vpc_cidrs[0], 4, 0),
    cidrsubnet(local.spoke_vpc_cidrs[0], 4, 1),
    cidrsubnet(local.spoke_vpc_cidrs[0], 4, 2)
  ]

  tags = merge(local.common_tags, {
    Purpose = "EKS"
  })
}

# VPC Peering between Hub and Spoke
resource "aws_vpc_peering_connection" "hub_to_spoke_eks" {
  vpc_id      = module.vpc_hub.vpc_id
  peer_vpc_id = module.vpc_spoke_eks.vpc_id
  auto_accept = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-hub-to-spoke-eks"
  })
}

# Route table updates for peering - Add routes to ALL route tables (multi-AZ)
resource "aws_route" "hub_to_spoke_eks" {
  count = length(module.vpc_hub.private_route_table_ids)

  route_table_id            = module.vpc_hub.private_route_table_ids[count.index]
  destination_cidr_block    = local.spoke_vpc_cidrs[0]
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_spoke_eks.id
}

resource "aws_route" "spoke_eks_to_hub" {
  count = length(module.vpc_spoke_eks.private_route_table_ids)

  route_table_id            = module.vpc_spoke_eks.private_route_table_ids[count.index]
  destination_cidr_block    = local.hub_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_spoke_eks.id
}

# Also add routes to public route tables (for bastion access)
resource "aws_route" "hub_public_to_spoke_eks" {
  count = length(module.vpc_hub.public_route_table_ids)

  route_table_id            = module.vpc_hub.public_route_table_ids[count.index]
  destination_cidr_block    = local.spoke_vpc_cidrs[0]
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_spoke_eks.id
}

# VPC Endpoints for private AWS service access
module "vpc_endpoints" {
  source = "./modules/vpc-endpoints"

  vpc_id             = module.vpc_spoke_eks.vpc_id
  subnet_ids         = module.vpc_spoke_eks.private_subnet_ids
  # S3 gateway endpoint needs ALL route tables (private for nodes)
  route_table_ids    = concat(
    module.vpc_spoke_eks.private_route_table_ids,
    module.vpc_spoke_eks.public_route_table_ids  # Include public if they exist
  )
  security_group_ids = [module.security.eks_node_security_group_id]

  enable_s3_endpoint       = true
  enable_ecr_endpoint      = true
  enable_ecr_api_endpoint  = true
  enable_ec2_endpoint      = true
  enable_ec2_messages_endpoint = true
  enable_ssm_endpoint      = true
  enable_ssm_messages_endpoint = true
  enable_cloudwatch_logs_endpoint = true
  enable_cloudwatch_metrics_endpoint = true
  enable_sts_endpoint      = true
  enable_autoscaling_endpoint = true

  tags = local.common_tags
}

# Security module - IAM roles, security groups, policies
module "security" {
  source = "./modules/security"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc_spoke_eks.vpc_id
  vpc_cidr     = local.spoke_vpc_cidrs[0]

  # EKS cluster configuration
  eks_cluster_name = "${local.name_prefix}-eks"

  # GitHub runner configuration
  github_runner_enabled = var.enable_github_runner

  # Bastion security group (will be created after bastion)
  bastion_security_group_ids = []

  tags = local.common_tags
}

# EKS Cluster
module "eks" {
  source = "./modules/eks"

  cluster_name    = "${local.name_prefix}-eks"
  cluster_version = var.eks_cluster_version

  vpc_id     = module.vpc_spoke_eks.vpc_id
  subnet_ids = module.vpc_spoke_eks.private_subnet_ids

  # Private endpoint configuration
  endpoint_private_access = true
  endpoint_public_access  = false # Private only, access via bastion

  # Cluster logging
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  # Node groups - can be overridden per environment
  node_groups = var.node_groups != null ? var.node_groups : {
    # On-demand nodes for system workloads
    system = {
      desired_size   = 2
      min_size       = 2
      max_size       = 4
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      disk_size      = 50
      labels         = {}
    }
    # Spot nodes for application workloads (cost-effective)
    application = {
      desired_size   = 2
      min_size       = 1
      max_size       = 10
      instance_types = ["t3.medium", "t3a.medium", "t3.small"]
      capacity_type  = "SPOT"
      disk_size      = 50
      labels         = {}
    }
  }

  # IAM roles
  cluster_role_arn = module.security.eks_cluster_role_arn
  node_role_arn    = module.security.eks_node_role_arn

  # Security groups
  cluster_security_group_id = module.security.eks_cluster_security_group_id
  node_security_group_id    = module.security.eks_node_security_group_id

  # Bastion access (will be added after bastion is created)
  bastion_security_group_ids = []

  tags = local.common_tags
}

# Bastion host for secure EKS access
module "bastion" {
  source = "./modules/bastion"

  name              = "${local.name_prefix}-bastion"
  vpc_id            = module.vpc_hub.vpc_id
  subnet_id         = module.vpc_hub.public_subnet_ids[0]
  availability_zone  = local.azs[0]
  instance_type     = var.bastion_instance_type
  key_pair_name     = var.bastion_key_pair_name

  # Allowed CIDR blocks for SSH access
  allowed_cidr_blocks = var.bastion_allowed_cidr_blocks

  tags = local.common_tags
}

# Add bastion access to EKS cluster security group (after bastion is created)
resource "aws_security_group_rule" "eks_cluster_from_bastion" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = module.bastion.security_group_id
  security_group_id        = module.security.eks_cluster_security_group_id
  description              = "HTTPS from bastion to EKS cluster"

  depends_on = [module.bastion, module.security]
}

# Self-hosted GitHub Actions Runner
module "github_runner" {
  count  = var.enable_github_runner ? 1 : 0
  source = "./modules/github-runner"

  name              = "${local.name_prefix}-github-runner"
  vpc_id            = module.vpc_hub.vpc_id
  subnet_id         = module.vpc_hub.private_subnet_ids[0]
  instance_type     = var.github_runner_instance_type
  github_token      = var.github_runner_token
  github_repository = var.github_repository
  github_labels     = var.github_runner_labels

  # Security group allows outbound to internet for GitHub API
  security_group_id = var.enable_github_runner ? module.security.github_runner_security_group_id : null

  tags = local.common_tags
}

# ArgoCD Infrastructure
module "argocd" {
  source = "./modules/argocd"

  cluster_name     = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  cluster_ca       = module.eks.cluster_certificate_authority_data

  # ArgoCD configuration
  argocd_namespace = "argocd"
  argocd_version   = var.argocd_version

  # Git repository configuration
  git_repo_url    = var.argocd_git_repo_url
  git_repo_branch = var.argocd_git_repo_branch
  git_repo_path   = var.argocd_git_repo_path  # Default: gitops-safe/overlays/dev, override for prod: gitops-safe/overlays/aws

  depends_on = [module.eks]
}

# AWS Secrets Manager - Automatic secret generation and storage
module "secrets_manager" {
  source = "./modules/secrets-manager"

  project_name = var.project_name
  environment  = var.environment

  # Secrets will be auto-generated if not provided
  # db_password   = var.db_password   # Optional: provide if you have existing password
  # redis_password = var.redis_password # Optional: provide if you have existing password
  # jwt_secret     = var.jwt_secret     # Optional: provide if you have existing secret

  tags = local.common_tags
}

# OIDC Provider for IRSA - Check if it exists, create if not
data "aws_eks_cluster" "main" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}

data "tls_certificate" "eks" {
  url = data.aws_eks_cluster.main.identity[0].oidc[0].issuer
}

# Check if OIDC provider already exists
data "aws_iam_openid_connect_provider" "existing" {
  count = var.create_oidc_provider ? 0 : 1
  url   = data.aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  count = var.create_oidc_provider ? 1 : 0

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.main.identity[0].oidc[0].issuer

  tags = local.common_tags
}

# Use existing or newly created OIDC provider
locals {
  oidc_provider_arn = var.create_oidc_provider ? aws_iam_openid_connect_provider.eks[0].arn : try(data.aws_iam_openid_connect_provider.existing[0].arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}")
  oidc_issuer_url = replace(data.aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")
}

# IAM Role for External Secrets Operator (IRSA)
resource "aws_iam_role" "external_secrets" {
  name = "${local.name_prefix}-external-secrets-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = local.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${local.oidc_issuer_url}:sub" = "system:serviceaccount:external-secrets-system:external-secrets"
            "${local.oidc_issuer_url}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = local.common_tags

  depends_on = [data.aws_eks_cluster.main]
}

# Attach External Secrets policy to IRSA role
resource "aws_iam_role_policy_attachment" "external_secrets" {
  role       = aws_iam_role.external_secrets.name
  policy_arn = module.secrets_manager.external_secrets_policy_arn
}

# External Secrets Operator - Automatically syncs secrets from AWS Secrets Manager
module "external_secrets" {
  source = "./modules/external-secrets"

  cluster_name     = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  cluster_ca       = module.eks.cluster_certificate_authority_data

  aws_region      = var.aws_region
  irsa_role_arn   = aws_iam_role.external_secrets.arn
  secrets_arn     = module.secrets_manager.humor_game_secrets_arn
  secrets_name    = module.secrets_manager.secret_names.combined

  depends_on = [module.eks, module.secrets_manager]
}

# RDS PostgreSQL (Managed Database)
module "rds" {
  source = "./modules/rds"

  project_name = var.project_name
  environment  = var.environment

  vpc_id  = module.vpc_spoke_eks.vpc_id
  subnet_ids = module.vpc_spoke_eks.private_subnet_ids

  # Security groups
  eks_node_security_group_ids = [module.security.eks_node_security_group_id]
  bastion_security_group_ids  = [module.bastion.security_group_id]

  # Database configuration
  db_name     = var.rds_db_name
  db_username = var.rds_db_username
  db_password = module.secrets_manager.db_password_secret_value

  # Instance configuration
  instance_class = var.rds_instance_class
  multi_az       = var.rds_multi_az

  # Storage
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage

  # KMS encryption
  kms_key_id = var.rds_kms_key_id

  tags = local.common_tags

  depends_on = [module.vpc_spoke_eks, module.security, module.secrets_manager]
}

# Update Secrets Manager with RDS endpoint after RDS is created
# Read existing secret version to preserve REDIS_PASSWORD and JWT_SECRET
data "aws_secretsmanager_secret_version" "initial_secrets" {
  secret_id = module.secrets_manager.humor_game_secrets_arn
  depends_on = [module.secrets_manager]
}

# Create new secret version with RDS connection details merged
resource "aws_secretsmanager_secret_version" "humor_game_secrets_with_rds" {
  secret_id = module.secrets_manager.humor_game_secrets_arn
  
  secret_string = jsonencode(merge(
    jsondecode(data.aws_secretsmanager_secret_version.initial_secrets.secret_string),
    {
      DB_HOST = module.rds.rds_address
      DB_PORT = tostring(module.rds.rds_port)
      DB_NAME = module.rds.db_name
      DB_USER = var.rds_db_username
    }
  ))

  depends_on = [module.rds, data.aws_secretsmanager_secret_version.initial_secrets]
}

# Observability Stack
module "observability" {
  source = "./modules/observability"

  cluster_name     = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  cluster_ca       = module.eks.cluster_certificate_authority_data

  # Prometheus configuration
  prometheus_namespace = "monitoring"
  prometheus_version   = var.prometheus_version

  # Grafana configuration
  grafana_namespace = "monitoring"
  grafana_version   = var.grafana_version

  # CloudWatch integration
  enable_cloudwatch_exporter = true
  aws_region                 = var.aws_region

  depends_on = [module.eks]
}

# Outputs
output "vpc_hub_id" {
  description = "Hub VPC ID"
  value       = module.vpc_hub.vpc_id
}

output "vpc_spoke_eks_id" {
  description = "Spoke EKS VPC ID"
  value       = module.vpc_spoke_eks.vpc_id
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
  sensitive   = true
}

output "bastion_public_ip" {
  description = "Bastion host public IP"
  value       = module.bastion.public_ip
}

output "bastion_ssh_command" {
  description = "SSH command to connect to bastion"
  value       = "ssh -i ${var.bastion_key_pair_name}.pem ec2-user@${module.bastion.public_ip}"
}

output "kubectl_config_command" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "github_runner_ip" {
  description = "GitHub runner private IP"
  value       = var.enable_github_runner ? module.github_runner[0].private_ip : null
}

