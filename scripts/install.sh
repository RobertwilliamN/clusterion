#!/usr/bin/env bash
set -e

# ==============================
#  Clusterion Installer
# ==============================

cat << "EOF"

   ██████╗██╗     ██╗   ██╗███████╗████████╗███████╗██████╗ ██╗ ██████╗ ███╗   ██╗
  ██╔════╝██║     ██║   ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗██║██╔═══██╗████╗  ██║
  ██║     ██║     ██║   ██║███████╗   ██║   █████╗  ██████╔╝██║██║   ██║██╔██╗ ██║
  ██║     ██║     ██║   ██║╚════██║   ██║   ██╔══╝  ██╔══██╗██║██║   ██║██║╚██╗██║
  ╚██████╗███████╗╚██████╔╝███████║   ██║   ███████╗██║  ██║██║╚██████╔╝██║ ╚████║
   ╚═════╝╚══════╝ ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝

              DevOps Cluster Provisioning Platform
EOF

CLUSTERION_VERSION="v0.1.0"
CLUSTERION_CODENAME="Genesis"

echo ""
echo "🚀 Clusterion Installer - $CLUSTERION_VERSION"
echo "Codename: $CLUSTERION_CODENAME"
echo ""

# ==============================
# Verificação Root
# ==============================

if [ "$(id -u)" -eq 0 ]; then
    echo "❌ Não execute este script como root."
    echo "Execute como usuário normal. Ele pedirá sudo quando necessário."
    exit 1
fi

# ==============================
# Detectar SO
# ==============================

case "$(uname -s)" in
    Linux*) OS="linux" ;;
    Darwin*) OS="darwin" ;;
    *) OS="unknown" ;;
esac

ARCH_RAW=$(uname -m)
case "$ARCH_RAW" in
    x86_64) ARCH="amd64" ;;
    arm64|aarch64) ARCH="arm64" ;;
    *) ARCH="unknown" ;;
esac

echo "🖥 Sistema detectado: $OS"
echo "🧠 Arquitetura: $ARCH"
echo ""

if [ "$OS" == "unknown" ] || [ "$ARCH" == "unknown" ]; then
    echo "❌ Sistema ou arquitetura não suportados."
    exit 1
fi

# ==============================
# Verificar Docker
# ==============================

echo "=== Verificando Docker ==="

if ! command -v docker &> /dev/null; then
    echo "❌ Docker não encontrado."
    echo "Instale Docker antes de continuar:"
    echo "https://docs.docker.com/engine/install/"
    exit 1
fi

if ! docker info &> /dev/null; then
    echo "❌ Docker não está em execução."
    echo "Inicie o Docker e execute novamente."
    exit 1
fi

echo "✅ Docker OK"
echo ""

# ==============================
# Verificar Kind
# ==============================

echo "=== Verificando Kind ==="

if ! command -v kind &> /dev/null; then
    echo "⚙ Instalando Kind..."

    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-$OS-$ARCH
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
fi

echo "✅ Kind OK"
echo ""

# ==============================
# Verificar Kubectl
# ==============================

echo "=== Verificando Kubectl ==="

if ! command -v kubectl &> /dev/null; then
    echo "⚙ Instalando kubectl..."

    curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/$OS/$ARCH/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
fi

echo "✅ Kubectl OK"
echo ""

# ==============================
# Criar Cluster
# ==============================

read -p "Deseja criar um cluster Kind agora? (Y/n): " CREATE_CLUSTER
CREATE_CLUSTER=${CREATE_CLUSTER:-Y}

if [[ "$CREATE_CLUSTER" =~ ^[Yy]$ ]]; then
    echo "🚀 Criando cluster clusterion..."

    kind create cluster --name clusterion

    echo "✅ Cluster criado com sucesso!"
fi

# ==============================
# Mensagem Final
# ==============================

echo ""
echo "=============================================="
echo "🎉 Clusterion está pronto!"
echo "=============================================="
echo ""

echo "Próximos passos:"
echo ""
echo "1️⃣  kubectl get nodes"
echo "2️⃣  Provisionar stack base (ArgoCD, Prometheus, Grafana)"
echo "3️⃣  Iniciar a plataforma web do Clusterion"
echo ""

echo "Clusterion governa seu cluster."
echo ""
