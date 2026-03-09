#!/usr/bin/env bash

CLUSTER_NAME="clusterion"

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
KIND_CONFIG="$BASE_DIR/config/kind-config.yaml"

echo "Verificando cluster Kind..."

echo "Removendo cluster antigo (se existir)..."
kind delete cluster --name $CLUSTER_NAME 2>/dev/null || true

if kind get clusters | grep -q "$CLUSTER_NAME"; then
    echo "Cluster $CLUSTER_NAME já existe."
else
    echo "Criando cluster Kind usando configuração..."

    kind create cluster \
      --name $CLUSTER_NAME \
      --config "$KIND_CONFIG"

    echo "Cluster criado."
fi

echo "Aguardando API do Kubernetes..."

until kubectl cluster-info >/dev/null 2>&1; do
    echo "Esperando API server..."
    sleep 3
done

echo "Kubernetes pronto."