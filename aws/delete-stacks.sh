#!/bin/bash
#
# Delete the CloudFormation stacks associated with the project. This is best effort and failing to delete a stack won't fail the script.
#
# This script assumes following are installed on the build host:
# - AWS CLI

aws cloudformation delete-stack \
--stack-name 'mongo-backups-s3'

aws cloudformation delete-stack \
--stack-name 'mongo-backups-cloud-watch'