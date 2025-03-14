output "vpc_id" {
  value = google_compute_network.global_vpc.id
}

output "subnet_ids" {
  value = google_compute_subnetwork.subnet.*.id
}
