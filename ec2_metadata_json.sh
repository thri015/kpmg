#!/bin/bash
curl --write-out "\n" --request GET "http://169.254.169.254/latest/dynamic/instance-identity/document" --header "X-aws-ec2-metadata-token: $TOKEN"

echo "secound method likely bellow"
# aws ec2 describe-instances --instance-ids i-1234567890abcdef0
