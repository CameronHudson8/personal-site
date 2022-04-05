data "kubernetes_service" "nginx" {
  metadata {
    namespace = var.ingress_service_namespace
    name      = var.ingress_service_name
  }
}

# cameronhudson.info

resource "google_dns_managed_zone" "cameronhudson_info" {
  project     = var.gcp_project
  name        = "cameronhudson-info"
  dns_name    = "cameronhudson.info."
  description = "Managed zone for Cameron Hudson's personal site"
}

resource "google_dns_record_set" "cameronhudson_info" {
  project      = var.gcp_project
  managed_zone = google_dns_managed_zone.cameronhudson_info.name
  name         = "cameronhudson.info."
  type         = "A"
  rrdatas      = [data.kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].ip]
  ttl          = 300
}

resource "google_dns_record_set" "www_cameronhudson_info" {
  project      = var.gcp_project
  managed_zone = google_dns_managed_zone.cameronhudson_info.name
  name         = "www.cameronhudson.info."
  type         = "A"
  rrdatas      = [data.kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].ip]
  ttl          = 300
}

# cameronhudson8.com

resource "google_dns_managed_zone" "cameronhudson8_com" {
  project     = var.gcp_project
  name        = "cameronhudson8-com"
  dns_name    = "cameronhudson8.com."
  description = "Managed zone for Cameron Hudson's personal site"
}

resource "google_dns_record_set" "cameronhudson8_com" {
  project      = var.gcp_project
  managed_zone = google_dns_managed_zone.cameronhudson8_com.name
  name         = "cameronhudson8.com."
  type         = "A"
  rrdatas      = [data.kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].ip]
  ttl          = 300
}

resource "google_dns_record_set" "www_cameronhudson8_com" {
  project      = var.gcp_project
  managed_zone = google_dns_managed_zone.cameronhudson8_com.name
  name         = "www.cameronhudson8.com."
  type         = "A"
  rrdatas      = [data.kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].ip]
  ttl          = 300
}

# Container image registries

resource "google_artifact_registry_repository" "frontend" {
  provider = google-beta
  project       = var.gcp_project
  location      = var.location
  repository_id = "personal-site"
  description   = "Contains images for Cameron Hudson's personal site"
  format        = "DOCKER"
}
