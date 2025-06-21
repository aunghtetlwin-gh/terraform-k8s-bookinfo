variable namespace{
    type = string

}

# ServiceAccount
resource "kubernetes_manifest" "details_sa" {
  manifest = {
    apiVersion = "v1"
    kind       = "ServiceAccount"
    metadata = {
      name = "bookinfo-details"
      namespace = var.namespace
      labels = {
        account = "details"
      }
    }
  }
}


# ------------------------------------------------------------------------------
# Service: details
# ------------------------------------------------------------------------------
resource "kubernetes_manifest" "details_svc" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      name = "details"
      namespace = var.namespace
      labels = {
        app     = "details"
        service = "details"
      }
    }
    spec = {
      selector = {
        app = "details"
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
# Deployment: details-v1
# ------------------------------------------------------------------------------
resource "kubernetes_manifest" "details_v1_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name = "details-v1"
      namespace = var.namespace
      labels = {
        app     = "details"
        version = "v1"
      }
    }
    spec = {
      replicas = 1
      selector = {
        matchLabels = {
          app     = "details"
          version = "v1"
        }
      }
      template = {
        metadata = {
          labels = {
            app     = "details"
            version = "v1"
          }
        }
        spec = {
          serviceAccountName = "bookinfo-details"
          containers = [
            {
              name  = "details"
              image = "docker.io/istio/examples-bookinfo-details-v1:1.20.3"
              imagePullPolicy = "IfNotPresent"
              ports = [
                {
                  containerPort = 9080
                }
              ]
            }
          ]
        }
      }
    }
  }
}
