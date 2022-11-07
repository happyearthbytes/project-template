TOOLS_SCRIPTS = $(ROOT_DIR)/scripts/tools


# Setup
#-------------------------------------------------------------------------------
setup-bootstrap: setup-bootstrap-args setup ## Set up your environment to boostrap the process
setup-bootstrap-args:
  ARGS="--type bootstrap"
setup-online-cicd: setup-online-cicd-args setup ## Set up a local cicd instance
setup-online-cicd-args:
  ARGS="--type online-cicd"
setup: ## Perform setup operations - Interactive
	@./setup.sh ${ARGS}
# Download
#-------------------------------------------------------------------------------
download-online-deps: download-online-deps-args download ## Download dependencies while in an online environment
download-online-deps-args:
  ARGS="--type online-deps"
download: ## Download packages locally - Interactive
	@$(TOOLS_SCRIPTS)/download.sh ${ARGS}
# Other
#-------------------------------------------------------------------------------
install: ## Install downloaded packages
	@$(TOOLS_SCRIPTS)/install.sh ${ARGS}
clean: ## clean all temporary files
	@$(TOOLS_SCRIPTS)/clean.sh ${ARGS}
