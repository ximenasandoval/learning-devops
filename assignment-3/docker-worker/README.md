# Create docker-aws-worker image

You will need a `.env` file with the following fields:
```
AWS_ACCOUNT_ID=
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=
ECR_REPO_NAME=
```

To build a new `docker-aws-worker`
```
chmod +x create-docker-worker.sh
./create-docker-worker.sh
```