#!/bin/bash -x

docker stop nginx-cont
docker rm nginx-cont

mkdir -p certs
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout certs/server.key \
  -out certs/server.crt \
  -subj "/CN=localhost"

docker build -t devops/nginx-server ./nginx

docker run -d --name nginx-cont -p 54321:80 --restart unless-stopped -v "$(pwd)/certs:/etc/nginx/ssl:ro" devops/nginx-server

docker ps -a
sleep 5
curl 127.0.0.1:54321
docker logs -n 10 nginx-cont