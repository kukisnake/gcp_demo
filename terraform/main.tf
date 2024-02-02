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
    index_document = "index.html"
    error_document = "error.html"
  }
}

# Create a Google Cloud Function for the backend
resource "google_cloudfunctions_function" "backend_function" {
  name        = var.backend_function_name
  runtime     = var.backend_runtime
  source_code = "${path.module}/backend_function"
  entry_point = "handler"
}

# Create a Google Cloud Firestore database
resource "google_firestore_database" "database" {
  project = var.project_id
}

# Define the resources
resource "google_compute_instance" "vm_instance" {
  name         = "planszomania_kukisnake"
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

