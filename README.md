# 🧱 Homelab DevOps in AWS
This project is a personal lab environment on AWS with real DevOps practices. The goal is to simulate a productive 24/7 infrastructure with multiple applications, observability, GitOps, security and automation.

## 🚀 Technologies used
- Kubernetes (K3s)
- Docker
- Terraform + Ansible
- AWS EC2 Spot + EBS + Route 53
- PostgreSQL (with monitoring)
- ArgoCD
- Prometheus + Grafana + Loki
- Let's Encrypt (cert-manager)
- GitHub Actions (CI/CD)
- Homepage (central dashboard)

## 🌍 Apps deployed (In progress...)
| App               | Subdomain              |
|-------------------|--------------------------|
| Homepage          | home.julian-lab.com      |
| Portfolio Web     | julian-lab.com           |
| PendingTask       | pendingtask.julian-lab.com   |
| Grafana           | grafana.julian-lab.com   |
| ArgoCD            | argocd.julian-lab.com    |
| Prometheus        |           -              |
| Loki              |           -              |

## 🧩 Infrastructure
3 EC2 Spot instances (`t4g.small` x2 + `t4g.micro`) with EBS volumes (`10GB each one`) and custom domain. K3s is installed on them and orchestrates all services, exposed with HTTPS thanks to NGINX Ingress + cert-manager.

## 🧠 Objective
Learn and demonstrate professional skills in:

- True cloud deployment
- Centralised monitoring and logging
- Cloud security
- GitOps + CI/CD
- Infrastructure as code

## ✅ Roadmap by stages
- ### 🟩 Stage 1 - Apps
    - ✅ PendingTask and Portfolio with Docker.
    - ✅ Try in Minikube.
    - ✅ Create all necessary YAML manifests.

- ### 🟨 Stage 2 — AWS Infrastructure
    - ✅ Configure Terraform to deploy:
        - VPC infra ✅
        - Security Groups ✅
        - 3 EC2 Spot Instances (1 master, 2 workers) + EBS ✅
        - Elastic IP + Route53 ✅
    - ✅ Test provisioning and connectivity

- ### 🟨 Stage 3 — K3s & Core Services
    - ☐ Install K3s and connect nodes
    - ☐ Deploy NGINX Ingress Controller
    - ☐ Set up cert-manager and Let's Encrypt
    - ☐ Route DNS to Elastic IP with Route 53

- ### 🟦 Stage 4 — Deploy & GitOps
    - ☐ Deploy all applications to cluster
    - ☐ Deploy PostgreSQL Exporter
    - ☐ Install Prometheus, Grafana and Loki
    - ☐ Install ArgoCD and link Git repo
    - ☐ Secure apps with HTTPS

- ### 🟪 Stage 5 — Final touches
    - ☐ Create Grafana dashboards
    - ☐ Automate deployments with GitHub Actions
    - ☐ Add screenshots to README
    - ☐ Backup and snapshot strategy (optional)