
resource "kubernetes_namespace" "app_ns" {
  metadata {
    name = "dbs-application"
  }
}
