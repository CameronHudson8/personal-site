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
    prefix               = "application/local/${run_cmd("--terragrunt-quiet", "whoami")}"
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
  create_infrastructure = false
}

generate "providers" {
  path      = "terragrunt_generated_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<-EOF
    provider "kubernetes" {
      config_path    = "~/.kube/config"
      config_context = "minikube"
    }
  EOF
}
