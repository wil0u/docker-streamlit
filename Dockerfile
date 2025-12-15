FROM python:3.11-slim

# Évite les fichiers .pyc et force les logs immédiats
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Définit /app comme dossier de travail dans le conteneur
# (Docker le crée automatiquement s’il n’existe pas)
WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copie les requirements de l'app Streamlit dans le dossier de travail du conteneur
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copie TOUT le dossier app local dans le dossier app du conteneur
COPY app ./app

# Port exposé par l'application Streamlit
EXPOSE 8080

# La commande exécutée au démarrage du conteneur pour lancer l'app Streamlit
CMD ["streamlit", "run", "app/app_streamlit.py", "--server.port=8080", "--server.address=0.0.0.0"]


# Résultat dans le conteneur: 
# /app
# ├── requirements.txt
# ├── app/
# │   └── app_streamlit.py
