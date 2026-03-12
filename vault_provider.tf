variable vault_token {}

# Vault provider

provider "vault" {
  address = "https://vault.svc.cluster.local:8200" 
  token   = var.vault_token 
}