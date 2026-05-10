#!/bin/bash
echo "Stopping existing containers..."
docker stop safemeet-api safemeet-web 2>/dev/null || true
docker rm safemeet-api safemeet-web 2>/dev/null || true
echo "Containers stopped."
