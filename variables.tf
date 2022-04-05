variable "create_infrastructure" {
  type = bool
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
