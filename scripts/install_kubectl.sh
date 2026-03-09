#!/usr/bin/env bash

echo "Verificando kubectl..."

if command -v kubectl &> /dev/null; then
    echo "kubectl já instalado."
    return
fi

echo "Instalando kubectl..."

VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

curl -LO https://dl.k8s.io/release/${VERSION}/bin/${OS}/${ARCH}/kubectl

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

echo "kubectl instalado."