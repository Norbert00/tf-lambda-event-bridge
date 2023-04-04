import csv
import boto3
import json
import os
from collections import OrderedDict


def lambda_handler(event, context):
    s3_client = boto3.client("s3")
    ec2_client = boto3.client("ec2")


    S3_BUCKET_NAME = os.environ["env_bucket_name"]
    FILE_NAME = os.environ["env_file_name"]

    s3_file = s3_client.get_object(Bucket=S3_BUCKET_NAME, Key=FILE_NAME)
    file_content = s3_file["Body"].read().decode("utf-8").splitlines()

    tag_list = list()
    records = csv.DictReader(file_content)
    for row in records:
        tag_list.append(row)
        tag_list = json.loads(json.dumps(tag_list))
    print(tag_list)

    instance_id = event["detail"]["instance-id"]
    response = ec2_client.create_tags(
        Resources=[
            instance_id,
        ],
        Tags=tag_list,
    )
