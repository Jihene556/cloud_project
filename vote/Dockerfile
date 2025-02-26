FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copie du code source
COPY . .

#EXPOSE 9000

# Spécification du point d'entrée
CMD ["python", "app.py"]
