# =========================================================================== #
#                                                                             #
#                 ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓                 #
#                 ┃   ███╗   ██╗ ██████╗ ██╗   ██╗ █████╗   ┃                 #
#                 ┃   ████╗  ██║██╔═████╗██║   ██║██╔══██╗  ┃                 #
#                 ┃   ██╔██╗ ██║██║██╔██║██║   ██║███████║  ┃                 #
#                 ┃   ██║╚██╗██║████╔╝██║╚██╗ ██╔╝██╔══██║  ┃                 #
#                 ┃   ██║ ╚████║╚██████╔╝ ╚████╔╝ ██║  ██║  ┃                 #
#                 ┃   ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝  ┃                 #
#                 ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛                 #
#                                                                             #
#                        This machine kills fascists.                         #
#                                                                             #
# =========================================================================== #

CONTAINER       = krisnova/home
CONTAINER_TAG   = latest
CONTAINER_SHA   = $(shell git rev-parse --short HEAD)
default: help

install: ## Install "Novix" on the local workstation. 
	@echo "Installing..."
	. lib/_install

container: ## Build the Dockerfile
	@echo "Building Dockerfile"
	sudo -E docker build -t ${CONTAINER}:${CONTAINER_TAG} -f Dockerfile .
	sudo -E docker build -t ${CONTAINER}:${CONTAINER_SHA} -f Dockerfile .

dev: ## Run a development copy of Novix in a container
	sudo -E docker run -it ${CONTAINER}:${CONTAINER_TAG} /bin/bash

push: ## Push the container image to dockerhub
	sudo -E docker push ${CONTAINER}:${CONTAINER_TAG}
	sudo -E docker push ${CONTAINER}:${CONTAINER_SHA}

clean: ## Clean your artifacts 🧼
	@echo "Cleaning..."
	rm -rvf out/*
	rm -rvf *flag*

.PHONY: help
help:  ## 🤔 Show help messages for make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'
