# Clima-Geo APIs

Este projeto contém duas APIs independentes:

- **Clima API**: Fornece informações sobre o clima atual e previsões.
- **Geolocation API**: Permite filtrar os dados de clima por temperatura e descrição.

Ambas as APIs são executadas em containers Docker e se comunicam entre si por meio de uma rede Docker personalizada.

## Pré-requisitos

Antes de executar as APIs, certifique-se de que você tem o seguinte instalado na sua máquina:

- [Docker](https://www.docker.com/) (versão 20.10 ou superior)
- Permissões para executar scripts de shell

## Estrutura do Projeto

```bash
Clima-Geo-APIs/
├── clima-api/
│   ├── Dockerfile
│   ├── app.py              # Código da API Clima
│   ├── clima.json          # Dados de clima em formato JSON
│   └── run-weather.sh      # Script para rodar a Clima API
├── geolocation-api/
│   ├── Dockerfile
│   ├── script.py           # Código da API Geolocation
│   └── run-geolocation.sh  # Script para rodar a Geolocation API
├── comandos-build.txt      # Comandos úteis para build e gerenciamento Docker
└── README.md               # Este arquivo
```

## Configuração e Execução

### 1. Tornar scripts executáveis

```bash
chmod +x clima-api/run-weather.sh
chmod +x geolocation-api/run-geolocation.sh
```

### 2. Criar a rede Docker personalizada (opcional)

Os scripts criam a rede automaticamente, mas você também pode fazer isso manualmente:

```bash
docker network create my_custom_network
```

### 3. Construir as imagens Docker

```bash
docker build -t clima-api-image ./clima-api
docker build -t geolocation-api-image ./geolocation-api
```

### 4. Rodar a Clima API

```bash
./clima-api/run-weather.sh
```

- Inicia o container `weather-api` na porta `5001`
- Usa a rede `my_custom_network`

### 5. Rodar a Geolocation API

```bash
./geolocation-api/run-geolocation.sh
```

- Inicia o container `geolocation-api` na porta `5002`
- Também utiliza a rede `my_custom_network`

### 6. Acessar as APIs

- **Clima API**: `http://localhost:5001`
  - Exemplo: `http://localhost:5001/clima/previsao`
- **Geolocation API**: `http://localhost:5002`
  - Exemplo de filtro por temperatura:
    - `http://localhost:5002/filtrar/temperatura?min=20&max=30`
  - Exemplo de filtro por descrição:
    - `http://localhost:5002/filtrar/descricao?termo=chuva`

### 7. Parar e Remover os Containers

```bash
docker rm -f weather-api geolocation-api
```

Remover a rede personalizada (opcional):

```bash
docker network rm my_custom_network
```

## Dicas Úteis

- **Ver logs**:

  ```bash
  docker logs weather-api
  docker logs geolocation-api
  ```

- **Limpar recursos do Docker**:

  ```bash
  docker system prune -a
  ```

- **Verificar containers e imagens**:

  ```bash
  docker ps -a
  docker images
  ```
