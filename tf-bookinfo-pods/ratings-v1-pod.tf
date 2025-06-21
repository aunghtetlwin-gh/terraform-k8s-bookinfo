resource "kubernetes_pod" "ratings_pod" {
  count = contains(var.enabled_pods, "ratings") ? 1 : 0
  metadata {
    name      = "ratings-v1-pod"
    namespace = var.namespace
    labels = {
      app     = "ratings-pod"
      version = "v1"
    }
  }

  spec {
    container {
      name  = "ratings-pod"
      image = "docker.io/istio/examples-bookinfo-ratings-v1:1.20.3"
      image_pull_policy = "IfNotPresent"

      port {
        container_port = 9080
      }
    }
  }
}

