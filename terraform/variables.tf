variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources in"
  type        = string
  default     = "europe-west1"
}

variable "github_owner" {
  description = "GitHub repository owner - username"
  type        = string
}

variable "repo_name" {
  description = "GitHub repository name."
  type        = string
}

variable "buildsaname" {
  description = "Service account email used by Cloud Build triggers"
  type        = string
}


variable "github_app_installation_id" {
  description = "GitHub App Installation ID for Cloud Build connection"
  type        = number
}

variable "github_oauth_token_secret" {
  description = "Secret Manager resource name for GitHub OAuth token - (format: projects/PROJECT_ID/secrets/SECRET_NAME/versions/VERSION)"
  type        = string
}

variable "dockertag" {
  description = "Docker image version for the Cloud Run service"
  type        = string
  default = "latest"
}

variable "cloudsql_password_secret" {
  description = "Secret Manager resource name for Cloud SQL password - (format: projects/PROJECT_ID/secrets/SECRET_NAME/versions/VERSION)"
  type        = string
}