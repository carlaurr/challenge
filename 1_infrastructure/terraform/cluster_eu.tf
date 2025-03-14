module "cluster_eu" {
  source = "./modules/gke_cluster"

  project_id = local.project_id
  region     = "eu-north1"

  gke_enable_autopilot = false

  gke_num_nodes          = 3
  gke_nodes_machine_type = "e2-medium"
  gke_nodes_preemptible  = "true"

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.subnet_ids[0]

  providers = {
    google = google.eu
  }
}

module "monitoring_eu" {
  source = "./modules/monitoring"

  namespace      = "monitoring"
  deploy_grafana = "true"

  providers = {
    google = google.eu
  }
}
