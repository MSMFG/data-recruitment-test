variable "project_id" {
  type = string
}


resource "google_service_account" "sa" {
  project      = var.project_id
  account_id   = "demo-service"
  display_name = "demo-service"
}
resource "google_project_iam_member" "cloud_run_for_schema_applier_sa" {
  project = var.project_id
  member  = google_service_account.sa.member
  role    = "roles/run.serviceAgent"
}

resource "google_cloud_run_service" "demo_service" {
  name     = "demo-service"
  location = "europe-west1"
  project  = var.project_id

  template {
    spec {
      service_account_name = google_service_account.sa.email
      containers {
        image = "gcr.io/${var.project_id}/demo-service"

        resources {
          limits = {
            cpu = "1000m"
            memory = "512Mi"
          }
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "1"
      }
    }
  }
}

