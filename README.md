# 🚀 Terraform Kubernetes: Bookinfo App (Istio Sample)

This repository contains a Terraform project to deploy the [Istio Bookinfo](https://istio.io/latest/docs/examples/bookinfo/) sample application on Kubernetes using the stable `kubernetes` provider with native Terraform Kubernetes resources.

> 🧩 The goal: Replace `kubectl apply -f bookinfo.yaml` with fully managed Terraform code.

---

## 📊 Architecture Diagram

![image](https://github.com/user-attachments/assets/5b86c119-430b-453a-b38a-1c2114e112a6)


> Based on: [Istio's official Bookinfo YAML](https://github.com/istio/istio/blob/master/samples/bookinfo/platform/kube/bookinfo.yaml)

---

## 🧱 Project Structure

| Component     | Resource Types                |
|---------------|-------------------------------|
| `details`     | Deployment, Service, SA       |
| `ratings`     | Deployment, Service, SA       |
| `reviews`     | 3 Deployments, Service, SA    |
| `productpage` | Deployment, Service, SA       |


🔍 Application UI Preview
![image](https://github.com/user-attachments/assets/3739a5dc-3d5b-42a3-b5c7-f55633a51db5)

### 📦 Running Pods Overview

```bash
$ kubectl get pods -o wide
NAME                              READY   STATUS    RESTARTS   AGE     IP          NODE         NOMINATED NODE   READINESS GATES
details-v1-766844796b-zsgm2       1/1     Running   0          7h59m   <hidden>    132-worker    <none>           <none>
details-v1-pod                    1/1     Running   0          52m     <hidden>    132-worker2   <none>           <none>
details-v1-rc-6n6d2               1/1     Running   0          14m     <hidden>    132-worker3   <none>           <none>
details-v1-rc-hklw5               1/1     Running   0          14m     <hidden>    132-worker    <none>           <none>
details-v1-rc-jk5gk               1/1     Running   0          14m     <hidden>    132-worker2   <none>           <none>
productpage-v1-54bb874995-9dds4   1/1     Running   0          6h5m    <hidden>    132-worker2   <none>           <none>
productpage-v1-pod                1/1     Running   0          52m     <hidden>    132-worker2   <none>           <none>
productpage-v1-rc-g6m5q           1/1     Running   0          6m5s    <hidden>    132-worker2   <none>           <none>
ratings-v1-5dc79b6bcd-ffdxz       1/1     Running   0          7h54m   <hidden>    132-worker3   <none>           <none>
ratings-v1-pod                    1/1     Running   0          52m     <hidden>    132-worker    <none>           <none>
ratings-v1-rc-gsm9q               1/1     Running   0          60s     <hidden>    132-worker3   <none>           <none>
reviews-v1-5594f9f46d-tn49h       1/1     Running   0          7h1m    <hidden>    132-worker2   <none>           <none>
reviews-v1-pod                    1/1     Running   0          52m     <hidden>    132-worker3   <none>           <none>
reviews-v2-78c54884d-m8nnj        1/1     Running   0          7h1m    <hidden>    132-worker    <none>           <none>
reviews-v2-pod                    1/1     Running   0          52m     <hidden>    132-worker    <none>           <none>
reviews-v3-cbb65f848-69fm7        1/1     Running   0          7h1m    <hidden>    132-worker3   <none>           <none>
reviews-v3-pod                    1/1     Running   0          52m     <hidden>    132-worker2   <none>           <none>

```

All resources are created using `kubernetes_manifest` blocks for maximum compatibility and version flexibility.

---

## ⚙️ How to Deploy

```bash
terraform init
terraform apply
