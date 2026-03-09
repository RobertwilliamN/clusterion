#!/usr/bin/env bash

echo "Detectando sistema operacional..."

case "$(uname -s)" in
    Linux*) OS="linux" ;;
    Darwin*) OS="darwin" ;;
    *) OS="unknown" ;;
esac

ARCH_RAW=$(uname -m)

case "$ARCH_RAW" in
    x86_64) ARCH="amd64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    *) ARCH="unknown" ;;
esac

if [ "$OS" == "unknown" ] || [ "$ARCH" == "unknown" ]; then
    echo "Sistema ou arquitetura não suportados."
    exit 1
fi

export OS
export ARCH

echo "Sistema: $OS"
echo "Arquitetura: $ARCH"