# Magento 2.4.6

## Description

This is a dockerized version of Magento 2.4.6

## Requirements

- [Bash](https://www.gnu.org/software/bash/)
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Installation

1. Create a `.env` file : `cp .env.dist .env` and fill it with your informations

2. Create a `auth.json` file: `cp auth.json.sample auth.json` and fill it with your informations. You can find your `public-key` and `private-key` in your [Magento Marketplace account](https://marketplace.magento.com/customer/accessKeys/)

3. Run `script/install.sh` (outside the container). It will install the database and the Magento 2.4.6 source code.

4. Go to your browser and enter the address specified in the `.env` file in **MAGENTO_BASE_URL**

5. Optionally you can install sample data by running `bin/magento sampledata:deploy` and `bin/magento setup:upgrade`

## Usage

### Magento CLI

To use the Magento CLI, you need to enter the container: `docker-compose exec web bash`

Then, you can run the Magento CLI without specifying the `bin/magento` part. For example, to run the `setup:upgrade` command, you need to run `setup:upgrade` in the container.

## Containers

### Web

This container is based on the [webdevops/php-apache-dev:8.1](https://hub.docker.com/r/webdevops/php-apache-dev/) image.

It contains the Magento 2.4.6 source code and the Magento CLI in the `/var/www/html` directory.

### MySQL

This container is based on the [mysql:8](https://hub.docker.com/_/mysql/) image.

### Elasticsearch

This container is based on the [elasticsearch:7.17.0](https://hub.docker.com/_/elasticsearch/) image.

### PhpMyAdmin

This container is based on the [phpmyadmin/phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/) image.
