#!/bin/bash

ADMIN_TENANT_ID="b3c18bc8a54f4f1c93afe949f790d5c6"
API_URL="http://csapi:8082/csapi"

AUTH_TOKEN=`curl -s -d '{"passwordCredentials":{"username":"admin", "password":"secrete"},"tenantName":"admin"}' $API_URL/identity/token |awk -F \" '{print $4}'`
LIST=$(curl -sL -w "%{http_code}" -H "X-Auth-Token:${AUTH_TOKEN}" -H "X-Auth-Tenant-ID:${ADMIN_TENANT_ID}" ${API_URL}/compute/ -o /dev/null)
if [ ${LIST} -ne 200 ]; then 
    exit 1
fi

CREATE=$(curl -sL -w "%{http_code}" -X POST -d '{"Compute": {"tenant_id": "admin", "username": "admin", "password": "secrete", "image": "centos", "flavor": "tiny", "name": "monitoring", "count": 1, "auth": "nova5_root", "token": "${AUTH_TOKEN}"}}' -H "Content-type: application/json" ${API_URL}/compute/ -o /dev/null)
if [ ${CREATE} -ne 200 ]; then 
    exit 1
fi

sleep 30

DELETE=$(curl -sL -w "%{http_code}" -X DELETE -d '{"Compute": {"tenant_id": "admin", "username": "admin", "password": "secrete", "node": "monitoring", "token": "${AUTH_TOKEN}"}}' -H "Content-type: application/json" ${API_URL}/compute/ -o /dev/null)
if [ ${DELETE} -ne 200 ]; then 
    exit 1
fi

exit 0
