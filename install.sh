#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/RobertwilliamN/clusterion.git"
INSTALL_DIR="$HOME/.clusterion"

echo "Baixando Clusterion..."

if [ -d "$INSTALL_DIR" ]; then
  echo " Diretório já existe, atualizando..."
  git -C "$INSTALL_DIR" pull
else
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"

echo "Executando instalação..."

chmod +x install_local.sh
bash install_local.sh
