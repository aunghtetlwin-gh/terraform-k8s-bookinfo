resource "kubernetes_pod" "productpage_pod" {
  count = contains(var.enabled_pods, "productpage") ? 1 : 0
  metadata {
    name      = "productpage-v1-pod"
    namespace = var.namespace
    labels = {
      app     = "productpage-pod"
      version = "v1"
    }
    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/port"   = "9080"
      "prometheus.io/path"   = "/metrics"
    }
  }

  spec {
    container {
      name  = "productpage-pod"
      image = "docker.io/istio/examples-bookinfo-productpage-v1:1.20.3"
      image_pull_policy = "IfNotPresent"

      port {
        container_port = 9080
      }

      volume_mount {
        name       = "tmp"
        mount_path = "/tmp"
      }
    }

    volume {
      name = "tmp"
      empty_dir {}
    }
  }
}

