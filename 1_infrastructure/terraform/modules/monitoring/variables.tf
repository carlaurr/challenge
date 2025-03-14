variable "namespace" {
  description = "Namespace to deploy the monitoring stack"
  type        = string
  default     = "monitoring"
}

variable "deploy_grafana" {
  description = "Deploy Grafana in the cluster. If false, only Prometheus will be deployed."
  type        = bool
  default     = true
}
