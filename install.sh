#!/usr/bin/env bash
brew update
brew install openssl@1.1
echo 'export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"' >> ~/.bash_profile
# Verify 
openssl version
