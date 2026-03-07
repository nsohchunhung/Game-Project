output "eks_cluster_role_arn" {
  description = "EKS cluster IAM role ARN"
  value       = aws_iam_role.eks_cluster.arn
}

output "eks_node_role_arn" {
  description = "EKS node IAM role ARN"
  value       = aws_iam_role.eks_node.arn
}

output "eks_node_instance_profile_name" {
  description = "EKS node instance profile name"
  value       = aws_iam_instance_profile.eks_node.name
}

output "eks_cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = aws_security_group.eks_cluster.id
}

output "eks_node_security_group_id" {
  description = "EKS node security group ID"
  value       = aws_security_group.eks_node.id
}

output "github_runner_security_group_id" {
  description = "GitHub runner security group ID"
  value       = var.github_runner_enabled ? aws_security_group.github_runner[0].id : null
}

