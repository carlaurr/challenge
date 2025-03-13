module "cluster" {
  source = "./modules/gke_cluster"

  project_id = local.project_id
  region     = local.region

  gke_num_nodes = 3
  gke_nodes_machine_type = "e2-medium"
  gke_nodes_preemptible = true
}
