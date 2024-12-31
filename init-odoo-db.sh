#!/bin/bash
set -e

echo "Checking PostgreSQL connection..."

# Attendre que PostgreSQL soit prêt
while ! nc -z "$DB_HOST" "$DB_PORT"; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 5
done

echo "PostgreSQL is up - checking database"

export PGPASSWORD=$DB_PASSWORD

# Vérifier si la base de données existe
if ! psql -h "$DB_HOST" -U "$DB_USER" -lqt | cut -d \| -f 1 | grep -qw "$DB_NAME"; then
  echo "Database $DB_NAME does not exist. Creating..."
  createdb -h "$DB_HOST" -U "$DB_USER" "$DB_NAME"
  echo "Database $DB_NAME created successfully."
else
  echo "Database $DB_NAME already exists."
fi

echo "Database initialization complete."
