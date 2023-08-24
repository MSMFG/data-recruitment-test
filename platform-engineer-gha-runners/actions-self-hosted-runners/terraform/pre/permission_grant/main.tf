variable "candidate_roles" {
  type = list(string)
  default = [
    "roles/secretmanager.secretAccessor",
    "roles/container.developer",
    "roles/logging.viewer",
    "roles/monitoring.admin",
    "roles/storage.objectAdmin",
#    "roles/storage.legacyBucketReader",
    "roles/run.invoker",
    "roles/run.viewer",
  ]
}
variable "project_id" {
  type = string
}
variable "candidate_email" {
  type = string
}

resource "google_project_iam_member" "candidate_roles" {
  for_each = toset(var.candidate_roles)
  project = var.project_id
  role    = each.key
  member  = "user:${var.candidate_email}"
}