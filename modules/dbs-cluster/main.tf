provider "kubernetes" {
  host  = var.K8S_HOST
  token = var.K8S_TOKEN
  # If using self-signed certs, you might need:
  # insecure = true 
  cluster_ca_certificate = var.K8S_CA_CERT
}

resource "kubernetes_namespace" "app_ns" {
  metadata {
    name = "dbs-application"
  }
}