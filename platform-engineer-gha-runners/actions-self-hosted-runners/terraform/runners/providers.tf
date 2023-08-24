
data "google_client_config" "default" {
}

provider "kubernetes" {
  host                   = "https://${module.runner-cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.runner-cluster.ca_certificate)
}
