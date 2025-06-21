resource "kubernetes_replication_controller" "ratings_rc" {
  count = contains(var.enabled_replicasets, "ratings") ? 1 : 0

  metadata {
    name = "ratings-v1-rc"
    labels = {
      app     = "ratings-rs"
      version = "v1"
    }
  }

  spec {
    replicas = 1

    selector = {
      app     = "ratings-rs"
      version = "v1"
    }

    template {
      metadata {
        labels = {
          app     = "ratings-rs"
          version = "v1"
        }
      }

      spec {
        container {
          name              = "ratings-rs"
          image             = "docker.io/istio/examples-bookinfo-ratings-v1:1.20.3"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 9080
          }
        }
      }
    }
  }
}
