resource "google_compute_network" "global_vpc" {
  name                    = "global-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  for_each = var.subnets

  name          = "${var.project_id}-subnet-${each.key}"
  ip_cidr_range = each.value
  network       = google_compute_network.global_vpc.name
  region        = each.key
}
