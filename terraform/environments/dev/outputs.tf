output "vpc_hub_id" {
  description = "Hub VPC ID"
  value       = module.infrastructure.vpc_hub_id
}

output "vpc_spoke_eks_id" {
  description = "Spoke EKS VPC ID"
  value       = module.infrastructure.vpc_spoke_eks_id
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.infrastructure.eks_cluster_name
}

output "bastion_public_ip" {
  description = "Bastion host public IP address"
  value       = module.infrastructure.bastion_public_ip
}

output "bastion_ssh_command" {
  description = "SSH command to connect to bastion host"
  value       = module.infrastructure.bastion_ssh_command
}

output "kubectl_config_command" {
  description = "Command to configure kubectl for EKS cluster"
  value       = module.infrastructure.kubectl_config_command
}

output "github_runner_private_ip" {
  description = "GitHub runner private IP address"
  value       = module.infrastructure.github_runner_private_ip
}

