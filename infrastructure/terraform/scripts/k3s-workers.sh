#!/bin/bash
set -xe

REGION="${AWS_DEFAULT_REGION:-sa-east-1}"
SSM_PARAM="/k3s/token"

# instalar dependencias mínimas
yum update -y || true
yum install -y curl jq python3

# Esperar que SSM pueda responder (pequeño retry)
for i in $(seq 1 6); do
  TOKEN=$(aws ssm get-parameter --name "${SSM_PARAM}" --with-decryption --region "${REGION}" --query "Parameter.Value" --output text 2>/dev/null) && break
  sleep 5
done

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
  echo "K3s token not found in SSM (${SSM_PARAM}). Exiting bootstrap (will retry on next launch)." >> /var/log/bootstrap-workers.log
  exit 0
fi

# MASTER_IP: usamos metadata del maestro pasada por tag o variable; para simplificar: obtener del SSM si lo guardaste, o setear manualmente.
# Recomiendo guardar la IP del master en SSM además del token, por ejemplo /k3s/master_ip
MASTER_IP=$(aws ssm get-parameter --name "/k3s/master_ip" --region "${REGION}" --query "Parameter.Value" --output text 2>/dev/null || true)

if [ -z "$MASTER_IP" ] || [ "$MASTER_IP" = "null" ]; then
  # Si no hay MASTER_IP en SSM, podés intentar resolver por DNS o salir.
  echo "MASTER_IP not found in SSM (/k3s/master_ip). Exiting join." >> /var/log/bootstrap-workers.log
  exit 0
fi

# Ejecutar join de K3s (worker)
curl -sfL https://get.k3s.io | \
  K3S_URL="https://${MASTER_IP}:6443" \
  K3S_TOKEN="${TOKEN}" \
  sh -

echo "k3s agent started and attempted join to ${MASTER_IP}" >> /var/log/bootstrap-workers.log
