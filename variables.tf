variable "namespace" {
  type    = string
  default = "default"
}

variable "enabled_pods" {
  type    = list(string)
  default = ["productpage", "details", "ratings", "reviews_v1", "reviews_v2", "reviews_v3"]
}

variable "enabled_replicasets" {
  type    = list(string)
  default = ["productpage", "details", "ratings", "reviews_v1", "reviews_v2", "reviews_v3"]
}