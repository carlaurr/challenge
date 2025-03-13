provider "google" {
  project = local.gcp_project_id
  region  = local.region
}

provider "helm" {
  kubernetes {
    host  = "https://${module.cluster.cluster_endpoint}"
        token = data.google_client_config.provider.access_token
        cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate,)
        exec {
          api_version = "client.authentication.k8s.io/v1beta1"
          command     = "gke-gcloud-auth-plugin"
        }
  }
}