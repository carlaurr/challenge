resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = var.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "27.5.1"  # https://artifacthub.io/packages/helm/prometheus-community/prometheus

  # TODO: Adjust the prometheus configuration
  values = [
    # <<-EOF
    # prometheus:
    #   prometheusSpec:
    #     serviceMonitorSelectorNilUsesHelmValues: false
    # server:
    #   persistentVolume: enabled
    # EOF
  ]
}

resource "helm_release" "prometheus_adapter" {
  name       = "prometheus-adapter"
  namespace  = var.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-adapter"
  version    = "4.13.0"  # https://artifacthub.io/packages/helm/prometheus-community/prometheus-adapter

  # TODO: Adjust the prometheus-adapter configuration
  values = [
    # <<-EOF
    # prometheus:
    #   url: http://prometheus-operated.monitoring.svc  # Replace with your Prometheus service
    #   port: 9090
    # rules:
    #   default: true
    #   custom:
    #     - seriesQuery: '{__name__=~"http_requests_total"}'
    #       resources:
    #         overrides:
    #           namespace: {resource: "namespace"}
    #           pod: {resource: "pod"}
    #       name:
    #         matches: "http_requests_total"
    #         as: "http_requests"
    #       metricsQuery: "sum(rate(http_requests_total[2m]))"
    # EOF
  ]
}

