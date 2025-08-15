# GitHub Connection for 2nd Gen Repository
resource "google_cloudbuild_v2_connection" "github_connection" {
  project  = var.project_id
  location = var.region
  name     = "github-connection"

  github_config {
    app_installation_id = var.github_app_installation_id
    authorizer_credential {
      oauth_token_secret_version = var.github_oauth_token_secret
    }
  }
}

# Repository resource
resource "google_cloudbuild_v2_repository" "repo" {
  project           = var.project_id
  location          = var.region
  name              = var.repo_name
  parent_connection = google_cloudbuild_v2_connection.github_connection.name
  remote_uri        = "https://github.com/${var.github_owner}/${var.repo_name}.git"
}

# PR Trigger
resource "google_cloudbuild_trigger" "cloud_run_pr_trigger" {
  name        = "cloud-run-pr-trigger"
  description = "Trigger for Cloud Run plan on pull request"
  location    = var.region
  project     = var.project_id
  
  service_account = "projects/${var.project_id}/serviceAccounts/${var.buildsaname}"
  
  repository_event_config {
    repository = google_cloudbuild_v2_repository.repo.id
    
    pull_request {
      branch = "^main$"
    }
  }

  filename = "terraform/cloudbuild.yaml"

  substitutions = {
    _APPLY = "N"
  }
}

# Push Trigger
resource "google_cloudbuild_trigger" "cloud_run_push_trigger" {
  name        = "cloud-run-push-trigger"
  description = "Trigger for Cloud Run apply on push request"
  location    = var.region
  project     = var.project_id
  
  service_account = "projects/${var.project_id}/serviceAccounts/${var.buildsaname}"
  
  repository_event_config {
    repository = google_cloudbuild_v2_repository.repo.id
    
    push {
      branch = "^main$"
    }
  }

  filename = "terraform/cloudbuild.yaml"

  substitutions = {
    _APPLY = "Y"
  }
}

# Tag Trigger
resource "google_cloudbuild_trigger" "docker_tag_build" {
  name        = "docker-tag-build"
  description = "Trigger for tag based build for docker image"
  location    = var.region
  project     = var.project_id
  
  service_account = "projects/${var.project_id}/serviceAccounts/${var.buildsaname}"

  repository_event_config {
    repository = google_cloudbuild_v2_repository.repo.id
    
    push {
      tag = "^v.*$"
    }
  }

  filename = "terraform/dockerimage.yaml"

  substitutions = {
    _APPLY           = "Y"
    _APPREGISTRYPATH = "europe-west1-docker.pkg.dev/hazel-sky-467411-j9/britedge-e1"
    _IMAGE_NAME      = "britedge-run"
  }
}