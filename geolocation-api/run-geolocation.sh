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
if docker ps -a --format '{{.Names}}' | grep -Eq "^geolocation-api\$"; then
  echo "Removendo container antigo 'geolocation-api'..."
  docker rm -f geolocation-api
fi

# Inicia o container
echo "Iniciando container 'geolocation-api'..."
docker run -d \
  --name geolocation-api \
  --network "$NETWORK_NAME" \
  -p 5002:8000 \
  geolocation-api-image
