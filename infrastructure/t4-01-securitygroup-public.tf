module "homelab_sg_public" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "homelab-public-sg"
  description = "Security group for public access in the homelab environment"
  vpc_id      = module.vpc.vpc_id

  # Ingress rules
  ingress_rules = [
    "http-80-tcp",                              # HTTP traffic
    "http-8080-tcp",                           # Alternative HTTP traffic (for ArgoCD)
    "https-443-tcp",                            # HTTPS traffic
    "ssh-tcp",                               # SSH access
    "kubernetes-api-tcp",                       # Kubernetes API access (6443)
    "grafana-tcp",                              # Grafana access (3000)
    "prometheus-http-tcp",                      # Prometheus access (9090)
    "prometheus-pushgateway-http-tcp",          # Prometheus Pushgateway access (9091)
    "prometheus-node-exporter-http-tcp",        # Prometheus Node Exporter access (9100)
    "loki-grafana",                             # Loki access for Grafana (3100)
    "loki-grafana-grpc",                        # Loki gRPC access for Grafana (9095)
  ]
  ingress_cidr_blocks = ["0.0.0.0/0"]           # Allow all inbound traffic from anywhere

  # Egress rules
  egress_rules = ["all-all"]                  # Allow all outbound traffic

  # Tags
  tags = local.common_tags
}