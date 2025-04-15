# Clima-Geo APIs

Este projeto contém duas APIs independentes:

- **Clima API**: Fornece informações sobre o clima atual e previsões.
- **Geolocation API**: Fornece informações de geolocalização (por exemplo, cidade com base no IP).

Ambas as APIs podem ser executadas em containers Docker, facilitando a comunicação entre elas em uma rede privada.

## Pré-requisitos

Antes de executar as APIs, certifique-se de que você tem o seguinte instalado na sua máquina:

- [Docker](https://www.docker.com/) (versão 20.10 ou superior).
- Permissões para executar scripts de shell (caso contrário, você pode precisar de privilégios de administrador).

## Estrutura do Projeto

```bash
Clima-Geo-APIs/
├── clima-api/
│   ├── Dockerfile
│   ├── app.py              # Código da API Clima
│   └── clima.json          # Dados de clima em formato JSON
├── geolocation-api/
│   ├── Dockerfile
│   ├── app.py              # Código da API Geolocalização
│   └── geolocation.json    # Dados de geolocalização (se necessário)
├── run-weather.sh          # Script para rodar a Clima API
├── run-geolocation.sh      # Script para rodar a Geolocation API
└── README.md               # Este arquivo
```

## Configuração e Execução

### 1. Configurar permissões para scripts

Primeiro, torne os scripts executáveis com o comando abaixo:

```bash
chmod +x run-weather.sh
chmod +x run-geolocation.sh
```

### 2. Criar a rede Docker (caso não exista)

O projeto depende de uma rede Docker personalizada para garantir que as APIs se comuniquem. O script `run-weather.sh` e `run-geolocation.sh` criam a rede automaticamente, mas caso queira fazer isso manualmente, execute o seguinte comando:

```bash
docker network create my_custom_network
```

### 3. Rodar a Clima API

Execute o script `run-weather.sh` para rodar a **Clima API**:

```bash
./run-weather.sh
```

Isso irá:

- Criar a rede Docker personalizada (`my_custom_network`) se necessário.
- Remover qualquer container `weather-api` existente (se houver).
- Iniciar o container da Clima API na rede personalizada, expondo a porta `5001`.

### 4. Rodar a Geolocation API

Execute o script `run-geolocation.sh` para rodar a **Geolocation API**:

```bash
./run-geolocation.sh
```

Isso irá:

- Garantir que a rede Docker esteja configurada corretamente.
- Remover qualquer container `geolocation-api` existente (se houver).
- Iniciar o container da Geolocation API na rede personalizada, expondo a porta `5002`.

### 5. Acessar as APIs

Agora, suas APIs estarão acessíveis nos seguintes endereços:

- **Clima API**: `http://localhost:5001`
- **Geolocation API**: `http://localhost:5002`

Ambas as APIs podem se comunicar entre si utilizando seus nomes de container (`weather-api` e `geolocation-api`) como hostnames na mesma rede Docker.

### 6. Parar e Limpar os Containers

Após terminar os testes, você pode parar e remover os containers com os seguintes comandos:

```bash
docker rm -f weather-api geolocation-api
```

Se desejar remover também a rede personalizada, execute:

```bash
docker network rm my_custom_network
```

## Observações

- **Logs**: Para visualizar os logs de um container, use o comando:

  ```bash
  docker logs <nome-do-container>
  ```

  Exemplo:

  ```bash
  docker logs weather-api
  ```

- **Dependências**: As dependências do Python são instaladas automaticamente durante a construção das imagens Docker a partir dos `Dockerfile`.

---

Com este guia, você deve conseguir rodar o projeto sem problemas. Caso tenha mais alguma dúvida ou queira realizar alguma modificação, fique à vontade para perguntar!