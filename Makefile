include .env

.PHONY: help docker-pull docker-up docker-stop docker-down docker-prune

default: help

help:  ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

project-init: ## Init local files.
	@echo "$(COLOR_LIGHT_GREEN)Init local files...$(COLOR_NC)"
	rsync -avz --ignore-existing ./example.env ./.env

docker-pull: ## Update container images.
	@echo "$(COLOR_LIGHT_GREEN)Update containers images for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose pull

docker-up: ## Start containers.
	@echo "$(COLOR_LIGHT_GREEN)Starting up containers for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose up -d

docker-stop: ## Stop containers.
	@echo "$(COLOR_LIGHT_GREEN)Stopping containers for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose stop

docker-down: ## Remove containers.
	@echo "$(COLOR_LIGHT_GREEN)Removing containers for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose down

docker-prune: ## Remove containers, volumes and images.
	@echo "$(COLOR_LIGHT_GREEN)Removing containers, volumes and images for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose down -v --rmi all

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
