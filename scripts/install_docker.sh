#!/usr/bin/env bash

echo "=== Verificando Docker ==="

if ! command -v docker &> /dev/null; then
    echo "Docker não encontrado."
    echo "Instale Docker antes de continuar:"
    echo "https://docs.docker.com/engine/install/"
    exit 1
fi

if ! docker info &> /dev/null; then
    echo "Docker não está em execução."
    echo "Inicie o Docker e execute novamente."
    exit 1
fi

echo "✅ Docker OK"
echo ""
