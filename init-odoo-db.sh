#!/bin/bash

# Exporter les variables d'environnement nécessaires pour PostgreSQL
export PGPASSWORD=${DB_PASSWORD}
export PGUSER=${DB_USER}
export PGHOST=${DB_HOST}
export PGPORT=${DB_PORT}
export PGDATABASE=${DB_NAME}

echo "Checking PostgreSQL connection..."
until pg_isready -h $PGHOST -p $PGPORT -U $PGUSER; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 2
done

echo "PostgreSQL is up - checking database"

# Vérifiez si la base de données existe, sinon créez-la
psql -c "SELECT 1 FROM pg_database WHERE datname = '${PGDATABASE}';" | grep -q 1 || \
  psql -c "CREATE DATABASE ${PGDATABASE} OWNER ${PGUSER};"

# Ajouter des données ou initialiser la base si nécessaire
if [ -f /usr/local/bin/init.sql ]; then
  echo "Initializing database with init.sql..."
  psql -d $PGDATABASE -f /usr/local/bin/init.sql
fi

echo "Database initialization complete."
