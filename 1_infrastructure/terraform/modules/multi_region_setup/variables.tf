variable "project_id" {
  description = "Project name or id. It's will be used as a resource name prefix to avoid conflicts and improve ownership."
  type        = string
}

variable "regions_subnets" {
  description = "Map of subnets to create. The key is the region and the value is the subnet CIDR"
  type        = map(string)
  default     = {
    "us-central1" = "10.0.0.0/16",
    "eu-north1"   = "10.1.0.0/16",
    "eu-west"    = "10.2.0.0/16",
  }
}
  

