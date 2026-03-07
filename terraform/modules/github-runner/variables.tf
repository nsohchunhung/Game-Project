variable "name" {
  description = "Name of the GitHub runner"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for GitHub runner"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "github_token" {
  description = "GitHub personal access token or runner registration token"
  type        = string
  sensitive   = true
}

variable "github_repository" {
  description = "GitHub repository in format owner/repo"
  type        = string
}

variable "github_labels" {
  description = "Labels for GitHub runner"
  type        = list(string)
  default     = ["self-hosted", "linux", "x64", "aws"]
}

variable "security_group_id" {
  description = "Security group ID for GitHub runner"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

