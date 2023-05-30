#!/bin/bash

date=$(date '+%Y-%m-%d-%H-%M-%S')
tag=docker-worker-$date
docker build -t $tag .

# Load env variables
export $(cat .env | xargs)

# Unset default AWs profile (will delete later)
unset AWS_PROFILE

aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS \
    --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

docker tag $tag $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$ECR_REPO_NAME:latest

docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$ECR_REPO_NAME:latest
