remote_state {
  backend = "gcs"
  generate = {
    path      = "terragrunt_generated_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    project              = "cameronhudson8"
    location             = "us-west1"
    bucket               = "personal-site-tf-state"
    prefix               = "application/prod"
    skip_bucket_creation = true
  }
}

terraform {
  extra_arguments "init_args" {
    commands = [
      "init"
    ]
    arguments = [
      "-lockfile=readonly",
    ]
  }
  source = "../..//."
}

inputs = {
  cert_issuer           = "lets-encrypt-prod"
  create_infrastructure = true
  frontend_hostnames = [
    "cameronhudson.info",
    "cameronhudson8.com"
  ]
}

generate "providers" {
  path      = "terragrunt_generated_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<-EOF

    data "google_container_cluster" "general_purpose" {
      project  = "cameronhudson8"
      name     = "general-purpose-cluster"
      location = "us-west1-a"
    }

    provider "kubernetes" {
      host                   = "https://$${data.google_container_cluster.general_purpose.endpoint}"
      client_certificate     = base64decode(data.google_container_cluster.general_purpose.master_auth[0].client_certificate)
      client_key             = base64decode(data.google_container_cluster.general_purpose.master_auth[0].client_key)
      cluster_ca_certificate = base64decode(data.google_container_cluster.general_purpose.master_auth[0].cluster_ca_certificate)
    }

  EOF
}
