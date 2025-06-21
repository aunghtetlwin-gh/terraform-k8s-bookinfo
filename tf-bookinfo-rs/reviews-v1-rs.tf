resource "kubernetes_replication_controller" "reviews_v1_rc" {
  count = contains(var.enabled_replicasets, "reviews_v1") ? 1 : 0

  metadata {
    name = "reviews-v1-rc"
    labels = {
      app     = "reviews"
      version = "v1"
    }
  }

  spec {
    replicas = 1

    selector = {
      app     = "reviews"
      version = "v1"
    }

    template {
      metadata {
        labels = {
          app     = "reviews"
          version = "v1"
        }
      }

      spec {
        container {
          name              = "reviews"
          image             = "docker.io/istio/examples-bookinfo-reviews-v1:1.20.3"
          image_pull_policy = "IfNotPresent"

          env {
            name  = "LOG_DIR"
            value = "/tmp/logs"
          }

          port {
            container_port = 9080
          }

          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }

          volume_mount {
            name       = "wlp-output"
            mount_path = "/opt/ibm/wlp/output"
          }
        }

        volume {
          name = "tmp"
          empty_dir {}
        }

        volume {
          name = "wlp-output"
          empty_dir {}
        }
      }
    }
  }
}
