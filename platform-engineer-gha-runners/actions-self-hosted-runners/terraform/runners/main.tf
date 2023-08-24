
locals {
  network_name    = google_compute_network.gh-network.name
  subnet_name     = google_compute_subnetwork.gh-subnetwork.name
}


resource "google_compute_network" "gh-network" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "gh-subnetwork" {
  project       = var.project_id
  name          = var.subnet_name
  ip_cidr_range = var.subnet_ip
  region        = var.region
  network       = google_compute_network.gh-network.name
  secondary_ip_range = [
    {
      range_name    = var.ip_range_pods_name
      ip_cidr_range = var.ip_range_pods_cidr
    },
    { range_name    = var.ip_range_services_name
      ip_cidr_range = var.ip_range_services_cider
    }
  ]
}


module "runner-cluster" {
  source                   = "terraform-google-modules/kubernetes-engine/google//modules/beta-public-cluster/"
  version                  = "~> 24.0"
  project_id               = var.project_id
  name                     = "gh-runner-${var.repo_name}"
  regional                 = false
  region                   = var.region
  zones                    = var.zones
  network                  = local.network_name
  network_project_id       = var.subnetwork_project != "" ? var.subnetwork_project : var.project_id
  subnetwork               = local.subnet_name
  ip_range_pods            = var.ip_range_pods_name
  ip_range_services        = var.ip_range_services_name
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  service_account          = "create"
  remove_default_node_pool = true
  node_pools = [
    {
      name         = "runner-pool"
      min_count    = var.min_node_count
      max_count    = var.max_node_count
      auto_upgrade = true
      machine_type = var.machine_type
    }
  ]
}


data "google_secret_manager_secret_version" "gh_token" {
  project = var.project_id
  secret  = "gh_token"
}

resource "kubernetes_secret" "runner-secrets" {
  metadata {
    name = var.runner_k8s_config
  }
  data = {
    repo_url   = var.repo_url
    gh_token   = data.google_secret_manager_secret_version.gh_token.secret_data
    repo_owner = var.repo_owner
    repo_name  = var.repo_name
  }
}
