# Variable definitions so that these can be used

variable "K8S_HOST" {}
variable "K8S_TOKEN" {}
variable "K8S_CA_CERT" {}

# Define the kubernetes provider here

provider "kubernetes" {
  host  = var.K8S_HOST
  token = var.K8S_TOKEN
  # If using self-signed certs, you might need:
  # insecure = true 
  cluster_ca_certificate = var.K8S_CA_CERT
}

# Call the module from the modules directory
# To be properly organized

module "dbs_cluster" {
  source = "./modules/dbs-cluster"
  # These variables are automatically pulled from your HCP Workspace
  K8S_HOST     = var.K8S_HOST
  K8S_TOKEN    = var.K8S_TOKEN
  K8S_CA_CERT  = var.K8S_CA_CERT
}

