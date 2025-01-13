terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.18.3"
    }
  }
}

data "external" "env" {
  program = ["${path.module}/env.sh"]
}

provider "github" {
  token = data.external.env.result["GITHUB_TOKEN"]
}


resource "github_repository" "echo-service" {
  name        = "echo-service"
  description = "Argo CD example echo-service codebase"
  visibility = "public"
}

output "echo_service_http_clone_url" {
  value = github_repository.echo-service.http_clone_url
}


resource "github_repository" "echo-service-manifest" {
  name        = "echo-service-manifest"
  description = "Argo CD example echo-service-manifest codebase"
  visibility = "public"
}

resource "github_repository" "cluster-bootstrap-manifest" {
  name        = "cluster-bootstrap-manifest"
  description = "Argo CD example cluster-bootstrap-manifest codebase"
  visibility = "public"
}


output "echo_service_manifest_http_clone_url" {
  value = github_repository.echo-service-manifest.http_clone_url
}

output "cluster_bootstrap_manifest_http_clone_url" {
  value = github_repository.cluster-bootstrap-manifest.http_clone_url
}

resource "github_actions_variable" "docker_image_tag_variable" {
  repository       = github_repository.echo-service.name
  variable_name    = "ECHO_SERVICE_DOCKERHUB_IMAGE"
  value            =  data.external.env.result["ECHO_SERVICE_DOCKERHUB_IMAGE"]
}

resource "github_actions_secret" "dockerhub_username_secret" {
  repository       = github_repository.echo-service.name
  secret_name      = "DOCKERHUB_USERNAME"
  plaintext_value  = data.external.env.result["DOCKERHUB_USERNAME"]
}

resource "github_actions_secret" "dockerhub_token_secret" {
  repository       = github_repository.echo-service.name
  secret_name      = "DOCKERHUB_TOKEN"
  plaintext_value  = data.external.env.result["DOCKERHUB_TOKEN"]
}
