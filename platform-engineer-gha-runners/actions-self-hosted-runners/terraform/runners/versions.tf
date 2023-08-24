
terraform {
  backend "gcs" {
    bucket  = "msmg-platengchal-bm-tfstate"
    prefix  = "runners"
  }
  required_version = ">= 0.13"
  required_providers {

    google = {
      source  = "hashicorp/google"
      version = ">= 4.3.0, < 5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}
