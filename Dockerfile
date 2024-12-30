# Utiliser une image Python comme base
FROM python:3.6-alpine

# Installer les dépendances de base et les outils nécessaires
USER root

RUN apk add --no-cache \
    postgresql-client \
    vim \
    net-tools \
    iputils

# Créer un répertoire de travail
WORKDIR /opt

# Copier le code de l'application Flask
COPY . .

# Installer Flask et ses dépendances
RUN pip install flask

# Exposer le port utilisé par l'application Flask
EXPOSE 8080

# Commande par défaut pour exécuter l'application Flask
CMD ["python", "app.py"]
