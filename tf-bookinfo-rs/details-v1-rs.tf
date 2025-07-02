resource "kubernetes_replication_controller" "details_rc" {
  count = contains(var.enabled_replicasets, "details") ? 1 : 0
  metadata {
    name = "details-v1-rc"
    labels = {
      app     = "details-rs"
      version = "v1"
    }
  }

  spec {
    replicas = 1
    selector = {
      app     = "details-rs"
      version = "v1"
    }

    template {
      metadata {
        labels = {
          app     = "details-rs"
          version = "v1"
        }
      }

      spec {
        container {
          name              = "details-rs"
          image             = "docker.io/istio/examples-bookinfo-details-v1:1.20.3"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 9080
          }
        }
      }
    }
  }
}
