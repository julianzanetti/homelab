# 🧱 Homelab DevOps in AWS
This repo contains all of the configuration and documentation of my homelab in AWS, the project is a personal lab environment on AWS with real DevOps practices. 

The goal is to simulate a productive 24/7 infrastructure with multiple applications, observability, GitOps, security and automation. This homelab is the place where I can try out and learn new things. By self-hosting some aplications, it makes me feel responsible for the entire process of deploying and mantaining. It forces me think about backup strategies, security, scalability, etc.

## 🚀 Technologies used
- Kubernetes (K3s)
- Docker
- Terraform + Ansible
- AWS EC2 Spot + EBS + Route 53
- Don Web (domain)
- Helm
- PostgreSQL (with monitoring)
- ArgoCD
- Prometheus + Grafana + Loki
- Let's Encrypt (cert-manager)
- GitHub Actions (CI/CD)
- Homepage (central dashboard)

## 🌍 Apps deployed (In progress...)
| App               | Subdomain              |
|-------------------|--------------------------|
| Homepage          | [home.julianzanetti-lab.com](https://home.julianzanetti-lab.com)      |
| Portfolio Web     | [julianzanetti-lab.com](https://julianzanetti-lab.com)           |
| PendingTask       | [pendingtask.julianzanetti-lab.com](https://pendingtask.julianzanetti-lab.com)   |
| Grafana           | [grafana.julianzanetti-lab.com](https://grafana.julianzanetti-lab.com)   |
| ArgoCD            | [argocd.julianzanetti-lab.com](https://argocd.julianzanetti-lab.com)    |
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

- ### 🟩 Stage 2 — AWS Infrastructure
    - ✅ Configure Terraform to deploy:
        - ✅ VPC infra
        - ✅ Security Groups
        - ✅ 3 EC2 Spot Instances (1 master, 2 workers) + EBS
        - ✅ Elastic IP
    - ✅ Test provisioning and connectivity

- ### 🟩 Stage 3 — K3s & Core Services
    - ✅ Install K3s and connect nodes with Ansible
    - ✅ Deploy NGINX Ingress Controller with Helm
    - ❌ Route DNS to Elastic IP with DonWeb *(Deprecated – migrated to Route 53)*
    - ✅ Configure Route53 hosted zone for julianzanetti-lab.com
    - ✅ Create IAM user and policy for cert-manager DNS access
    - ✅ Deploy cert-manager with Helm
    - ✅ Set up ClusterIssuer with DNS-01 using Route53
    - ✅ Issue Let's Encrypt certificates automatically for each app
    - ✅ Force HTTPS with valid TLS certificates in all apps

- ### 🟦 Stage 4 — Deploy & GitOps
    - 🟧 Deploy all applications to cluster
    - ☐ Deploy PostgreSQL Exporter
    - ✅ Install Prometheus, Grafana and Loki
    - ✅ Install ArgoCD and link Git repo

- ### 🟪 Stage 5 — Final touches
    - 🟧 Create Grafana dashboards
    - ☐ Automate deployments with GitHub Actions
    - ☐ Add screenshots to README
    - ☐ Backup and snapshot strategy (optional)
    - ☐ Script to keep the 3 spot instances up
    - 🟧 Self-healing script/infra for Spot Instances → Auto Scaling Group + UserData + Lambda drain
