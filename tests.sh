#!/bin/bash

set -e

SERVICES="
ipmanager-auth-service-1
ipmanager-gateway-service-1
ipmanager-ip-manager-service-1
"

echo "--------------RUNNING-TESTS--------------"

for SERVICE in $SERVICES
do

    echo "----------------------------------------"
    echo "RUNNING TEST FOR $SERVICE ....."
    docker exec $SERVICE php artisan test
    echo "----------------------------------------"

done