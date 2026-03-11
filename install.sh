#!/usr/bin/env bash
set -e

echo ""
echo "======================================"
echo "Clusterion DevOps Platform Installer"
echo "======================================"
echo ""

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BASE_DIR/scripts/detect_os.sh"
source "$BASE_DIR/scripts/install_docker.sh"
source "$BASE_DIR/scripts/install_kind.sh"
source "$BASE_DIR/scripts/install_kubectl.sh"
source "$BASE_DIR/scripts/create_cluster.sh"
source "$BASE_DIR/scripts/install_argocd.sh"
source "$BASE_DIR/scripts/install_argocd_cli.sh"
source "$BASE_DIR/scripts/bootstrap_gitops.sh"

echo ""
echo "Clusterion instalado com sucesso!"
echo ""
