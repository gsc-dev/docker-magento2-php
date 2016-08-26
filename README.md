# Versions

- [`5.6.23-fpm-3` (_Dockerfile_)](https://github.com/mageinferno/docker-magento2-php/tree/5.6.23-fpm-3/Dockerfile)
- [`7.0.8-fpm-3` (_Dockerfile_)](https://github.com/mageinferno/docker-magento2-php/tree/7.0.8-fpm-3/Dockerfile)

# Description

This image is built from the official [`php`](https://hub.docker.com/_/php/) repository and contains PHP configurations for Magento 2.

# What's in this image?

This image installs the following base packages:

- `composer`
- `php-fpm`

This image also installs the following PHP extensions, which are the minimally required extensions to install and run Magento 2:

- `gd`
- `intl`
- `mbstring`
- `mcrypt`
- `pdo_mysql`
- `soap`
- `xsl`
- `zip`

# Variables

The following variables may be set to control the PHP environment:

- `PHP_MEMORY_LIMIT`: (default `2G`) Set the memory_limit of php.ini
- `PHP_PORT`: (default: `9000`) Set a custom PHP port
- `PHP_PM`: (default `dynamic`) Set the process manager
- `PHP_PM_MAX_CHILDREN`: (default: `10`) Set the max number of children processes
- `PHP_PM_START_SERVERS`: (default: `4`) Set the default number of servers to start at runtime
- `PHP_PM_MIN_SPARE_SERVERS`: (default `2`) Set the minumum number of spare servers
- `PHP_PM_MAX_SPARE_SERVERS`: (default: `6`) Set the maximum number of spare servers
- `APP_MAGE_MODE`: (default: `default`) Set the MAGE_MODE


# Docker Compose

Please see [https://github.com/mageinferno/magento2-docker-compose](https://github.com/mageinferno/magento2-docker-compose) for more detailed instructions and an example development environment using Docker Compose.
