FROM python:3.8-slim

# Ustawienie zmiennych środowiskowych
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Instalacja zależności systemowych
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalacja zależności Pythona
COPY ./app/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Kopiowanie kodu aplikacji
COPY ./app /app

# Ustawienie katalogu roboczego
WORKDIR /app

# Expose port
EXPOSE 5000

# Uruchomienie aplikacji
CMD ["python", "app.py"]