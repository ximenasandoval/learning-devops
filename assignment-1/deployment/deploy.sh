# We need to build the image for the server
date=$(date '+%Y-%m-%d %H:%M:%S')
tag=deploy-$date
docker build -f ../app/Dockerfile -t tag ../app/

# TODO push to ECR, not needed for now