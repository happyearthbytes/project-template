PROJECT_NAME := "my-proj" ## The name of the project - TODO parse from file
VERSION := "0.x.0" ## A string name of the version - TODO parse from file
USERNAME := $(shell id -un) ## The username to use - TODO set in include
ARGS := ## Generic interface for inputing arguments - TODO set in include
include scripts/make/common.mak
include scripts/make/basic.mak
include scripts/make/extras.mak

.PHONY: help

run_a_command: ## Run a command
	@echo todo
run_another_command: ## Run another command
	@echo todo
run_an_advanced_command: # Run an advanced command
	@echo todo
