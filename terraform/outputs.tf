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
  description = "EKS cluster API endpoint"
  value       = module.eks.cluster_endpoint
  sensitive   = true
}

output "eks_cluster_arn" {
  description = "EKS cluster ARN"
  value       = module.eks.cluster_arn
}

output "bastion_public_ip" {
  description = "Bastion host public IP address"
  value       = module.bastion.public_ip
}

output "bastion_ssh_command" {
  description = "SSH command to connect to bastion host"
  value       = "ssh -i ${var.bastion_key_pair_name}.pem ec2-user@${module.bastion.public_ip}"
}

output "kubectl_config_command" {
  description = "Command to configure kubectl for EKS cluster"
  value       = var.aws_profile != "" ? "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name} --profile ${var.aws_profile}" : "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "github_runner_private_ip" {
  description = "GitHub runner private IP address"
  value       = var.enable_github_runner ? module.github_runner[0].private_ip : null
}

output "argocd_server_url" {
  description = "ArgoCD server URL (access via port-forward)"
  value       = "https://argocd-server.${module.argocd.argocd_namespace}.svc.cluster.local"
}

output "grafana_url" {
  description = "Grafana URL (access via port-forward)"
  value       = "http://grafana.${module.observability.grafana_namespace}.svc.cluster.local:3000"
}

output "prometheus_url" {
  description = "Prometheus URL (access via port-forward)"
  value       = "http://prometheus-server.${module.observability.prometheus_namespace}.svc.cluster.local:9090"
}

output "vpc_endpoints" {
  description = "VPC endpoint information"
  value = {
    s3_endpoint      = module.vpc_endpoints.s3_endpoint_id
    ecr_endpoint     = module.vpc_endpoints.ecr_endpoint_id
    ecr_api_endpoint = module.vpc_endpoints.ecr_api_endpoint_id
  }
}

output "secrets_manager_secrets" {
  description = "AWS Secrets Manager secret names"
  value       = module.secrets_manager.secret_names
}

output "external_secrets_status" {
  description = "External Secrets Operator status"
  value = {
    namespace      = module.external_secrets.external_secrets_namespace
    secret_store   = module.external_secrets.secret_store_name
    external_secret = module.external_secrets.external_secret_name
  }
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint (hostname)"
  value       = module.rds.rds_address
}

output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = module.rds.rds_port
}

output "rds_arn" {
  description = "RDS instance ARN"
  value       = module.rds.rds_arn
}

output "rds_security_group_id" {
  description = "RDS security group ID"
  value       = module.rds.rds_security_group_id
}

output "access_instructions" {
  description = "Instructions for accessing the infrastructure"
  value = <<-EOT
    ============================================
    AWS Infrastructure Access Instructions
    ============================================
    
    1. Connect to Bastion Host:
       ${module.bastion.public_ip}
    
    2. Configure kubectl from bastion:
       aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}
    
    3. Access ArgoCD (from bastion):
       kubectl port-forward svc/argocd-server -n argocd 8080:443
       Then access: https://localhost:8080
       Default username: admin
       Get password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    
    4. Access Grafana (from bastion):
       kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80
       Then access: http://localhost:3000
       Default username: admin
       Default password: admin (change on first login)
    
    5. Access Prometheus (from bastion):
       kubectl port-forward svc/prometheus-kube-prometheus-prometheus -n monitoring 9090:9090
       Then access: http://localhost:9090
    
    6. Verify Secrets (from bastion):
       kubectl get secret humor-game-secrets -n humor-game
       kubectl get externalsecret -n humor-game
       kubectl describe externalsecret humor-game-secrets -n humor-game
    
    7. Initialize RDS Database Schema (from bastion):
       kubectl get job rds-init-schema -n humor-game
       kubectl logs job/rds-init-schema -n humor-game
       # If job failed, check logs and rerun if needed
    
    8. RDS Connection Info:
       Endpoint: ${module.rds.rds_address}
       Port: ${module.rds.rds_port}
       Database: ${module.rds.db_name}
       # Connect from bastion: psql -h ${module.rds.rds_address} -p ${module.rds.rds_port} -U ${var.rds_db_username} -d ${module.rds.db_name}
    
    ============================================
  EOT
}

