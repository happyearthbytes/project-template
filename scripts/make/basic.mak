TOOLS_SCRIPTS = $(ROOT_DIR)/scripts/tools


# Setup
#-------------------------------------------------------------------------------
setup-bootstrap: setup-bootstrap-args setup ## Set up your environment to boostrap the process
setup-bootstrap-args:
	$(eval ARGS := "--env bootstrap")
setup-online_cicd: setup-online_cicd-args setup ## Set up a local cicd instance
setup-online_cicd-args:
	$(eval ARGS := "--env online_cicd")
setup-online_local: setup-online_local-args setup # Set up a local instance
setup-online_local-args:
	$(eval ARGS := "--env online_local")
setup: ## Perform setup operations - Interactive
	@./setup.sh ${ARGS}
# Download
#-------------------------------------------------------------------------------
download-online_deps: download-online_deps-args download ## Download dependencies while in an online environment
download-online_deps-args:
	$(eval ARGS := "--type online_deps --os Rocky_Linux_9")
download: ## Download packages locally - Interactive
	@$(TOOLS_SCRIPTS)/download.sh ${ARGS}
# Other
#-------------------------------------------------------------------------------
install: ## Install downloaded packages
	@$(TOOLS_SCRIPTS)/install.sh ${ARGS}
clean: ## clean all temporary files
	@$(TOOLS_SCRIPTS)/clean.sh ${ARGS}
check: ## check code - static analysis
	@$(TOOLS_SCRIPTS)/check.sh ${ARGS}
