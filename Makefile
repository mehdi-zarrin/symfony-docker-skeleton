#!/usr/bin/make

SHELL = /bin/sh

CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)

export CURRENT_UID
export CURRENT_GID

DOCKER_COMPOSE=docker-compose -p symfony-docker-skeleton -f docker/docker-compose.yml
RUN_IN_PHP_CONTAINER= $(DOCKER_COMPOSE) run --rm php

build:
	$(DOCKER_COMPOSE) build

build-clean:
	$(DOCKER_COMPOSE) build --no-cache

startup:
	$(DOCKER_COMPOSE) up -d


down:
	$(DOCKER_COMPOSE) down -v --remove-orphans

composer-install:
	$(RUN_IN_PHP_CONTAINER) composer install --no-interaction

# usage: composer-require $PACKAGE="symfony/orm-pack"
composer-require:
	$(RUN_IN_PHP_CONTAINER) composer require ${PACKAGE}

console:
	$(DOCKER_COMPOSE) exec php sh

nginx:
	$(DOCKER_COMPOSE) exec nginx sh