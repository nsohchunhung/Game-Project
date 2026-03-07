terraform {
  required_providers {
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

# Kubernetes Provider
provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate  = base64decode(var.cluster_ca)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      var.cluster_name
    ]
  }
}

# Helm Provider
provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate  = base64decode(var.cluster_ca)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        var.cluster_name
      ]
    }
  }
}

# Monitoring Namespace
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.prometheus_namespace
    labels = {
      name = var.prometheus_namespace
    }
  }
}

# Prometheus Helm Release
resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.prometheus_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  values = [
    yamlencode({
      # Prometheus configuration
      prometheus = {
        prometheusSpec = {
          retention = "30d"
          resources = {
            limits = {
              cpu    = "2000m"
              memory = "4Gi"
            }
            requests = {
              cpu    = "1000m"
              memory = "2Gi"
            }
          }
          # ServiceMonitor and PodMonitor discovery
          serviceMonitorSelectorNilUsesHelmValues = false
          podMonitorSelectorNilUsesHelmValues     = false
          # Storage
          storageSpec = {
            volumeClaimTemplate = {
              spec = {
                accessModes = ["ReadWriteOnce"]
                resources = {
                  requests = {
                    storage = "50Gi"
                  }
                }
              }
            }
          }
        }
        service = {
          type = "ClusterIP" # Private access only
        }
      }

      # Grafana configuration
      grafana = {
        enabled = true
        service = {
          type = "ClusterIP" # Private access only
        }
        adminUser     = "admin"
        adminPassword = "admin" # Change this in production!
        persistence = {
          enabled = true
          size    = "10Gi"
        }
        resources = {
          limits = {
            cpu    = "500m"
            memory = "512Mi"
          }
          requests = {
            cpu    = "250m"
            memory = "256Mi"
          }
        }
        # Enable dashboard sidecar for auto-importing ConfigMaps
        sidecar = {
          dashboards = {
            enabled = true
            label = "grafana_dashboard"
            labelValue = "1"
            folder = "/dashboards"
            searchNamespace = "ALL"
          }
        }
      }

      # Alertmanager configuration
      alertmanager = {
        enabled = true
        alertmanagerSpec = {
          resources = {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }
        }
      }

      # Node exporter
      nodeExporter = {
        enabled = true
      }

      # Kube state metrics
      kubeStateMetrics = {
        enabled = true
      }
    })
  ]

  depends_on = [kubernetes_namespace.monitoring]
}

# Grafana Dashboard ConfigMap (auto-imported by Grafana)
# Grafana automatically imports dashboards from ConfigMaps with label grafana_dashboard=1
resource "kubernetes_config_map" "grafana_dashboard" {
  metadata {
    name      = "humor-game-dashboard"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
    labels = {
      grafana_dashboard = "1"
    }
  }

  data = {
    "humor-game-dashboard.json" = file("${path.module}/grafana-dashboard.json")
  }

  depends_on = [kubernetes_namespace.monitoring, helm_release.prometheus]
}

# CloudWatch Exporter (optional)
resource "helm_release" "cloudwatch_exporter" {
  count = var.enable_cloudwatch_exporter ? 1 : 0

  name       = "cloudwatch-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-cloudwatch-exporter"
  version    = "0.24.0"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  set {
    name  = "aws.region"
    value = var.aws_region
  }

  depends_on = [kubernetes_namespace.monitoring]
}

