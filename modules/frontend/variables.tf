variable "cert_issuer" {
  type = string
}

variable "frontend_hostnames" {
  type = list(string)
}

variable "image" {
  type = string
}

variable "namespace" {
  type = string
}

variable "replicas" {
  type = number
}
