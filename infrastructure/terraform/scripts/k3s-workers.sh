#!/bin/bash
set -xe

REGION="${AWS_DEFAULT_REGION:-us-east-1}"
SSM_TOKEN="/k3s/token"
SSM_MASTER_IP="/k3s/master_ip"
K3S_VERSION="v1.33.3+k3s1"

# instalar dependencias mínimas
yum update -y || true
yum install -y curl jq python3

# Esperar que SSM pueda responder (pequeño retry)
for i in $(seq 1 6); do
  TOKEN=$(aws ssm get-parameter --name "${SSM_TOKEN}" --with-decryption --region "${REGION}" --query "Parameter.Value" --output text 2>/dev/null) && break
  sleep 5
done

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
  echo "K3s token not found in SSM (${SSM_TOKEN}). Exiting bootstrap (will retry on next launch)." >> /var/log/bootstrap-workers.log
  exit 0
fi

# Obtener la IP del master desde SSM (pequeño retry)
for i in $(seq 1 6); do
  MASTER_IP=$(aws ssm get-parameter --name "${SSM_MASTER_IP}" --with-decryption --region "${REGION}" --query "Parameter.Value" --output text 2>/dev/null) && break
  sleep 5
done

if [ -z "$MASTER_IP" ] || [ "$MASTER_IP" = "null" ]; then
  echo "IP for instace master not found in SSM (${SSM_MASTER_IP}). Exiting bootstrap (will retry on next launch)." >> /var/log/bootstrap-workers.log
  exit 0
fi

# Ejecutar join de K3s (worker)
curl -sfL https://get.k3s.io | \
INSTALL_K3S_VERSION="$K3S_VERSION" \
INSTALL_K3S_SKIP_SELINUX_RPM=true \
K3S_URL="https://$MASTER_IP:6443" \
K3S_TOKEN="$TOKEN" \
sh -

echo "k3s agent started and attempted join to ${MASTER_IP}" >> /var/log/bootstrap-workers.log
