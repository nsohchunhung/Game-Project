# Prod Environment Configuration
# This uses the root main.tf as the production configuration

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

# Use the root module with prod-specific variables
module "infrastructure" {
  source = "../../"

  # Environment
  environment  = "prod"
  project_name = var.project_name
  aws_region   = var.aws_region

  # VPC Configuration
  hub_vpc_cidr    = "10.0.0.0/16"
  spoke_vpc_cidrs = ["10.1.0.0/16"]

  # EKS Configuration
  eks_cluster_version = var.eks_cluster_version

  # Bastion Configuration
  bastion_instance_type     = "t3.micro"
  bastion_key_pair_name     = var.bastion_key_pair_name
  bastion_allowed_cidr_blocks = var.bastion_allowed_cidr_blocks

  # GitHub Runner
  enable_github_runner     = var.enable_github_runner
  github_runner_instance_type = "t3.medium"
  github_runner_token      = var.github_runner_token
  github_runner_labels     = concat(var.github_runner_labels, ["prod"])

  # ArgoCD Configuration
  argocd_git_repo_path = "gitops-safe/overlays/aws"  # Use AWS overlay for prod

  # Observability
  prometheus_version = var.prometheus_version
  grafana_version   = var.grafana_version

  # GitHub Repository
  github_repository = var.github_repository
}

