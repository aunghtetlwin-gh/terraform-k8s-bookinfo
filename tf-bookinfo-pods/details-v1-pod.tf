resource "kubernetes_pod" "details_pod" {
  count = contains(var.enabled_pods, "details") ? 1 : 0
  metadata {
    name      = "details-v1-pod"
    namespace = var.namespace
    labels = {
      app     = "details-pod"
      version = "v1"
    }
  }

  spec {
    container {
      name  = "details-pod"
      image = "docker.io/istio/examples-bookinfo-details-v1:1.20.3"
      image_pull_policy = "IfNotPresent"

      port {
        container_port = 9080
      }
    }
  }
}

