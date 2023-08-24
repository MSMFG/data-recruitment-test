terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

variable "candidate_initials" {
  type = string
}
variable "candidate_email" {
  type = string
}
variable "folder_id" {
  type = string
}
variable "billing_account" {
  type = string
}
variable "gh_token" {
  type = string
}

resource "google_project" "project" {
  name       = "msmg-platengchal-${var.candidate_initials}"
  project_id = "msmg-platengchal-${var.candidate_initials}"
  billing_account = var.billing_account
  folder_id = var.folder_id
}

resource "google_project_service" "cloudbuild" {
  project = google_project.project.project_id
  service = "cloudbuild.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "run" {
  project = google_project.project.project_id
  service = "run.googleapis.com"
  disable_dependent_services = true
}


resource "google_project_service" "secretmanager" {
  project = google_project.project.project_id
  service = "secretmanager.googleapis.com"
  disable_dependent_services = true
}


resource "google_storage_bucket" "tfstate" {
  project = google_project.project.project_id
  name          = "${google_project.project.project_id}-tfstate"
  location      = "europe-west1"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_secret_manager_secret" "gh_token" {
  depends_on = [
    google_project_service.secretmanager
  ]
  project = google_project.project.project_id
  secret_id = "gh_token"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "gh_token" {
  secret = google_secret_manager_secret.gh_token.id
  secret_data = var.gh_token
}


output "project_id" {
  value = google_project.project.project_id
}


provider "github" {
  owner = "MSMG-Data-Public"
  token = var.gh_token
}



resource "google_service_account" "run_runner" {
  account_id   = "run-runner"
  display_name = "run-runner"
  project      = google_project.project.project_id
}

resource "google_project_iam_member" "run_runner_invoker" {
  project = google_project.project.project_id
  role    = "roles/run.invoker"
  member  = google_service_account.run_runner.member
}

resource "google_project_iam_member" "run_runner_viewer" {
  project = google_project.project.project_id
  role    = "roles/run.viewer"
  member  = google_service_account.run_runner.member
}


resource "time_rotating" "run_runner" {
  rotation_days = 1
}

resource "google_service_account_key" "run_runner" {
  service_account_id = google_service_account.run_runner.name

  keepers = {
    rotation_time = time_rotating.run_runner.rotation_rfc3339
  }
}
resource "github_actions_secret" "run_runner_key" {
  repository       = "demo-service"
  secret_name      = "run_runner"
  plaintext_value  = google_service_account_key.run_runner.private_key
}
