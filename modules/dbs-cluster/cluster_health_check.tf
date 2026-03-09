# This queries the Kubernetes Server Version to test connectivity
data "kubernetes_server_version" "current" {}

# This queries a specific namespace to test RBAC permissions
data "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }
}

# Output the findings to the HCP Terraform Console for verification
output "k8s_cluster_version" {
  value = data.kubernetes_server_version.current.version
}

output "default_namespace_uid" {
  value = data.kubernetes_namespace.default.metadata[0].uid
}