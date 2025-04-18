FROM python:3.11-slim

WORKDIR /clima-api

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir flask

COPY script.py .
COPY clima.json .

EXPOSE 5001

CMD ["python", "script.py"]