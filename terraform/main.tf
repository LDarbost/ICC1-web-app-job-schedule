module "cloud_run_service" {
  source     = "./cloud-run"
  project_id = var.project_id
  cloud_build_trigger = {

  }
}

resource "google_cloudbuild_trigger"