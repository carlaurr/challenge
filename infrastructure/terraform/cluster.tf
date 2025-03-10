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

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  create_namespace = true
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.17.1"  # https://artifacthub.io/packages/helm/cert-manager/cert-manager
  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name = "global.leaderElection.namespace"
    value = "cert-manager"
  }
}

resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  namespace        = "ingress-nginx"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.12.0"
  
  set {
    name  = "controller.replicaCount"
    value = "2"
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.service.type"
    value = "NodePort" 
  }

  set {
    name  = "controller.service.nodePorts.http"
    value = "30080"
  }

  set {
    name  = "controller.service.nodePorts.https"
    value = "30443"
  }
}
