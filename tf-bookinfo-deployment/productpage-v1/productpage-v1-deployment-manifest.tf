variable "namespace" {
  type = string
}

# ------------------------------------------------------------------------------
# ServiceAccount: bookinfo-productpage
# ------------------------------------------------------------------------------
resource "kubernetes_manifest" "productpage_sa" {
  manifest = {
    apiVersion = "v1"
    kind       = "ServiceAccount"
    metadata = {
      name = "bookinfo-productpage"
      namespace = var.namespace
      labels = {
        account = "productpage"
      }
    }
  }
}

# ------------------------------------------------------------------------------
# Service: productpage
# ------------------------------------------------------------------------------
resource "kubernetes_manifest" "productpage_svc" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      name = "productpage"
      namespace = var.namespace
      labels = {
        app     = "productpage"
        service = "productpage"
      }
    }
    spec = {
      selector = {
        app = "productpage"
      }
      ports = [
        {
          port        = 9080
          targetPort  = 9080
          name        = "http"
        }
      ]
    }
  }
}

# ------------------------------------------------------------------------------
# Deployment: productpage-v1
# ------------------------------------------------------------------------------
resource "kubernetes_manifest" "productpage_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name = "productpage-v1"
      namespace = var.namespace
      labels = {
        app     = "productpage"
        version = "v1"
      }
    }
    spec = {
      replicas = 1
      selector = {
        matchLabels = {
          app     = "productpage"
          version = "v1"
        }
      }
      template = {
        metadata = {
          annotations = {
            "prometheus.io/scrape" = "true"
            "prometheus.io/port"   = "9080"
            "prometheus.io/path"   = "/metrics"
          }
          labels = {
            app     = "productpage"
            version = "v1"
          }
        }
        spec = {
          serviceAccountName = "bookinfo-productpage"
          containers = [
            {
              name  = "productpage"
              image = "docker.io/istio/examples-bookinfo-productpage-v1:1.20.3"
              imagePullPolicy = "IfNotPresent"
              ports = [
                {
                  containerPort = 9080
                }
              ]
              volumeMounts = [
                {
                  name      = "tmp"
                  mountPath = "/tmp"
                }
              ]
            }
          ]
          volumes = [
            {
              name = "tmp"
              emptyDir = {}
            }
          ]
        }
      }
    }
  }
}

# variable "namespace" {
#   type = string
# }

# resource "kubernetes_manifest" "productpage_pod" {
#   manifest = {
#     apiVersion = "v1"
#     kind       = "Pod"
#     metadata = {
#       name      = "productpage-v1-pod"
#       namespace = var.namespace
#       annotations = {
#         "prometheus.io/scrape" = "true"
#         "prometheus.io/port"   = "9080"
#         "prometheus.io/path"   = "/metrics"
#       }
#       labels = {
#         app     = "productpage"
#         version = "v1"
#       }
#     }
#     spec = {
#       containers = [
#         {
#           name  = "productpage"
#           image = "docker.io/istio/examples-bookinfo-productpage-v1:1.20.3"
#           imagePullPolicy = "IfNotPresent"
#           ports = [
#             {
#               containerPort = 9080
#             }
#           ]
#           volumeMounts = [
#             {
#               name      = "tmp"
#               mountPath = "/tmp"
#             }
#           ]
#         }
#       ]
#       volumes = [
#         {
#           name     = "tmp"
#           emptyDir = {}
#         }
#       ]
#     }
#   }
# }

