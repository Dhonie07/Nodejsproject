#!/bin/bash
echo "Logging into ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 516027198936.dkr.ecr.us-east-1.amazonaws.com
echo "Pulling latest images..."
docker pull 516027198936.dkr.ecr.us-east-1.amazonaws.com/safemeet-api:latest
docker pull 516027198936.dkr.ecr.us-east-1.amazonaws.com/safemeet-web:latest
echo "Done."
