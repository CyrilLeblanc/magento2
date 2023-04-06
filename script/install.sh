#!/bin/bash

# ==============================================================================
# this script is meant to be run from the root of the project and outside of the
# docker container.
# It will start the docker containers.
# Then it will run a composer install.
# Then also run the sql script to set the configuration values for database
# users and passwords.
# Then run the magento setup:install command with the appropriate parameters.
# ==============================================================================

source .env;

# Log a message in green.
log() {
    echo -e "\033[0;32m$1\033[0m";
}

# Start docker.
start_docker() {
    log "1/4 Starting docker containers...";
    docker-compose up -d;
}

# Install composer.
composer_install() {
    log "2/4 Installing composer packages...";
    docker exec -i ${PROJECT_NAME}_web bash -c "composer install";
}

# Install database and magento user.
install_database() {
    log "3/4 Installing database and magento user...";
    SQL_SCRIPT="\
        CREATE DATABASE IF NOT EXISTS ${MAGENTO_DB_NAME};\
        CREATE USER IF NOT EXISTS '${MAGENTO_DB_USER}'@'%' IDENTIFIED BY '${MAGENTO_DB_PASSWORD}';\
        GRANT ALL PRIVILEGES ON *.* TO '${MAGENTO_DB_USER}'@'%';\
        FLUSH PRIVILEGES;"

    docker exec -i ${PROJECT_NAME}_mysql mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "${SQL_SCRIPT}"
}

# Install magento.
install_magento() {
    log "4/4 Installing magento...";
    INSTALL_COMMAND="\
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
        --cleanup-database"

    docker exec -i ${PROJECT_NAME}_web bash -c "${INSTALL_COMMAND}"
}

# Run the install.
install() {
    start_docker && \
    composer_install && \
    install_database && \
    install_magento;
}

install;
