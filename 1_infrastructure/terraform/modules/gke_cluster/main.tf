resource "google_container_cluster" "cluster" {
  name     = "${var.project_id}-cluster"
  location = var.region

  enable_autopilot = var.gke_enable_autopilot

  network    = var.vpc_id
  subnetwork = var.subnet_id
}

# Google recommends to use a separate node pool to avoid cluster recreation when a node poool
# is added or removed. (https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster)
resource "google_container_node_pool" "cluster" {
  count = var.gke_enable_autopilot ? 0 : 1
  name       = "${var.project_id}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.cluster.name
  node_count = var.gke_num_nodes

  # Specify multiple zones where the nodes will be distributed
  node_locations = [
    "${var.region}-a",
    "${var.region}-b",
    "${var.region}-c"
  ]

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
