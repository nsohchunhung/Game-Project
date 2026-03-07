variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS profile to use (optional)"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "devops-home-lab"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "github_repository" {
  description = "GitHub repository in format owner/repo"
  type        = string
  default     = "Osomudeya/DevOps-Home-Lab-2025"
}

# VPC Configuration
variable "hub_vpc_cidr" {
  description = "CIDR block for hub VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "spoke_vpc_cidrs" {
  description = "CIDR blocks for spoke VPCs"
  type        = list(string)
  default     = ["10.1.0.0/16"] # First spoke for EKS
}

# EKS Configuration
variable "eks_cluster_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.28"
}

# Bastion Configuration
variable "bastion_instance_type" {
  description = "EC2 instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

variable "bastion_key_pair_name" {
  description = "Name of AWS key pair for bastion SSH access"
  type        = string
}

variable "bastion_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to SSH to bastion"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Restrict this in production!
}

# GitHub Runner Configuration
variable "enable_github_runner" {
  description = "Enable self-hosted GitHub Actions runner"
  type        = bool
  default     = true
}

variable "github_runner_instance_type" {
  description = "EC2 instance type for GitHub runner"
  type        = string
  default     = "t3.medium"
}

variable "github_runner_token" {
  description = "GitHub personal access token or runner registration token"
  type        = string
  sensitive   = true
  default     = ""
}

variable "github_runner_labels" {
  description = "Labels for GitHub runner"
  type        = list(string)
  default     = ["self-hosted", "linux", "x64", "aws"]
}

# ArgoCD Configuration
variable "argocd_version" {
  description = "ArgoCD version"
  type        = string
  default     = "5.46.7"
}

variable "argocd_git_repo_url" {
  description = "Git repository URL for ArgoCD"
  type        = string
  default     = "https://github.com/Osomudeya/DevOps-Home-Lab-2025.git"
}

variable "argocd_git_repo_branch" {
  description = "Git branch for ArgoCD"
  type        = string
  default     = "main"
}

variable "argocd_git_repo_path" {
  description = "Path in git repository for ArgoCD manifests"
  type        = string
  default     = "gitops-safe/overlays/dev"
}

# Observability Configuration
variable "prometheus_version" {
  description = "Prometheus version"
  type        = string
  default     = "v2.48.0"
}

variable "grafana_version" {
  description = "Grafana version"
  type        = string
  default     = "10.2.0"
}

variable "node_groups" {
  description = "EKS node groups configuration (optional, uses defaults if not provided)"
  type = map(object({
    desired_size   = number
    min_size       = number
    max_size       = number
    instance_types = list(string)
    capacity_type  = string
    disk_size      = number
    labels         = optional(map(string), {})
  }))
  default = null
}

# RDS Configuration
variable "rds_db_name" {
  description = "RDS database name"
  type        = string
  default     = "humor_memory_game"
}

variable "rds_db_username" {
  description = "RDS master username"
  type        = string
  default     = "gameuser"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_multi_az" {
  description = "Enable Multi-AZ for RDS (HA)"
  type        = bool
  default     = true
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "rds_max_allocated_storage" {
  description = "RDS max allocated storage for autoscaling (GB)"
  type        = number
  default     = 100
}

variable "rds_kms_key_id" {
  description = "KMS key ID for RDS encryption (optional)"
  type        = string
  default     = null
}

variable "create_oidc_provider" {
  description = "Create OIDC provider for IRSA (set to false if already exists)"
  type        = bool
  default     = true
}

# Cost Optimization
variable "enable_cost_optimization" {
  description = "Enable cost optimization features (spot instances, etc.)"
  type        = bool
  default     = true
}

# Domain Configuration (optional)
variable "domain_name" {
  description = "Domain name for the application (optional)"
  type        = string
  default     = ""
}

variable "create_route53_zone" {
  description = "Create Route53 hosted zone for domain"
  type        = bool
  default     = false
}

