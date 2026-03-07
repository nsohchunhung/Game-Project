# Dev Environment Configuration
# This is a smaller, cost-optimized setup for development

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
  }
}

# Use the root module with dev-specific variables
module "infrastructure" {
  source = "../../"

  # Environment
  environment = "dev"
  project_name = var.project_name
  aws_region  = var.aws_region

  # VPC Configuration - Smaller CIDR blocks for dev
  hub_vpc_cidr    = "10.10.0.0/16"
  spoke_vpc_cidrs = ["10.11.0.0/16"]

  # EKS Configuration
  eks_cluster_version = var.eks_cluster_version

  # Bastion Configuration
  bastion_instance_type     = "t3.micro"
  bastion_key_pair_name     = var.bastion_key_pair_name
  bastion_allowed_cidr_blocks = var.bastion_allowed_cidr_blocks

  # GitHub Runner - Optional for dev
  enable_github_runner     = var.enable_github_runner
  github_runner_instance_type = "t3.small"  # Smaller for dev
  github_runner_token      = var.github_runner_token
  github_runner_labels    = concat(var.github_runner_labels, ["dev"])

  # ArgoCD Configuration
  argocd_git_repo_path = "gitops-safe/overlays/dev"  # Use dev overlay

  # Node groups - smaller for dev
  node_groups = {
    system = {
      desired_size   = 1
      min_size       = 1
      max_size       = 2
      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
      disk_size      = 30
      labels         = {}
    }
    application = {
      desired_size   = 1
      min_size       = 1
      max_size       = 3
      instance_types = ["t3.small", "t3a.small"]
      capacity_type  = "SPOT"
      disk_size      = 30
      labels         = {}
    }
  }

  # Observability - Lighter for dev
  prometheus_version = var.prometheus_version
  grafana_version   = var.grafana_version

  # GitHub Repository
  github_repository = var.github_repository
}

