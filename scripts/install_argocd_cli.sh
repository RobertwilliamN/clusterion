#!/usr/bin/env bash

echo "Verificando ArgoCD CLI..."

if command -v argocd &> /dev/null; then
    echo "ArgoCD CLI já instalado."
    return
fi

echo "Instalando ArgoCD CLI..."

VERSION=$(curl -s https://api.github.com/repos/argoproj/argo-cd/releases/latest \
| grep tag_name \
| cut -d '"' -f 4)

curl -sSL -o argocd \
https://github.com/argoproj/argo-cd/releases/download/${VERSION}/argocd-${OS}-${ARCH}

chmod +x argocd

sudo mv argocd /usr/local/bin/

echo "ArgoCD CLI instalado."