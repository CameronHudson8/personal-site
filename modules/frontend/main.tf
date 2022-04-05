locals {
  service_name = "frontend"
  service_port = 80
}

resource "kubernetes_deployment" "frontend" {
  metadata {
    namespace = var.namespace
    name      = "frontend"
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        "app" = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          "app" = "frontend"
        }
      }
      spec {
        container {
          name  = "frontend"
          image = var.image
          port {
            container_port = local.service_port
          }
          liveness_probe {
            http_get {
              port = local.service_port
              path = "/"
            }
          }
          readiness_probe {
            http_get {
              port = local.service_port
              path = "/"
            }
          }
          resources {
            limits = {
              memory = "32Mi"
            }
            requests = {
              memory = "32Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    namespace = var.namespace
    name      = local.service_name
  }
  spec {
    type = "ClusterIP"
    selector = {
      "app" = "frontend"
    }
    port {
      port        = local.service_port
      target_port = local.service_port
    }
  }
}

resource "kubernetes_ingress" "personal-site" {
  for_each = toset(var.frontend_hostnames)

  wait_for_load_balancer = true
  metadata {
    namespace = var.namespace
    name      = each.value
    annotations = {
      "cert-manager.io/cluster-issuer"                    = var.cert_issuer
      "nginx.ingress.kubernetes.io/configuration-snippet" = "more_set_input_headers \"strict-transport-security: max-age=63072000; includeSubDomains; preload\";"
      "nginx.ingress.kubernetes.io/server-snippet"        = <<-EOF
        if ($host ~ "www.${each.value}") {
          return 308 "https://${each.value}$request_uri";
        }
        EOF
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = each.value
      http {
        path {
          path = "/"
          backend {
            service_name = local.service_name
            service_port = local.service_port
          }
        }
      }
    }
    rule {
      host = "www.${each.value}"
      http {
        path {
          path = "/"
          backend {
            service_name = local.service_name
            service_port = local.service_port
          }
        }
      }
    }
    tls {
      hosts = [
        each.value,
        "www.${each.value}"
      ]
      secret_name = "tls-${each.value}"
    }
  }
}