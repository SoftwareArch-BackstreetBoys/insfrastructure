## Dependencies

Before setting up the infrastructure, ensure you have the following dependencies installed:

- [Terraform](https://www.terraform.io/downloads) (v1.x or higher)
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)
- [AWS CLI](https://aws.amazon.com/cli/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)

Ensure all tools are properly configured and authenticated with your respective cloud provider before proceeding.

## Terraform Setup

### For GCP
1. Navigate to the GCP Terraform directory:
   ```bash
   cd terraform/gcp
   ```
2. Initialize the Terraform environment:
   ```bash
   terraform init
   ```
3. Apply the Terraform configuration:
   ```bash
   terraform apply
   ```

#### Setup Kubernetes Config
1. Configure Kubernetes to use the GCP cluster:
   ```bash
   gcloud container clusters get-credentials meet-n-feat-gke-cluster --region us-central1-f
   ```

### For AWS
1. Navigate to the AWS Terraform directory:
   ```bash
   cd terraform/aws
   ```
2. Initialize the Terraform environment:
   ```bash
   terraform init
   ```
3. Apply the Terraform configuration with the specified variables:
   ```bash
   terraform apply -var-file terraform.tfvars
   ```

#### Setup Kubernetes Config
1. Configure AWS CLI:
   ```bash
   aws configure
   ```
2. Update your kubeconfig to use the EKS cluster:
   ```bash
   aws eks update-kubeconfig --region us-east-1 --name meat-n-feat-eks-cluster
   ```

## Kubernetes Setup

1. Navigate to the Kubernetes directory:
   ```bash
   cd kubernetes
   ```
2. Add the HashiCorp Helm repository:
   ```bash
   helm repo add hashicorp https://helm.releases.hashicorp.com
   ```
3. Install Consul using Helm:
   ```bash
   helm install consul hashicorp/consul --create-namespace -n consul --version 1.5.3 --values consul-values.yaml 
   ```
4. Apply all Kubernetes manifest files:
   ```bash
   kubectl create namespace service
   kubectl create namespace frontend
   kubectl apply -f .
   ```
