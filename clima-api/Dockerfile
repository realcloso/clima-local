FROM python:3.11-slim

# Definindo o diretório de trabalho
WORKDIR /clima-api

# Atualizando o pip
RUN pip install --no-cache-dir --upgrade pip

# Instalando dependências necessárias
RUN pip install --no-cache-dir flask

# Copiando apenas arquivos necessários (como clima.json e script.py)
COPY script.py .
COPY clima.json .

# Expondo a porta correta
EXPOSE 5001

# Comando para rodar o script
CMD ["python", "script.py"]