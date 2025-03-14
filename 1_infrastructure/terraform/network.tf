module "network" {
  source = "./modules/networking"

  project_id = local.project_id
  subnets = {
    "us-central1" = "10.0.0.0/16",
    "eu-north1"   = "10.1.0.0/16",
  }
}
