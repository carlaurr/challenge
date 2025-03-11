resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-cluster"
  location = var.region

  enable_autopilot = var.gke_enable_autopilot

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name 
}

# Google recommends to use a separate node pool to avoid cluster recreation when a node poool
# is added or removed. (https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster)
resource "google_container_node_pool" "nodes" {
  count = var.gke_enable_autopilot ? 0 : 1
  name       = "${var.project_id}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    preemptible  = var.gke_nodes_preemptible
    machine_type = var.gke_nodes_machine_type

    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      project = var.project_id
      env = var.env
    }
  }
}
