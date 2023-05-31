#!/bin/bash

# If we don't have env variables, we need to set them
if  [[ -z ${AWS_ACCOUNT_ID+x} ||  -z ${AWS_SECRET_ACCESS_KEY+x} || -z ${AWS_ACCESS_KEY_ID+x} ]]; then 
    echo "No env variables, loading from file"
    export $(cat .env | xargs)
    # Unset default AWs profile (will delete later)
    unset AWS_PROFILE
fi

# We need to build the image for the server
UNIQ_ID=$(git rev-parse --short HEAD)
REPO_URI=$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$ECR_REPO_NAME
tag=$REPO_URI:$UNIQ_ID

echo $tag

docker build -t $tag .

# Push image to ECR repository
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS \
    --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

docker tag $tag $REPO_URI:latest

docker push $REPO_URI:latest
docker push $tag

echo Clean up images

docker rmi -f $tag $REPO_URI:latest