PROJECT_NAME := "my-proj" ## The name of the project
VERSION := "0.x.0" ## A string name of the version
USERNAME := $(shell id -un) ## The username to use
ARGS := ## Generic interface for inputing arguments
include scripts/make/common.mak
include scripts/make/basic.mak

.PHONY: help install

a_command: ## do a command
	@echo todo
another_command: # do another command
	@echo todo
compress: # do another command
	@./scripts/tools/compress.sh --compress --input . --output ~/compressed.txt ${ARGS}
extract: # do another command
	@./scripts/tools/compress.sh --extract --input ~/compressed.txt --output ~/extracted ${ARGS}
