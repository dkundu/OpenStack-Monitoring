#!/bin/bash

export TERM=vt100
API_URL="http://csapi:8082/csapi"
ADMIN_TENANT_ID="b3c18bc8a54f4f1c93afe949f790d5c6"

RETURN=$(curl -sL -w"%{http_code}" -d '{"passwordCredentials":{"username":"admin", "password":"secrete"},"tenantName":"admin"}' $API_URL/identity/token -o /dev/null)

if [ $RETURN == 200 ]; then
    exit 0
else
    exit 1
fi
