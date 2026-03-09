variable "K8S_HOST" {}
variable "K8S_TOKEN" {}
variable "K8S_CA_CERT" {}

module "dbs_cluster" {
  source = "./modules/dbs-cluster"
  # These variables are automatically pulled from your HCP Workspace
  K8S_HOST     = var.K8S_HOST
  K8S_TOKEN    = var.K8S_TOKEN
  K8S_CA_CERT  = var.K8S_CA_CERT
}