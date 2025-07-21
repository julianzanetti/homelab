# 🧱 Homelab DevOps in AWS
This project is a personal lab environment on AWS with real DevOps practices. The goal is to simulate a productive 24/7 infrastructure with multiple applications, observability, GitOps, security and automation.

## 🚀 Technologies used
- Kubernetes (K3s)
- Docker
- Terraform + Ansible
- AWS EC2 Spot + EBS + Route 53
- PostgreSQL (con monitoreo)
- ArgoCD
- Prometheus + Grafana + Loki
- Let's Encrypt (cert-manager)
- GitHub Actions (CI/CD)
- Homepage (dashboard central)

## 🌍 Apps deployed
| App               | Subdomain              |
|-------------------|--------------------------|
| Homepage          | home.julian-lab.com      |
| Portfolio Web     | julian-lab.com           |
| PendingTask       | pendingtask.julian-lab.com   |
| Grafana           | grafana.julian-lab.com   |
| ArgoCD            | argocd.julian-lab.com    |

## 🧩 Infrastructure
3 EC2 Spot instances (`t4g.small` x2 + `t4g.micro`) with EBS volumes (10GB each one) and custom domain. K3s is installed on them and orchestrates all services, exposed with HTTPS thanks to NGINX Ingress + cert-manager.

## 🧠 Objective
Learn and demonstrate professional skills in:

- True cloud deployment
- Centralised monitoring and logging
- Cloud security
- GitOps + CI/CD
- Infrastructure as code

## ✅ Roadmap by stages
- ### Stage 1 - Apps
    - ✅ PendingTask and Portfolio with Docker.
    - ✅ Try in Minikube.
    - ✅ Create all necessary YAML manifests.