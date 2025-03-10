provider "google" {
  project = local.project_id
  region  = "us-central1"
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.primary.endpoint}"
        token = data.google_client_config.provider.access_token
        cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate,)
        exec {
          api_version = "client.authentication.k8s.io/v1beta1"
          command     = "gke-gcloud-auth-plugin"
        }
  }
}