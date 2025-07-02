resource "kubernetes_pod" "reviews_v1" {
  count = contains(var.enabled_pods, "reviews_v1") ? 1 : 0
  metadata {
    name      = "reviews-v1-pod"
    namespace = var.namespace
    labels = {
      app     = "reviews-pod"
      version = "v1"
    }
  }

  spec {
    container {
      name  = "reviews"
      image = "docker.io/istio/examples-bookinfo-reviews-v1:1.20.3"
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

resource "kubernetes_pod" "reviews_v2" {
  count = contains(var.enabled_pods, "reviews_v2") ? 1 : 0
  metadata {
    name      = "reviews-v2-pod"
    namespace = var.namespace
    labels = {
      app     = "reviews-pod"
      version = "v2"
    }
  }

  spec {
    container {
      name  = "reviews"
      image = "docker.io/istio/examples-bookinfo-reviews-v2:1.20.3"
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

resource "kubernetes_pod" "reviews_v3" {
  count = contains(var.enabled_pods, "reviews_v3") ? 1 : 0
  metadata {
    name      = "reviews-v3-pod"
    namespace = var.namespace
    labels = {
      app     = "reviews-pod"
      version = "v3"
    }
  }

  spec {
    container {
      name  = "reviews"
      image = "docker.io/istio/examples-bookinfo-reviews-v3:1.20.3"
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
