variable vault_token {}

# Vault provider

provider "vault" {
  address = "http://vault.vault.svc.cluster.local:8200" 
  token   = var.vault_token 
}