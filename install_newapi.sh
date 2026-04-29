#!/bin/bash
set -e

echo "=== Instalando dependencias para New API ==="

# Instalar Go si no existe
if ! command -v go &> /dev/null; then
    echo "Instalando Go..."
    wget -q https://go.dev/dl/go1.23.6.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.23.6.linux-amd64.tar.gz
    rm go1.23.6.linux-amd64.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    export PATH=$PATH:/usr/local/go/bin
    echo "Go instalado: $(go version)"
else
    echo "Go ya instalado: $(go version)"
fi

# Instalar Bun si no existe
if ! command -v bun &> /dev/null; then
    echo "Instalando Bun..."
    curl -fsSL https://bun.sh/install | bash
    source ~/.bashrc
    echo "Bun instalado: $(bun --version)"
else
    echo "Bun ya instalado: $(bun --version)"
fi

cd ~/newapi

# Configurar Backend
echo "=== Configurando Backend ==="
go mod download

cp .env.example .env

# Configurar Frontend
echo "=== Configurando Frontend ==="
cd web
bun install

echo "=== Instalación completa ==="
echo ""
echo "Para iniciar:"
echo "  Terminal 1 (Backend): cd ~/newapi && go run main.go"
echo "  Terminal 2 (Frontend): cd ~/newapi/web && bun run dev"
echo ""
echo "Backend: http://localhost:3000"
echo "Frontend: http://localhost:5173"
