include .env
#---DOCKER---#
IMAGE=rust-dev
PROJECT_NAME=my_project
ifeq ($(shell where podman 2> NUL),)
	DOCKER_COMPOSE = docker compose
#	DOCKER_COMPOSE = docker-compose
else
	DOCKER_COMPOSE = podman-compose --project-name hexo-dev
endif
DOCKER_COMPOSE_DOWN = $(DOCKER_COMPOSE) down
DOCKER_COMPOSE_UP = $(DOCKER_COMPOSE) up -d
#DOCKER_COMPOSE_UP = $(DOCKER_COMPOSE) up
EXEC = $(DOCKER_COMPOSE) exec $(IMAGE)
CARGO = $(EXEC) cargo
CARGO_RUN = $(EXEC) sh -c "cd $(PROJECT_NAME) && cargo run" 
CARGO_TEST = $(EXEC) sh -c "cd $(PROJECT_NAME) && cargo test" 
CARGO_BUILD = $(EXEC) sh -c "cd $(PROJECT_NAME) && cargo build" 
#------------#

%:
	@true

create:
	@echo "Creating your Rust project : $(PROJECT_NAME)"
	rm -rf $(PROJECT_NAME)
	$(CARGO) new $(PROJECT_NAME)
	echo "$(PROJECT_NAME)/target/*" > .gitignore
.PHONY: create

new:
	@echo "Creating new Rust project"
	$(CARGO) new "$(filter-out $@, $(MAKECMDGOALS))"
.PHONY: new

add:
	@echo "Adding crates to your project"
	$(EXEC) sh -c "cd $(PROJECT_NAME) && cargo add $(filter-out $@, $(MAKECMDGOALS))"
.PHONY: add

remove:
	@echo "Removing crates to your project"
	$(EXEC) sh -c "cd $(PROJECT_NAME) && cargo remove $(filter-out $@, $(MAKECMDGOALS))"
.PHONY: remove

run:
	@echo "Running your Rust project"
	$(CARGO_RUN)
.PHONY: run

bash:
	@echo "Testing cargo"
	$(EXEC) bash
.PHONY: bash

start:
	@echo "Starting docker development environment for Rust"
	$(DOCKER_COMPOSE_UP) 
.PHONY: start

stop:
	@echo "Stopping docker"
	$(DOCKER_COMPOSE_DOWN) 
.PHONY: stop

restart: # restart env
	$(DOCKER_COMPOSE_DOWN) 
	$(DOCKER_COMPOSE_UP) 
.PHONY: start

