#!/bin/bash

# Nome da rede Docker
NETWORK_NAME="my_custom_network"
CONTAINER_NAME="geolocation-api"
IMAGE_NAME="geolocation-api-image"
PORT_HOST=5002
PORT_CONTAINER=5002

echo "=========================="
echo " 🌍 Iniciando Geolocation API"
echo "=========================="

# Verifica se a rede já existe
if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
  echo "🔧 Criando a rede Docker '$NETWORK_NAME'..."
  docker network create "$NETWORK_NAME"
else
  echo "✅ Rede Docker '$NETWORK_NAME' já existe."
fi

# Verifica se o container já existe e remove se necessário
if docker ps -a --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"; then
  echo "🗑️ Removendo container antigo '${CONTAINER_NAME}'..."
  docker rm -f "$CONTAINER_NAME"
fi

# Inicia o container
echo "🐳 Iniciando container '${CONTAINER_NAME}' a partir da imagem '${IMAGE_NAME}'..."
docker run -d \
  --name "$CONTAINER_NAME" \
  --network "$NETWORK_NAME" \
  -p "$PORT_HOST:$PORT_CONTAINER" \
  "$IMAGE_NAME"

# Verificação de sucesso
if [ $? -eq 0 ]; then
  echo "✅ Container '${CONTAINER_NAME}' iniciado com sucesso!"
  echo "🌐 Acesse em: http://localhost:$PORT_HOST"
else
  echo "❌ Falha ao iniciar o container '${CONTAINER_NAME}'"
fi
