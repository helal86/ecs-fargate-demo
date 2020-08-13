#!/bin/bash

set -eo pipefail 

terraform init
terraform plan
terraform apply -auto-approve 

LB=$(terraform output alb_hostname) 

echo "Waiting for cluster to provision itself..."
sleep 30
curl $LB

exit
