variable ocp30_ca_cert {}
variable ocp30_token_reviewer_jwt {}
variable ocp07_ca_cert {}
variable ocp07_token_reviewer_jwt {}
variable ocp50_ca_cert {}
variable ocp50_token_reviewer_jwt {}

# Development OCP Cluster

resource "vault_auth_backend" "ocp07_auth" {
  type = "kubernetes"
  path = "ocp07" # This is the mount point for this cluster
}

resource "vault_kubernetes_auth_backend_config" "ocp07_config" {
  backend         = vault_auth_backend.ocp07_auth.path
  kubernetes_host = "https://api.dbs-ocp07.ucmcswg.com:6443"
  kubernetes_ca_cert = var.ocp07_ca_cert
  token_reviewer_jwt = var.ocp07_token_reviewer_jwt
  disable_iss_validation = true
}

resource "vault_policy" "dev-db-policy" {
  name = "staging-db-policy"
  policy = <<EOT
path "database/data/development/mariadb/*" {
  capabilities = ["read"]
}

path "database/data/development/mariadb/*" {
  capabilities = ["list"]
}
EOT
}

resource "vault_kubernetes_auth_backend_role" "development_role" {
  backend                          = "ocp07" # The path you enabled
  role_name                        = "db-app-role"
  bound_service_account_names      = ["myapp-sa"]
  bound_service_account_namespaces = ["myapp-ns"]
  token_ttl                        = 3600
  token_policies                   = [vault_policy.dev-db-policy.name]
}

# Staging OCP Cluster

resource "vault_auth_backend" "ocp30_auth" {
  type = "kubernetes"
  path = "ocp30" # This is the mount point for this cluster
}

resource "vault_kubernetes_auth_backend_config" "ocp30_config" {
  backend         = vault_auth_backend.ocp30_auth.path
  kubernetes_host = "https://api.dbs-ocp30.ucmcswg.com:6443"
  kubernetes_ca_cert = var.ocp30_ca_cert
  token_reviewer_jwt = var.ocp30_token_reviewer_jwt
  disable_iss_validation = true
}

resource "vault_policy" "staging-db-policy" {
  name = "staging-db-policy"
  policy = <<EOT
path "database/data/staging/mariadb/*" {
  capabilities = ["read"]
}

path "database/data/staging/mariadb/*" {
  capabilities = ["list"]
}
EOT
}

resource "vault_kubernetes_auth_backend_role" "staging_role" {
  backend                          = "ocp30" # The path you enabled
  role_name                        = "db-app-role"
  bound_service_account_names      = ["myapp-sa"]
  bound_service_account_namespaces = ["myapp-ns"]
  token_ttl                        = 3600
  token_policies                   = [vault_policy.staging-db-policy.name]
}

# Production OCP Cluster

resource "vault_auth_backend" "ocp50_auth" {
  type = "kubernetes"
  path = "ocp50" # This is the mount point for this cluster
}

resource "vault_kubernetes_auth_backend_config" "ocp50_config" {
  backend         = vault_auth_backend.ocp50_auth.path
  kubernetes_host = "https://api.dbs-ocp50.ucmcswg.com:6443"
  kubernetes_ca_cert = var.ocp50_ca_cert
  token_reviewer_jwt = var.ocp50_token_reviewer_jwt
  disable_iss_validation = true
}

resource "vault_policy" "production-db-policy" {
  name = "production-db-policy"
  policy = <<EOT
path "database/data/production/mariadb/*" {
  capabilities = ["read"]
}

path "database/data/production/mariadb/*" {
  capabilities = ["list"]
}
EOT
}

resource "vault_kubernetes_auth_backend_role" "staging_role" {
  backend                          = "ocp50" # The path you enabled
  role_name                        = "db-app-role"
  bound_service_account_names      = ["myapp-sa"]
  bound_service_account_namespaces = ["myapp-ns"]
  token_ttl                        = 3600
  token_policies                   = [vault_policy.production-db-policy.name]
}