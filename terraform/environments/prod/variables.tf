variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "devops-home-lab"
}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "eks_cluster_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
  default     = "1.28"
}

variable "bastion_key_pair_name" {
  description = "Name of AWS key pair for bastion SSH access"
  type        = string
}

variable "bastion_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to SSH to bastion"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_github_runner" {
  description = "Enable self-hosted GitHub Actions runner"
  type        = bool
  default     = true
}

variable "github_runner_token" {
  description = "GitHub personal access token or runner registration token"
  type        = string
  sensitive   = true
}

variable "github_runner_labels" {
  description = "Labels for GitHub runner"
  type        = list(string)
  default     = ["self-hosted", "linux", "x64", "aws"]
}

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

variable "github_repository" {
  description = "GitHub repository in format owner/repo"
  type        = string
  default     = "Osomudeya/DevOps-Home-Lab-2025"
}

