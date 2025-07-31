module "cloud_run_service" {
  source     = "./cloud-run"
  project_id = var.project_id
  cloud_build_trigger = {

  }
}

resource "google_cloudbuild_trigger" "cloud_run_pr_trigger" {
  name        = "cloud-run-pr-trigger"
  description = "Trigger for Cloud Run plan on pull request"
  location = var.region

  github {
    owner = var.github_owner
    name  = var.repo_name
    pull_request {
      invert_regex = false
      branch = "^main$"
    }
  }

  filename = "terraform/cloudbuild.yaml"

  substitutions = {
    _APPLY      = "N"
  }
}

resource "google_cloudbuild_trigger" "cloud_run_push_trigger" {
  name        = "cloud-run-push-trigger"
  description = "Trigger for Cloud Run apply on push request"
  location = var.region

  github {
    owner = var.github_owner
    name  = var.repo_name
    push {
      invert_regex = false
      branch = "^main$"
    }
  }

  filename = "terraform/cloudbuild.yaml"

  substitutions = {
    _APPLY      = "Y"
  }
}

resource "google_cloudbuild_trigger" "docker-tag-build" {
  name        = "docker-tag-build"
  description = "Trigger for tag based build for docker image"
  location = var.region

  github {
    owner = var.github_owner
    name  = var.repo_name
    push {
      invert_regex = false
      tag = "^v.*$"  # Matches tags starting with 'v'
    }
  }

  filename = "terraform/dockerimage.yaml"

  substitutions = {
    _APPLY      = "Y"
    _APPREGISTRYPATH: "europe-west1-docker.pkg.dev/hazel-sky-467411-j9/britedge-e1"
    _IMAGE_NAME: "britedge-run"
  }
}