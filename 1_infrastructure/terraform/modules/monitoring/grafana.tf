resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = var.namespace
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "8.10.3"  # https://artifacthub.io/packages/helm/grafana/grafana

  # TODO: Adjust the grafana configuration
  values = [
    # <-EOF
    # persistence:
    #   enabled: true
    # EOF
  ]
}