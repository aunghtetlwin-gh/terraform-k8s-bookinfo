# tf-bookinfo-deployment/ratings-v1/variables.tf
variable "namespace" {
  type = string
}

resource "kubernetes_manifest" "ratings_sa" {
  manifest = {
    apiVersion = "v1"
    kind       = "ServiceAccount"
    metadata = {
      name      = "bookinfo-ratings"
      namespace = var.namespace
      labels = {
        account = "ratings"
      }
    }
  }
}

resource "kubernetes_manifest" "ratings_svc" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      name      = "ratings"
      namespace = var.namespace
      labels = {
        app     = "ratings"
        service = "ratings"
      }
    }
    spec = {
      ports = [
        {
          port = 9080
          name = "http"
        }
      ]
      selector = {
        app = "ratings"
      }
    }
  }
}

resource "kubernetes_manifest" "ratings_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name      = "ratings-v1"
      namespace = var.namespace
      labels = {
        app     = "ratings"
        version = "v1"
      }
    }
    spec = {
      replicas = 1
      selector = {
        matchLabels = {
          app     = "ratings"
          version = "v1"
        }
      }
      template = {
        metadata = {
          labels = {
            app     = "ratings"
            version = "v1"
          }
        }
        spec = {
          serviceAccountName = "bookinfo-ratings"
          containers = [
            {
              name            = "ratings"
              image           = "docker.io/istio/examples-bookinfo-ratings-v1:1.20.3"
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
