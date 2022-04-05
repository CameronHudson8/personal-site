module "infrastructure" {
  count                     = var.create_infrastructure ? 1 : 0
  source                    = "./modules/infrastructure"
  gcp_project               = var.gcp_project
  ingress_service_namespace = var.ingress_service_namespace
  ingress_service_name      = var.ingress_service_name
  location                  = var.location
}

module "namespaces" {
  source    = "./modules/namespaces"
  namespace = var.namespace
}

module "frontend" {
  depends_on = [
    module.namespaces
  ]
  source             = "./modules/frontend"
  cert_issuer        = var.cert_issuer
  frontend_hostnames = var.frontend_hostnames
  image              = var.image_frontend
  namespace          = var.namespace
  replicas           = var.frontend_replicas
}
