#!/usr/bin/env bash
set -e

clear

echo ""
echo "====================================="
echo "Instalando Ingress Controller"
echo "====================================="
echo ""

kubectl apply -f \
https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "Aguardando Ingress Controller..."

kubectl wait --namespace ingress-nginx \
--for=condition=ready pod \
--selector=app.kubernetes.io/component=controller \
--timeout=300s

echo "Ingress pronto."

echo ""
echo "Configurando ArgoCD para rodar atrás do Ingress..."
echo ""

kubectl patch configmap argocd-cmd-params-cm \
-n argocd \
--type merge \
-p '{"data":{"server.insecure":"true"}}' 

kubectl rollout restart deployment argocd-server -n argocd

echo ""
echo "====================================="
echo "Criando Ingress do ArgoCD"
echo "====================================="
echo ""

cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: argocd
  namespace: argocd
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
spec:
  ingressClassName: nginx
  rules:
  - host: argocd.clusterion.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: argocd-server
            port:
              number: 80
EOF

echo "Ingress criado."

echo ""
echo "Adicionando host local..."

if ! grep -q "argocd.clusterion.local" /etc/hosts; then
  echo "127.0.0.1 argocd.clusterion.local" | sudo tee -a /etc/hosts
fi
if ! grep -q "grafana.clusterion.local" /etc/hosts; then
  echo "127.0.0.1 grafana.clusterion.local" | sudo tee -a /etc/hosts
fi

if ! grep -q "prometheus.clusterion.local" /etc/hosts; then
  echo "127.0.0.1 prometheus.clusterion.local" | sudo tee -a /etc/hosts
fi


echo ""
echo "====================================="
echo "Aguardando ArgoCD ficar pronto"
echo "====================================="
echo ""

kubectl wait --for=condition=available deployment \
--all -n argocd --timeout=300s

kubectl wait --for=condition=ready pod \
--all -n argocd --timeout=300s

kubectl rollout status deployment argocd-server -n argocd

echo "ArgoCD pronto."

echo ""
echo "Obtendo senha inicial..."
echo ""

ARGOCD_PASS=$(kubectl -n argocd \
get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d)

echo "Senha obtida."

echo "Aguardando ArgoCD responder..."

until curl -s http://argocd.clusterion.local >/dev/null; do
  echo "ArgoCD ainda não respondeu..."
  sleep 5
done

echo ""
echo "Realizando login no ArgoCD..."
echo ""

for i in {1..5}; do

    if argocd login argocd.clusterion.local \
        --username admin \
        --password "$ARGOCD_PASS" \
        --insecure \
        --grpc-web
    then
        echo "Login realizado com sucesso!"
        break
    fi

    echo "Tentativa $i falhou, tentando novamente..."
    sleep 5

done

echo ""
echo "====================================="
echo "Bootstrap GitOps"
echo "====================================="
echo ""

kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/example/prometheus-operator-crd/monitoring.coreos.com_probes.yaml
kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml

echo "Aplicando projeto..."

kubectl apply -f \
https://raw.githubusercontent.com/RobertwilliamN/clusterion-platform/main/bootstrap/clusterion-project.yaml

echo "Projeto aplicado."

echo ""
echo "Aplicando root application..."
echo ""

kubectl apply -f \
https://raw.githubusercontent.com/RobertwilliamN/clusterion-platform/main/bootstrap/clusterion-root-app.yaml

echo "Root app aplicada."

echo ""
echo "Verificando aplicação..."

argocd app list

echo ""
echo "Sincronizando aplicação..."

argocd app sync clusterion-root

echo ""
echo "====================================="
echo "Clusterion GitOps inicializado"
echo "====================================="
echo ""

echo "Acesse:"
echo "http://argocd.clusterion.local"
echo ""

echo "Usuario: admin"
echo "Senha: $ARGOCD_PASS"
echo ""