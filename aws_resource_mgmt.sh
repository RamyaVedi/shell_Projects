#!/bin/bash
#version:v1
#
#This script will list EC2 instances, S3 buckets, Lambda functions, IAM users




#set -x

#Checking AWS CLI is installed or not

if ! command -v aws &> /dev/null
then
	echo"AWS CLI is not installed please install it to proceed"
	exit 1
fi
 
#List S3 Buckets

x=$(aws s3 ls| wc -l) # Counting no of s3 buckets

if [ "$x" -eq 0 ]; # Checking x value and print the no of s3 buckets 
then
	echo "There is no s3 buckets" >> output_file.txt
else 
	echo "there are $X s3 buckets"
fi

#List EC2 Instances

no_of_ec2=$(aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'| wc -l)  # Counting no of EC2Instances

if [ "$no_of_ec2" -eq 0 ];
then
	echo "There are no ec2 instances"
else
	echo "There are $no_of_ec2  ec2 instances" >>  output_file.txt
fi

#list lambda

no_of_lambda=$(aws lambda list-functions --query 'Functions[].FunctionName[]' \
--output text| wc -l) # Counting no of lambda functions

if [ "$no_of_lambda" -eq 0 ];
then
	echo "There are no Lambda functions" >>  output_file.txt
else
	echo "There are $no_of_lambda Lambda functions"
fi

#list IAM users

no_of_IAM_Users=$(aws iam list-users --query 'Users[].UserName[]' \
--output text |wc -l) # Counting no of IAM Users

if [ "$no_of_IAM_Users" -eq 0 ];
then
	echo "There is no IAM Users" >>  output_file.txt
else
	echo "There are $no_of_IAM_Users IAM Users"
fi

