variable "cert_issuer" {
  type = string
}

variable "create_infrastructure" {
  type = bool
}

variable "frontend_hostnames" {
  type = list(string)
}

variable "frontend_replicas" {
  default = 2
  type    = number
}

variable "gcp_project" {
  default = "cameronhudson8"
  type    = string
}

variable "ingress_service_namespace" {
  default = "ingress"
  type    = string
}

variable "ingress_service_name" {
  default = "ingress-nginx-controller"
  type    = string
}

variable "location" {
  default = "us-west1"
  type    = string
}

variable "image_frontend" {
  default = "us-west1-docker.pkg.dev/cameronhudson8/personal-site/frontend:dea1daed1fa17dd0295fc317fa1fb80f34ac6159"
  type    = string
}

variable "namespace" {
  default = "personal-site"
  type    = string
}
