resource "google_container_cluster" "primary" {
  name     = local.gke_cluster_name
  location = local.gke_location

  enable_autopilot = true  # Autopilot enabled for free-tier eligibility

  # HA using a regional cluster that spans multiple zones, workloads are shifted automatically
  # to another zone in case of a zonal failure
  
  # node_locations   = ["us-central1-a", "us-central1-b", "us-central1-c"]

  # node_pool {
  #   name       = "default-pool"
  #   node_count = 3
  # }
}

output "cluster_name" {
  value = google_container_cluster.primary.name
}