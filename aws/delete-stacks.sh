#!/bin/bash
#
# Delete a CloudFormation stack. This is best effort and failing to delete a stack won't fail the script.
#
# This script assumes following are installed on the build host:
# - AWS CLI

usage() {
    echo "Usage:"
    echo "    delete-stacks.sh -n <stack-name>      Delete CloudFormation stack by name."
    echo "Example:"
    echo "    delete-stacks.sh -n my-stack"
}


S3_BUCKET_STACK_NAME = S3-Bucket-Stack

aws cloudformation delete-stack \
--stack-name $S3_BUCKET_STACK_NAME \
# --profile $AWS_PROFILE \
# --region $AWS_REGION \