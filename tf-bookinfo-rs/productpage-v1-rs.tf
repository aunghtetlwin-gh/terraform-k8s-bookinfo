resource "kubernetes_replication_controller" "productpage_rc" {
  count = contains(var.enabled_replicasets, "productpage") ? 1 : 0
  metadata {
    name = "productpage-v1-rc"
    labels = {
      app     = "productpage-rs"
      version = "v1"
    }
  }

  spec {
    replicas = 1
    selector = {
      app     = "productpage-rs"
      version = "v1"
    }

    template {
      metadata {
        annotations = {
            "prometheus.io/scrape" = "true"
            "prometheus.io/port"   = "9080"
            "prometheus.io/path"   = "/metrics"
        }
        labels = {
          app     = "productpage-rs"
          version = "v1"
        }
      }

      spec {
        container {
          name              = "productpage-rs"
          image             = "docker.io/istio/examples-bookinfo-productpage-v1:1.20.3"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 9080
          }

          volume_mount {
            name = "tmp"
            mount_path = "/tmp"
          }
        }
        volume {
          name = "tmp"
          empty_dir {}
        }
      }
    }
  }
}
