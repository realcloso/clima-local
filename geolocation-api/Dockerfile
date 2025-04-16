FROM python:3.11-slim

WORKDIR /app

# Copia o código-fonte para dentro do container
COPY . .

# Instala o Flask e o Requests
RUN pip install --no-cache-dir flask requests

# Expondo a porta 5002 para acessar o serviço
EXPOSE 5002

# Comando para iniciar o script
CMD ["python", "script.py"]
