-- Databases
CREATE DATABASE IF NOT EXISTS auth_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS gateway_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS ipmanager_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Other microservice users
CREATE USER IF NOT EXISTS 'auth'@'%' IDENTIFIED WITH mysql_native_password BY 'authpass';
GRANT ALL PRIVILEGES ON auth_db.* TO 'auth'@'%';

CREATE USER IF NOT EXISTS 'gateway'@'%' IDENTIFIED WITH mysql_native_password BY 'gatewaypass';
GRANT ALL PRIVILEGES ON gateway_db.* TO 'gateway'@'%';

CREATE USER IF NOT EXISTS 'ipmanager'@'%' IDENTIFIED WITH mysql_native_password BY 'ipmanagerpass';
GRANT ALL PRIVILEGES ON gateway_db.* TO 'ipmanager'@'%';

FLUSH PRIVILEGES;