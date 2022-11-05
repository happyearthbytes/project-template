TOOLS_SCRIPTS = $(ROOT_DIR)/scripts/tools
setup: ## Do this first - get setup for development
	@./setup.sh ${ARGS}
download: ## Download packages locally
	@$(TOOLS_SCRIPTS)/download.sh ${ARGS}
install: ## Install downloaded packages
	@$(TOOLS_SCRIPTS)/install.sh ${ARGS}
clean: ## clean all temporary files
	@$(TOOLS_SCRIPTS)/clean.sh ${ARGS}
