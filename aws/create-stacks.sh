#!/bin/bash
#
# Create the CloudFormation stacks associated with the project. This script first creates the cloud-formation-packages bucket for the project.
#
# This script assumes following are installed on the build host:
# - AWS CLI

ALARM_EMAIL=$1

echo $ALARM_EMAIL

CLOUD_FORMATION_BUCKET_NAME="mongo-backup-tool-cloud-formation-packages"

if aws s3api head-bucket --bucket $CLOUD_FORMATION_BUCKET_NAME 2>&1 | grep -q 'Not Found'
then
    echo 'Creating Cloud Formation Packages Bucket'

    aws s3 mb s3://$CLOUD_FORMATION_BUCKET_NAME

    aws s3api wait bucket-exists --bucket $CLOUD_FORMATION_BUCKET_NAME
fi

S3_TEMPLATE=./s3/bucket.yml
S3_TEMPLATE_OUTPUT=./s3/bucket-output.yml
\
aws cloudformation package \
--template-file $S3_TEMPLATE \
--output-template-file $S3_TEMPLATE_OUTPUT \
--s3-bucket CLOUD_FORMATION_BUCKET_NAME \
&&
aws cloudformation deploy \
--template-file $S3_TEMPLATE_OUTPUT \
--stack-name 'mongo-backups-s3'
\
CLOUD_WATCH_TEMPLATE=./cloudwatch/billing-alarm.yml
CLOUD_WATCH_TEMPLATE_OUTPUT=./cloudwatch/billing-alarm-output.yml
\
aws cloudformation package \
--template-file $CLOUD_WATCH_TEMPLATE \
--output-template-file $CLOUD_WATCH_TEMPLATE_OUTPUT \
--s3-bucket CLOUD_FORMATION_BUCKET_NAME \
&&
aws cloudformation deploy \
--template-file $CLOUD_WATCH_TEMPLATE_OUTPUT \
--stack-name 'mongo-backups-cloud-watch' \
--parameter-overrides \
RecipientEmailAddress=$ALARM_EMAIL