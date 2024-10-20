# GCP Project and Region
variable "gcp_project_id" {
  description = "The ID of the GCP project to deploy resources into"
  type        = string
  default     = "meet-n-feat"
}

variable "gcp_region" {
  description = "The GCP region where resources will be deployed"
  default     = "us-central1"
}

variable "gcp_location" {
  default = "us-central1-f"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr_block" {
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr_block" {
  default = "10.0.101.0/24"
}

variable "private_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidr_blocks" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "k8s_version" {
  default = "1.27.16"
}

variable "k8s_cluster_name" {
  default = "meet-n-feat-gke-cluster" 
}
