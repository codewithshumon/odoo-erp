#!/bin/bash
set -e

# Default values
: "${HOST:=db}"
: "${PORT:=5432}"
: "${USER:=odoo}"
: "${PASSWORD:=odoo}"

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL at ${HOST}:${PORT}..."
until pg_isready -h "$HOST" -p "$PORT" -U "$USER" > /dev/null 2>&1; do
  echo "PostgreSQL is unavailable - sleeping 1s"
  sleep 1
done
echo "PostgreSQL is up!"

# Ensure filestore directory exists
mkdir -p /var/lib/odoo/.local/share/Odoo

# Execute the main command
exec "$@"