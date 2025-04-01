#!/bin/bash
# Automation script for CloudFormation templates. 
#
# Parameters
#   $1: Execution mode. Valid values: deploy, delete, preview.
#
# Usage examples:
#   ./run.sh build (for s3 bucket - must be done first)
#   ./run.sh create 
#   ./run.sh update
#   ./run.sh delete (s3 bucket must be emptied and deleted first)
#

# Validate parameters
if [[ $1 != "build" && != "create" && $1 != "delete" && $1 != "update" ]]; then
    echo "ERROR: Incorrect execution mode. Valid values: deploy, delete, update." >&2
    exit 1
fi

if [ $1 == "build" ]
then
    aws cloudformation create-stack \
        --stack-name s3 \
        --template-body file://s3.yml \
        --region=us-east-1
fi

# then the index.html file must be manually uploaded to the s3 bucket on the AWS GUI.

# Execute CloudFormation CLI
if [ $1 == "create" ]
then
    aws cloudformation create-stack \
        --stack-name udacity-project2-networks \
        --template-body file://networks.yml \
        --parameters file://networks-parameters.json \
        --capabilities "CAPABILITY_NAMED_IAM"  \
        --region=us-east-1

read -p "pause for 5 mins whilst networks stack is creating" -t 300
echo "thank you for waiting, we will now create the udagram app stack "

    aws cloudformation create-stack \
        --stack-name udacity-project2-udagram \
        --template-body file://udagram.yml \
        --parameters file://udagram-parameters.json \
        --capabilities "CAPABILITY_NAMED_IAM"  \
        --region=us-east-1
fi
if [ $1 == "delete" ]
then
    aws cloudformation delete-stack \
        --stack-name udacity-project2-udagram \
        --deletion-mode FORCE_DELETE_STACK

read -p "pause for 15 mins whilst udagram stack is deleting" -t 900
echo "thank you for waiting, we will now delete the networks stack "

    aws cloudformation delete-stack \
        --stack-name udacity-project2-networks-2 \
        --deletion-mode FORCE_DELETE_STACK
fi
if [ $1 == "update" ]
then
    aws cloudformation update-stack \
        --stack-name udacity-project2-networks \
        --template-body file://networks.yml \
        --parameters file://networks-parameters.json \
        --capabilities "CAPABILITY_NAMED_IAM"  \
        --region=us-east-1

read -p pause for 5 mins -t 300
echo "pause whilst networks stack is updating"

    aws cloudformation update-stack \
        --stack-name udacity-project2-udagram \
        --template-body file://udagram.yml \
        --parameters file://udagram-parameters.json \
        --capabilities "CAPABILITY_NAMED_IAM"  \
        --region=us-east-1
fi
