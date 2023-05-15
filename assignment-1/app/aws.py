import boto3
import os
from dotenv import load_dotenv


def load_env():
    load_dotenv()


def get_objects(obj_type):
    load_env()
    access_key = os.getenv("AWS_ACCESS_KEY_ID")
    secret_key = os.getenv("AWS_SECRET_ACCESS_KEY")

    client = boto3.client('s3',
                          aws_access_key_id=access_key,
                          aws_secret_access_key=secret_key)

    bucket_name = os.getenv("BUCKET_NAME")

    response = client.list_objects_v2(
        Bucket=bucket_name,
    )
    objects_list = [obj['Key']
                    for obj in response['Contents'] if obj_type in obj['Key']]
    return objects_list
