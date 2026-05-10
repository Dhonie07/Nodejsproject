#!/bin/bash
echo "Starting API container..."
docker run -d \
  --name safemeet-api \
  --restart always \
  -p 4000:4000 \
  --env-file /home/ubuntu/Nodejsproject/.env \
  516027198936.dkr.ecr.us-east-1.amazonaws.com/safemeet-api:latest

echo "Starting Web container..."
docker run -d \
  --name safemeet-web \
  --restart always \
  -p 3000:3000 \
  -e NODE_ENV=production \
  -e NEXT_PUBLIC_API_URL=http://35.171.102.214:4000 \
  516027198936.dkr.ecr.us-east-1.amazonaws.com/safemeet-web:latest

echo "All containers started!"
docker ps
