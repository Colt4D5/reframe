SHELL := /bin/bash

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

WEB_DIR := apps/frontend
API_DIR := apps/backend

COMPOSE := docker compose

WEB_IMAGE := my-app-web
API_IMAGE := my-app-api
AIR_BIN := $(shell go env GOPATH)/bin/air


# ------------------------------------------------------------------------------
# Development
# ------------------------------------------------------------------------------

.PHONY: dev
dev:
	@$(MAKE) dev-web & \
	$(MAKE) dev-api & \
	wait

.PHONY: dev-web
dev-web:
	pnpm --filter frontend dev

.PHONY: install-air
install-air:
	@if [ ! -x "$(AIR_BIN)" ]; then go install github.com/air-verse/air@latest; fi

.PHONY: dev-api
dev-api: install-air
	cd $(API_DIR) && $(AIR_BIN) -c .air.toml


# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

.PHONY: install
install:
	pnpm install
	cd $(API_DIR) && go mod download
	go install github.com/air-verse/air@latest

.PHONY: update
update:
	pnpm update
	cd $(API_DIR) && go get -u ./...
	cd $(API_DIR) && go mod tidy


# ------------------------------------------------------------------------------
# Build
# ------------------------------------------------------------------------------

.PHONY: build
build: build-web build-api

.PHONY: build-web
build-web:
	pnpm --filter frontend build

.PHONY: build-api
build-api:
	cd $(API_DIR) && go build -o bin/server ./cmd/server


# ------------------------------------------------------------------------------
# Test
# ------------------------------------------------------------------------------

.PHONY: test
test: test-web test-api

.PHONY: test-web
test-web:
	pnpm --filter frontend test

.PHONY: test-api
test-api:
	cd $(API_DIR) && go test ./...


# ------------------------------------------------------------------------------
# Lint / Validation
# ------------------------------------------------------------------------------

.PHONY: lint
lint: lint-web lint-api

.PHONY: lint-web
lint-web:
	pnpm --filter web lint

.PHONY: lint-api
lint-api:
	cd $(API_DIR) && go vet ./...

.PHONY: check
check: lint test build


# ------------------------------------------------------------------------------
# Docker - Development
# ------------------------------------------------------------------------------

.PHONY: docker-up
docker-up:
	$(COMPOSE) up -d

.PHONY: docker-down
docker-down:
	$(COMPOSE) down

.PHONY: docker-logs
docker-logs:
	$(COMPOSE) logs -f

.PHONY: docker-restart
docker-restart:
	$(COMPOSE) down
	$(COMPOSE) up -d

.PHONY: docker-ps
docker-ps:
	$(COMPOSE) ps


# ------------------------------------------------------------------------------
# Docker - Build
# ------------------------------------------------------------------------------

.PHONY: docker-build
docker-build:
	$(COMPOSE) build

.PHONY: docker-build-web
docker-build-web:
	$(COMPOSE) build web

.PHONY: docker-build-api
docker-build-api:
	$(COMPOSE) build api


# ------------------------------------------------------------------------------
# Docker - Production
# ------------------------------------------------------------------------------

.PHONY: docker-up-prod
docker-up-prod:
	$(COMPOSE) -f docker-compose.yml -f docker-compose.prod.yml up -d

.PHONY: docker-down-prod
docker-down-prod:
	$(COMPOSE) -f docker-compose.yml -f docker-compose.prod.yml down

.PHONY: docker-build-prod
docker-build-prod:
	$(COMPOSE) -f docker-compose.yml -f docker-compose.prod.yml build


# ------------------------------------------------------------------------------
# Database
# ------------------------------------------------------------------------------

.PHONY: db-shell
db-shell:
	$(COMPOSE) exec db psql -U $${POSTGRES_USER} -d $${POSTGRES_DB}

.PHONY: db-logs
db-logs:
	$(COMPOSE) logs -f db


# ------------------------------------------------------------------------------
# Cleanup
# ------------------------------------------------------------------------------

.PHONY: clean
clean:
	rm -rf $(WEB_DIR)/build
	rm -rf $(WEB_DIR)/.svelte-kit
	rm -rf $(API_DIR)/bin

.PHONY: docker-clean
docker-clean:
	$(COMPOSE) down --volumes --remove-orphans