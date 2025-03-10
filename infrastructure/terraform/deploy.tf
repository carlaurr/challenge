resource "helm_release" "my_app" {
  name       = "my-app"
  namespace  = "default"
  repository = "https://charts.helm.sh/stable"
  chart      = "./app-chart"
  version    = "1.0.0"

  values = [
    file("./app-chart/values.yaml"),
  ]
}
