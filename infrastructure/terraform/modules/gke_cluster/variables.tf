variable "project_id" {
  description = "Project name or id. It's will be used as a resource name prefix to avoid conflicts and improve ownership."
  type        = string
}

variable "env" {
  description = "Environment name [production, stage, testing]"
  type        = string
  default     = "production"
}

variable "region" {
  description = "GCP region where the resources will be created"
  type        = string
  default     = "us-central1"
}

variable "gke_enable_autopilot" {
  description = "Enable autopilot mode for the GKE cluster. Enable it for GCP free-tier eligibility"
  type        = bool
  default     = false
}

variable "gke_num_nodes" {
  description = "Number of nodes in the GKE cluster. Default is 3 to guarantee HA"
  type        = number
  default     = 3
}

variable "gke_nodes_machine_type" {
  description = "Machine type for the GKE nodes"
  type        = string
  default     = "e2-medium"
}

variable "gke_nodes_preemptible" {
  description = "Use preemptible nodes for the GKE cluster. These nodes can be terminated at any time and are less expensive"
  type        = bool
  default     = true
}
