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

variable "prometheus_namespace" {
  description = "Namespace for Prometheus"
  type        = string
  default     = "monitoring"
}

variable "prometheus_version" {
  description = "Prometheus Helm chart version"
  type        = string
  default     = "55.0.0"
}

variable "grafana_namespace" {
  description = "Namespace for Grafana (usually same as Prometheus)"
  type        = string
  default     = "monitoring"
}

variable "grafana_version" {
  description = "Grafana version (not used, part of kube-prometheus-stack)"
  type        = string
  default     = "10.2.0"
}

variable "enable_cloudwatch_exporter" {
  description = "Enable CloudWatch metrics exporter"
  type        = bool
  default     = true
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

