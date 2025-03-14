provider "google" {
  project = local.gcp_project_id
  region  = "us-central1"
  alias   = "us"
}

provider "google" {
  project = local.gcp_project_id
  region  = "eu-north1"
  alias   = "eu"
}
