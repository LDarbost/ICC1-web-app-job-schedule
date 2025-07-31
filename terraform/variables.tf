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
