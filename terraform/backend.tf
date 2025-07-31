terraform {
  backend "gcs" {
    bucket  = "louisd-tfstate-bucket1"
    prefix  = "prod/state"
  }
}