variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_ca" {
  description = "EKS cluster certificate authority data"
  type        = string
  sensitive   = true
}

variable "argocd_namespace" {
  description = "Namespace for ArgoCD"
  type        = string
  default     = "argocd"
}

variable "argocd_version" {
  description = "ArgoCD Helm chart version"
  type        = string
  default     = "5.46.7"
}

variable "git_repo_url" {
  description = "Git repository URL for ArgoCD"
  type        = string
}

variable "git_repo_branch" {
  description = "Git branch for ArgoCD"
  type        = string
  default     = "main"
}

variable "git_repo_path" {
  description = "Path in git repository for ArgoCD manifests"
  type        = string
}

variable "argocd_project" {
  description = "ArgoCD project name"
  type        = string
  default     = "default"
}

variable "create_application" {
  description = "Create ArgoCD application automatically"
  type        = bool
  default     = false
}

variable "application_name" {
  description = "Name of ArgoCD application"
  type        = string
  default     = "humor-game"
}

variable "application_namespace" {
  description = "Namespace for application"
  type        = string
  default     = "humor-game"
}

