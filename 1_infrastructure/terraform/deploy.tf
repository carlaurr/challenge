resource "helm_release" "my_app" {
  name       = "my-app"
  namespace  = "challenge"
  repository = "https://charts.helm.sh/stable"
  chart      = "./app-chart"
  version    = "1.0.0"

  create_namespace = true

  values = [
    file("./app-chart/values.yaml"),
  ]
}
