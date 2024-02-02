# Configure the Google Cloud provider
provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}

# Create a Google Cloud Storage bucket for the frontend
resource "google_storage_bucket" "frontend_bucket" {
  name     = var.frontend_bucket_name
  location = var.region

  website {
    main_page_suffix = "index.html"
    not_found_page   = "error.html"
  }
}


resource "google_cloudfunctions_function" "backend_function" {
  name        = var.backend_function_name
  runtime     = var.backend_runtime
  source_archive_bucket = var.source_bucket
  source_archive_object = var.source_object
  # Or, if deploying from a repository:
  # source_repository = var.source_repository
  # source_repository_branch = var.source_repository_branch
  entry_point = "handler"
}

# Create a Google Cloud Firestore database
resource "google_firestore_database" "database" {
  project = var.project_id
  name    = "example-database"
  location_id = var.region  # Specify the desired location
  type    = "DATASTORE_MODE"
}
