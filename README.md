# 🚀 Terraform Kubernetes: Bookinfo App (Istio Sample)

This repository contains a Terraform project to deploy the [Istio Bookinfo](https://istio.io/latest/docs/examples/bookinfo/) sample application on Kubernetes using the stable `kubernetes` provider with native Terraform Kubernetes resources.

> 🧩 The goal: Replace `kubectl apply -f bookinfo.yaml` with fully managed Terraform code.

---

## 📊 Architecture Diagram

![Bookinfo Architecture](./86695625-e80e-4f2e-a86a-258d870af96e.png)

> Based on: [Istio's official Bookinfo YAML](https://github.com/istio/istio/blob/master/samples/bookinfo/platform/kube/bookinfo.yaml)

---

## 🧱 Project Structure

| Component     | Resource Types                |
|---------------|-------------------------------|
| `details`     | Deployment, Service, SA       |
| `ratings`     | Deployment, Service, SA       |
| `reviews`     | 3 Deployments, Service, SA    |
| `productpage` | Deployment, Service, SA       |

.
├── tf-bookinfo-deployment/ # All Bookinfo services, grouped by microservice version
│ ├── details-v1/ # Terraform manifests for details-v1
│ ├── productpage-v1/ # Terraform manifests for productpage-v1
│ ├── ratings-v1/ # Terraform manifests for ratings-v1
│ └── reviews/ # Contains reviews-v1, reviews-v2, reviews-v3
├── tf-bookinfo-pods/ # (Optional) Pod-level manifests if needed
├── tf-bookinfo-rs/ # (Optional) ReplicaSet-level manifests
├── docs/ # Architecture diagrams and documentation
│ └── bookinfo-architecture.png
├── main.tf # Provider configuration and root definitions
├── variables.tf # Shared variables
├── outputs.tf # Terraform outputs (if needed)
├── versions.tf # Provider version pinning
├── .gitignore # Ignore local state and temp files
└── README.md # This documentation

All resources are created using `kubernetes_manifest` blocks for maximum compatibility and version flexibility.

---

## ⚙️ How to Deploy

```bash
terraform init
terraform apply
