TOOLS_SCRIPTS = $(ROOT_DIR)/scripts/tools
setup: ## Perform setup operations - Interactive
	@./setup.sh ${ARGS}
setup-bootstrap: setup-bootstrap-args setup ## Set up your environment to boostrap the process
setup-bootstrap-args:
  ARGS="--type bootstrap"
download: ## Download packages locally
	@$(TOOLS_SCRIPTS)/download.sh ${ARGS}
install: ## Install downloaded packages
	@$(TOOLS_SCRIPTS)/install.sh ${ARGS}
clean: ## clean all temporary files
	@$(TOOLS_SCRIPTS)/clean.sh ${ARGS}
