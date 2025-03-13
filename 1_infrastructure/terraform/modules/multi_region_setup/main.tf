module "network" {
  source = "../networking"

  project_id = var.project_id
  subnets     = {
    "us-central1" = "10.0.0.0/16",
    "eu-north1"   = "10.1.0.0/16",
    "eu-east1"    = "10.2.0.0/16",
  }
}