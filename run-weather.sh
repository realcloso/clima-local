#!/bin/bash

# Nome da rede
NETWORK_NAME="my_custom_network"

# Verifica se a rede já existe
if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
  echo "Criando a rede Docker '$NETWORK_NAME'..."
  docker network create "$NETWORK_NAME"
else
  echo "Rede Docker '$NETWORK_NAME' já existe."
fi

# Verifica se o container já existe
if docker ps -a --format '{{.Names}}' | grep -Eq "^weather-api\$"; then
  echo "Removendo container antigo 'weather-api'..."
  docker rm -f weather-api
fi

# Inicia o container
echo "Iniciando container 'weather-api'..."
docker run -d \
  --name weather-api \
  --network "$NETWORK_NAME" \
  -p 5001:8000 \
  weather-api-image
