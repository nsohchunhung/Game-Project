output "prometheus_namespace" {
  description = "Prometheus namespace"
  value       = kubernetes_namespace.monitoring.metadata[0].name
}

output "grafana_namespace" {
  description = "Grafana namespace"
  value       = var.grafana_namespace
}

output "prometheus_service" {
  description = "Prometheus service name"
  value       = "prometheus-kube-prometheus-prometheus"
}

output "grafana_service" {
  description = "Grafana service name"
  value       = "prometheus-grafana"
}

output "prometheus_port_forward_command" {
  description = "Command to port-forward Prometheus"
  value       = "kubectl port-forward svc/${output.prometheus_service.value} -n ${kubernetes_namespace.monitoring.metadata[0].name} 9090:9090"
}

output "grafana_port_forward_command" {
  description = "Command to port-forward Grafana"
  value       = "kubectl port-forward svc/${output.grafana_service.value} -n ${var.grafana_namespace} 3000:80"
}

