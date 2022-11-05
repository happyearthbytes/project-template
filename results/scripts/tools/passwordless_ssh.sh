#!/bin/bash
# This is a helper script to facilitate passwordless logins between hosts via ssh

# Help text
if [ "$1" == "-h" ]; then
  echo "Usage: $0 [-h] USERNAME HOSTNAME"
  exit 1
fi

# Get args from input if not provided as args
if [ $# -lt 2 ]
then
  echo "username: "
  read USERNAME
  echo "hostname: "
  read HOSTNAME
else
  USERNAME=$1
  HOSTNAME=$2
fi

# Run the command to setup passwordless ssh
cat ~/.ssh/id_rsa.pub | ssh ${USERNAME}@${HOSTNAME} "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"