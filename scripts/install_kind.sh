#!/usr/bin/env bash

echo "Verificando Kind..."

if command -v kind &> /dev/null; then
    echo "Kind já instalado."
    return
fi

echo "Instalando Kind..."

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-${OS}-${ARCH}

chmod +x kind
sudo mv kind /usr/local/bin/

echo "Kind instalado."