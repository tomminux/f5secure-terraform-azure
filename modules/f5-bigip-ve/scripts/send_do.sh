#!/bin/bash

F5_CREDS="f5admin:Default1234!"
FILE_NAME="f5bigip01_do.json"
BIGIP_IP="10.75.1.31"

curl -sku $F5_CREDS -X POST -d @$FILE_NAME -H "Content-Type: application/json" https://$BIGIP_IP/mgmt/shared/declarative-onboarding