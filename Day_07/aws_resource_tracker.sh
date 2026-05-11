#!/bin/bash

export AWS_PAGER=""

# Author: Rajesh
# Date: 11th May,2026
# Purpose: Reporting AWS Resources usage
# Version: v1.0

set -e

echo "==============================="
echo " AWS Resource Tracker Script"
echo "==============================="

# -----------------------------------
# List S3 Buckets
# -----------------------------------
echo
echo "[1] List of S3 Buckets"
echo "----------------------"

aws s3 ls || echo "No permission for S3 or no buckets found"

# -----------------------------------
# List EC2 Instances
# -----------------------------------
echo
echo "[2] List of EC2 Instances"
echo "-------------------------"

aws ec2 describe-instances \
--query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress]" \
--output table || echo "No permission for EC2"

# -----------------------------------
# List Lambda Functions
# -----------------------------------
echo
echo "[3] List of Lambda Functions"
echo "----------------------------"

aws lambda list-functions \
--query "Functions[*].[FunctionName,Runtime]" \
--output table || echo "No permission for Lambda"

# -----------------------------------
# List IAM Users
# -----------------------------------
echo
echo "[4] List of IAM Users"
echo "---------------------"

aws iam list-users \
--query "Users[*].[UserName,CreateDate]" \
--output table || echo "No permission for IAM"

# -----------------------------------
# Script Completed
# -----------------------------------
echo
echo "==============================="
echo " Script Execution Completed"
echo "==============================="
