#!/usr/bin/env bash

echo "Instalando ArgoCD..."

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

echo "Baixando manifest..."

curl -sSL -o /tmp/argocd-install.yaml \
https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Aplicando manifest no namespace argocd..."

kubectl apply --server-side -n argocd -f /tmp/argocd-install.yaml

echo "Aguardando ArgoCD iniciar..."

kubectl wait \
--for=condition=available \
deployment/argocd-server \
-n argocd \
--timeout=300s

echo "ArgoCD instalado com sucesso!"