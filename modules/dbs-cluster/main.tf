
resource "kubernetes_namespace" "app_ns" {
  metadata {
    name = "dbs-application"
  }
}

resource "kubernetes_namespace" "myapp_ns" {
  metadata {
    name = "myapp-ns"
  }
}