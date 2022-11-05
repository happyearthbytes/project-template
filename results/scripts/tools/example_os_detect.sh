#!/usr/bin/env bash

get_os()
{
if [ -e /etc/os-release ]; then
  . /etc/os-release
  dist=`echo ${VERSION_ID} | awk -F '.' '{ print $1 }'`
  os=${ID}
  os="${os// /}"
  dist="${dist// /}"
  echo "OS: ${os} ${dist}"
  export os
  export dist
else
  exit 1
fi
}

get_installer()
{
  case "${os}" in
    debian|ubuntu)
      echo apt
    ;;
    *)
      echo dnf
    ;;
  esac
}

get_os
