CURRENT_DIR = $(shell pwd)
ROOT_DIR = $(CURRENT_DIR)
# ANSI escape code colors
TEXT_BOLD   := \033[1m
TEXT_ITALIC := \033[3m
TEXT_UNDER := \033[4m
TEXT_GOOD  := \033[0;32m
TEXT_BAD    := \033[0;31m
TEXT_ITEM   := \033[0;34m
TEXT_SPECIAL   := \033[0;33m
TEXT_CONTRAST   := \033[0;7m
TEXT_WARNING   := \033[45;1m
TEXT_ERROR   := \033[41;1m
TEXT_INFO   := \033[44;1m
TEXT_RESET  := \033[0m

# Extract the "project_name: <PROJECT_NAME>" from config.yml
ifeq ($(PROJECT_NAME),)
PROJECT_NAME := $(shell sed -n '/^project_name:/ s/[^:]*: *//p' config.yml)
endif
ifeq ($(VERSION),)
VERSION := $(shell cat VERSION)
endif

# File references
THIS_FILE=$(shell echo $(MAKEFILE_LIST) | cut -f1 -d' ')
OTHER_FILE=$(shell echo $(MAKEFILE_LIST) | awk '{ $$1=""; print $0}' )

_ECHO_FLAG="" #"-e"

default: help-default
help-default: # Display default make command options
	@echo ${_ECHO_FLAG} "$(TEXT_BOLD)Make command options for ${TEXT_SPECIAL}${PROJECT_NAME} ${VERSION}$(TEXT_RESET)"
	@echo ""
	@grep -E "^[0-9a-zA-Z_-]+:.*?## .*$$" $(THIS_FILE) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(TEXT_ITEM)$(TEXT_BOLD)%-30s$(TEXT_RESET) %s\n", $$1, $$2}'
	@echo ""
	@grep -E "^[0-9a-zA-Z_-]+:.*?## .*$$" $(OTHER_FILE) | sed 's/[^:]*://' | awk 'BEGIN {FS = ":.*?## "}; {printf "$(TEXT_ITEM)%-30s$(TEXT_RESET) %s\n", $$1, $$2}'
	@echo ""
help: help-default ## Display make command options
	@echo ${_ECHO_FLAG} "$(TEXT_BOLD)${TEXT_UNDER}Variables:$(TEXT_RESET)"
	@echo ""
	@grep -E "^[0-9a-zA-Z_-]+ *:= *[^#]*## .*$$" $(THIS_FILE) | awk 'BEGIN {FS = ":="}; {printf "$(TEXT_ITEM)$(TEXT_SPECIAL)%-30s$(TEXT_RESET) %s\n", $$1, $$2}'
	@echo ""
	@echo ${_ECHO_FLAG} "$(TEXT_BOLD)${TEXT_UNDER}Advanced Make Targets:$(TEXT_RESET)"
	@echo ""
	@grep -E "^[0-9a-zA-Z_-]+:[^#]*# .*$$" $(THIS_FILE) | awk 'BEGIN {FS = ":.*?# "}; {printf "$(TEXT_BAD)$(TEXT_BOLD)%-30s$(TEXT_RESET) %s\n", $$1, $$2}'
	@echo ""
	@grep -E "^[0-9a-zA-Z_-]+:[^#]*# .*$$" $(OTHER_FILE) | sed 's/[^:]*://' | awk 'BEGIN {FS = ":.*?# "}; {printf "$(TEXT_BAD)%-30s$(TEXT_RESET) %s\n", $$1, $$2}'
	@echo ""
	@grep -E "^[0-9a-zA-Z_-]+:[^#]*$$" $(THIS_FILE) | awk 'BEGIN {FS = ":.* "}; {printf "$(TEXT_BAD)$(TEXT_BOLD)%-30s$(TEXT_RESET) ${TEXT_ITALIC}%s$(TEXT_RESET)\n", $$1, $$2}'
	@echo ""
	@grep -E "^[0-9a-zA-Z_-]+:[^#]*$$" $(OTHER_FILE) | sed 's/[^:]*://' | awk 'BEGIN {FS = ":.* "}; {printf "$(TEXT_BAD)%-30s$(TEXT_RESET) ${TEXT_ITALIC}%s$(TEXT_RESET)\n", $$1, $$2}'
	@echo ""
	@echo ${_ECHO_FLAG} "$(TEXT_BOLD)${TEXT_UNDER}Advanced Variables:$(TEXT_RESET)"
	@echo ""
	@grep -E "^[0-9a-zA-Z_-]+ *:= *[^#]*$$" $(THIS_FILE) | awk 'BEGIN {FS = ":="}; {printf "$(TEXT_ITEM)$(TEXT_SPECIAL)%-30s$(TEXT_RESET) ${TEXT_ITALIC}%s$(TEXT_RESET)\n", $$1, $$2}'
	@echo ""

text-demo: # display a text demo
	@echo "${TEXT_WARNING}TEXT_WARNING$(TEXT_RESET)"
	@echo "${TEXT_ERROR}TEXT_ERROR$(TEXT_RESET)"
	@echo "${TEXT_INFO}TEXT_INFO$(TEXT_RESET)"
	@echo "${TEXT_BOLD}TEXT_BOLD$(TEXT_RESET)"
	@echo "${TEXT_ITALIC}TEXT_ITALIC$(TEXT_RESET)"
	@echo "${TEXT_UNDER}TEXT_UNDER$(TEXT_RESET)"
	@echo "${TEXT_GOOD}TEXT_GOOD$(TEXT_RESET)"
	@echo "${TEXT_BAD}TEXT_BAD$(TEXT_RESET)"
	@echo "${TEXT_ITEM}TEXT_ITEM$(TEXT_RESET)"
	@echo "${TEXT_SPECIAL}TEXT_SPECIAL$(TEXT_RESET)"
	@echo "${TEXT_CONTRAST}TEXT_CONTRAST$(TEXT_RESET)"
