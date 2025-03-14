module "cluster_us" {
  source = "./modules/gke_cluster"

  project_id = local.project_id
  region     = "us-central1"

  gke_enable_autopilot = false

  gke_num_nodes          = 3
  gke_nodes_machine_type = "e2-medium"
  gke_nodes_preemptible  = "true"

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.subnet_ids[0]

  providers = {
    google = google.us
  }
}

module "monitoring_us" {
  source = "./modules/monitoring"

  namespace      = "monitoring"
  deploy_grafana = "false"

  providers = {
    google = google.eu
  }
}
