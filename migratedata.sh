#!/bin/sh

set -e

# be sure to install docker
# run this after installation
# add additional setup for each microservice

SERVICES="
ipmanager-auth-service-1
ipmanager-gateway-service-1
ipmanager-ip-manager-service-1
"

# generate a JWT secret hash value for all services
SHARED_JWT_SECRET=$(openssl rand -base64 48)

for SERVICE in $SERVICES
do
  echo "------------------------------"
  echo "Permissions for $SERVICE"
  echo "------------------------------"

  docker exec $SERVICE sh -c "chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache"

  echo "Generate .env files in $SERVICE"

  if ! docker exec $SERVICE sh -c "[ -f .env ]"; then
    if ! docker exec $SERVICE sh -c "[ -f .env.example ]"; then
      echo "No .env.example found in $SERVICE."
      exit 1;
    fi

    docker exec $SERVICE cp .env.example .env
  fi

  # JWT should be enabled/installed in each service
  # SHARE the generated JWT secret to each service

  echo "Synching JWT secret to each services ... "
  
  if ! docker exec $SERVICE grep -q "JWT_SECRET=" .env; then
    docker exec $SERVICE sh -c "echo JWT_SECRET=$SHARED_JWT_SECRET >> .env"
  else
    docker exec $SERVICE sh -c "sed -i 's|JWT_SECRET=.*|JWT_SECRET=$SHARED_JWT_SECRET|g' .env"
  fi

  echo "Synch complete .."

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