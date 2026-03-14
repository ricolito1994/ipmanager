#!/bin/sh

set -e

# run this after installation
# add additional setup for each microservice

SERVICES="
ipmanager-auth-service-1
ipmanager-gateway-service-1
ipmanager-ip-manager-service-1
"

for SERVICE in $SERVICES
do
  echo "------------------------------"
  echo "Permissions for $SERVICE"
  echo "------------------------------"

  docker exec $SERVICE chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

  echo "------------------------------"
  echo "Testing DB connection for $SERVICE"
  echo "------------------------------"

  if docker exec $SERVICE php artisan migrate:status > /dev/null 2>&1
  then
        docker exec $SERVICE php artisan route:clear
        docker exec $SERVICE php artisan cache:clear

        echo "Generating key for $SERVICE"

        docker exec $SERVICE php artisan key:generate

        echo "DB connection OK for $SERVICE"

        echo "Running migrations..."
        docker exec $SERVICE php artisan migrate --force

        echo "Running seeders..."
        docker exec $SERVICE php artisan db:seed

        echo "Optimize services..."
        docker exec $SERVICE php artisan optimize

  else
      echo "DB connection FAILED for $SERVICE"
      exit 1
  fi
  
done

echo "All services migrated successfully."