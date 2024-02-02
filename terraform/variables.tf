variable "credentials_file" {
  description = "Path to the service account key file"
  default     = "C:\\Users\\kukis\\IdeaProjects\\gcp_example\\key\t-lexicon-413012-31c35d46dbcd.json"
}

variable "project_id" {
  description = "GCP project ID"
  default = "t-lexicon-413012"
}

variable "region" {
  description = "GCP region where resources will be provisioned"
  default =  "us-central1"
}

variable "frontend_bucket_name" {
  description = "Name for the Google Cloud Storage bucket for the frontend"
  default = "kukisnake_bucket"
}

variable "backend_function_name" {
  description = "Name for the Google Cloud Function for the backend"
  default = "planszomania_kuki"
}

variable "backend_runtime" {
  description = "Runtime environment for the backend function (e.g., nodejs14)"
  default = "nodejs14"
}

# Create a Google Cloud Function for the backend
variable "source_bucket" {
  default = ""
}
variable "source_object" {
  default = ""
}