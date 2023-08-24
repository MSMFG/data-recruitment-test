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

module "project_setup" {
  source = "./project_setup"

  billing_account    = var.billing_account
  candidate_email    = var.candidate_email
  candidate_initials = var.candidate_initials
  folder_id          = var.folder_id
  gh_token           = var.gh_token
}

module "permission_grant" {
  source = "./permission_grant"

  candidate_email    = var.candidate_email
  project_id = module.project_setup.project_id
}


