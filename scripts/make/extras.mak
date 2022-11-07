TOOLS_SCRIPTS = $(ROOT_DIR)/scripts/tools

compress: # use compression utility
	@./scripts/tools/compress.sh --compress --input . --output ~/compressed.txt ${ARGS}
extract: # use extraction utility
	@./scripts/tools/compress.sh --extract --input ~/compressed.txt --output ~/extracted ${ARGS}
