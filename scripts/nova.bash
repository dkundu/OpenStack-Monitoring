#!/bin/bash

set -e

ADMIN_TENANT_ID="b3c18bc8a54f4f1c93afe949f790d5c6"
API_URL="http://csapi:8082/csapi"

AUTH_TOKEN=`curl -s -d '{"passwordCredentials":{"username":"admin", "password":"secrete"},"tenantName":"admin"}' $API_URL/identity/token |awk -F \" '{print $4}'`
LIST=$(curl -sL -w "%{http_code}" -H "X-Auth-Token:${AUTH_TOKEN}" -H "X-Auth-Tenant-ID:${ADMIN_TENANT_ID}" ${API_URL}/compute/ -o /dev/null)

if [ $LIST == 200 ]; then 
    exit 0
else
    exit 1
fi
