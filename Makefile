.DEFAULT_GOAL : help

help: ## Show this help
	@printf "\033[33m%s:\033[0m\n" 'Available commands'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \033[32m%-18s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
pull: ## Pull latest images
	docker compose pull
build: ## Build images
	docker compose build
update: ## Update dependencies
	docker compose run php env XDEBUG_MODE=off composer update
bash: ## php shell
	docker compose run php bash
demo: ## Run the demo
	docker compose run php php demo.php
