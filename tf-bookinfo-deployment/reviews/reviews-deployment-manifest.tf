variable "namespace" {
  type = string
}

# ServiceAccount
resource "kubernetes_manifest" "reviews_sa" {
  manifest = {
    apiVersion = "v1"
    kind       = "ServiceAccount"
    metadata = {
      name      = "bookinfo-reviews"
      namespace = var.namespace
      labels = {
        account = "reviews"
      }
    }
  }
}

# Service
resource "kubernetes_manifest" "reviews_service" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      name      = "reviews"
      namespace = var.namespace
      labels = {
        app     = "reviews"
        service = "reviews"
      }
    }
    spec = {
      ports = [{
        port = 9080
        name = "http"
      }]
      selector = {
        app = "reviews"
      }
    }
  }
}

# --- Deployment: reviews-v1
resource "kubernetes_manifest" "reviews_v1" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name      = "reviews-v1"
      namespace = var.namespace
      labels = {
        app     = "reviews"
        version = "v1"
      }
    }
    spec = {
      replicas = 1
      selector = {
        matchLabels = {
          app     = "reviews"
          version = "v1"
        }
      }
      template = {
        metadata = {
          labels = {
            app     = "reviews"
            version = "v1"
          }
        }
        spec = {
          serviceAccountName = "bookinfo-reviews"
          containers = [{
            name  = "reviews"
            image = "docker.io/istio/examples-bookinfo-reviews-v1:1.20.3"
            imagePullPolicy = "IfNotPresent"
            env = [{
              name  = "LOG_DIR"
              value = "/tmp/logs"
            }]
            ports = [{
              containerPort = 9080
            }]
            volumeMounts = [
              { name = "tmp",         mountPath = "/tmp" },
              { name = "wlp-output",  mountPath = "/opt/ibm/wlp/output" }
            ]
          }]
          volumes = [
            { name = "tmp",         emptyDir = {} },
            { name = "wlp-output",  emptyDir = {} }
          ]
        }
      }
    }
  }
}

# --- Deployment: reviews-v2
resource "kubernetes_manifest" "reviews_v2" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name      = "reviews-v2"
      namespace = var.namespace
      labels = {
        app     = "reviews"
        version = "v2"
      }
    }
    spec = {
      replicas = 1
      selector = {
        matchLabels = {
          app     = "reviews"
          version = "v2"
        }
      }
      template = {
        metadata = {
          labels = {
            app     = "reviews"
            version = "v2"
          }
        }
        spec = {
          serviceAccountName = "bookinfo-reviews"
          containers = [{
            name  = "reviews"
            image = "docker.io/istio/examples-bookinfo-reviews-v2:1.20.3"
            imagePullPolicy = "IfNotPresent"
            env = [{
              name  = "LOG_DIR"
              value = "/tmp/logs"
            }]
            ports = [{
              containerPort = 9080
            }]
            volumeMounts = [
              { name = "tmp",         mountPath = "/tmp" },
              { name = "wlp-output",  mountPath = "/opt/ibm/wlp/output" }
            ]
          }]
          volumes = [
            { name = "tmp",         emptyDir = {} },
            { name = "wlp-output",  emptyDir = {} }
          ]
        }
      }
    }
  }
}
# --- Deployment: reviews-v3
resource "kubernetes_manifest" "reviews_v3" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name      = "reviews-v3"
      namespace = var.namespace
      labels = {
        app     = "reviews"
        version = "v3"
      }
    }
    spec = {
      replicas = 1
      selector = {
        matchLabels = {
          app     = "reviews"
          version = "v3"
        }
      }
      template = {
        metadata = {
          labels = {
            app     = "reviews"
            version = "v3"
          }
        }
        spec = {
          serviceAccountName = "bookinfo-reviews"
          containers = [{
            name  = "reviews"
            image = "docker.io/istio/examples-bookinfo-reviews-v3:1.20.3"
            imagePullPolicy = "IfNotPresent"
            env = [{
              name  = "LOG_DIR"
              value = "/tmp/logs"
            }]
            ports = [{
              containerPort = 9080
            }]
            volumeMounts = [
              { name = "tmp",         mountPath = "/tmp" },
              { name = "wlp-output",  mountPath = "/opt/ibm/wlp/output" }
            ]
          }]
          volumes = [
            { name = "tmp",         emptyDir = {} },
            { name = "wlp-output",  emptyDir = {} }
          ]
        }
      }
    }
  }
}
