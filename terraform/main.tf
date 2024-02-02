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

resource "google_storage_bucket_object" "function_code" {
  name   = "function-source.zip"  # Name of the object in the bucket
  bucket = "kukisnake_bucket"      # Name of the Cloud Storage bucket
  #content_encoding    = "gzip"
  #storage_class       = "STANDARD"
  #content_disposition = "attachment"
  #content_type        = "application/zip"
  source = "${path.module}/../backend_function/index.js"  # Local path to the file to upload
}

resource "google_cloudfunctions_function" "backend_function" {
  name                   = var.backend_function_name
  runtime                = var.backend_runtime
  source_archive_bucket = var.source_bucket
  source_archive_object = var.source_object
  entry_point            = var.entry_point
  trigger_http           = var.trigger_http
  project                = var.project_id
}

resource "google_compute_instance" "vm_instance" {
  name         = "kukisnake-vm"
  machine_type = "e2-micro"  # Update with desired machine type
  zone         = "us-central1-a"  # Update with desired zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"  # Update with desired OS image
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}

/*# Create a Google Cloud Firestore database
resource "google_firestore_database" "database" {
  project = var.project_id
  name    = "kukisnake_database"
  location_id = var.region  # Specify the desired location
  type    = "DATASTORE_MODE"
}*/
