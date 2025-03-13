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
  version          = "4.12.0"  # https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx
  
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
