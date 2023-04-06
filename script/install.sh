#!/bin/bash

# ==============================================================================
# this script is meant to be run from the root of the project
# ==============================================================================

source .env

php bin/magento setup:install \
--elasticsearch-host=elasticsearch \
--search-engine=elasticsearch7 \
--admin-firstname=${MAGENTO_ADMIN_FISTNAME} \
--admin-lastname=${MAGENTO_ADMIN_LASTNAME} \
--admin-email=${MAGENTO_ADMIN_EMAIL} \
--admin-user=${MAGENTO_ADMIN_USER} \
--admin-password=${MAGENTO_ADMIN_PASSWORD} \
--base-url=${MAGENTO_BASE_URL} \
--base-url-secure=${MAGENTO_BASE_URL_SECURE} \
--backend-frontname=${MAGENTO_BACKEND_FRONTNAME} \
--db-host=mysql \
--db-name=${MAGENTO_DB_NAME} \
--db-user=${MAGENTO_DB_USER} \
--db-password=${MAGENTO_DB_PASSWORD} \
--use-rewrites=1 \
--language=${MAGENTO_LANGUAGE_CODE} \
--currency=${MAGENTO_CURRENCY} \
--timezone=${MAGENTO_TIMEZONE} \
--use-secure-admin=1 \
--admin-use-security-key=1 \
--session-save=files \
--use-sample-data \
--cleanup-database
