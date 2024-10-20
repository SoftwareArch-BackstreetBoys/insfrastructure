provider "google" {
  credentials = file("/path/to/cred")
  project = var.gcp_project_id
  region  = var.gcp_region
}

resource "google_compute_network" "meet-n-feat_network" {
  name                    = "meet-n-feat-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "meet-n-feat_private_subnet" {
  name          = "meet-n-feat-private-subnet"
  ip_cidr_range = var.private_subnet_cidr_block
  region       = var.gcp_region
  network      = google_compute_network.meet-n-feat_network.self_link
}

resource "google_compute_subnetwork" "meet-n-feat_public_subnet" {
  name          = "meet-n-feat-public-subnet"
  ip_cidr_range = var.public_subnet_cidr_block
  region       = var.gcp_region
  network      = google_compute_network.meet-n-feat_network.self_link
}

resource "google_container_cluster" "meet-n-feat_gke_cluster" {
  name               = var.k8s_cluster_name
  location           = var.gcp_location
  initial_node_count = 3
  project            = var.gcp_project_id
  remove_default_node_pool = true

  node_config {
    machine_type = "e2-small"  

    disk_type = "pd-standard" 
    disk_size_gb = 10 

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  network    = google_compute_network.meet-n-feat_network.self_link
  subnetwork = google_compute_subnetwork.meet-n-feat_private_subnet.self_link

  resource_labels = {
    environment = "development"
    application = "meatnfeat"
  }
}

resource "google_container_node_pool" "meet-n-feat_node_pool" {
  name       = "meet-n-feat-node-pool"
  location   = var.gcp_location
  cluster    = google_container_cluster.meet-n-feat_gke_cluster.name

  node_count = 3

  autoscaling {
    min_node_count = 3
    max_node_count = 5  
  }

  node_config {
    machine_type = "e2-small" 

    disk_type = "pd-standard"
    disk_size_gb = 10 

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }

}
