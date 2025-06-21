module "productpage_v1" {
  source    = "./tf-bookinfo-deployment/productpage-v1"
  namespace = var.namespace
}

module "details_v1" {
  source    = "./tf-bookinfo-deployment/details-v1"
  namespace = var.namespace
}

module "ratings_v1" {
  source    = "./tf-bookinfo-deployment/ratings-v1"
  namespace = var.namespace
}

module "reviews" {
  source    = "./tf-bookinfo-deployment/reviews"
  namespace = var.namespace
}

# module "productpage_pod" {
#   source    = "./tf-bookinfo-pods"
#   namespace = var.namespace
# }

# module "details_pod" {
#   source    = "./tf-bookinfo-pods"
#   namespace = var.namespace
# }

# module "ratings_pod" {
#   source    = "./tf-bookinfo-pods"
#   namespace = var.namespace
# }

# module "ratings_pod" {
#   source    = "./tf-bookinfo-pods"
#   namespace = var.namespace
# }

module "bookinfo_pods" {
  source       = "./tf-bookinfo-pods"
  namespace    = var.namespace
  enabled_pods = var.enabled_pods
}

module "bookinfo_replicasets" {
  source              = "./tf-bookinfo-rs"
  namespace           = var.namespace
  enabled_replicasets = var.enabled_replicasets
}