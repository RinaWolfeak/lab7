#!/bin/bash

set -e

CONTAINER_NAME="nginx-cont"

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout certs/server.key \
  -out certs/server.crt \
  -subj "/CN=localhost"

docker exec "$CONTAINER_NAME" nginx -s reload

echo "✅ Сертификат обновлён"
