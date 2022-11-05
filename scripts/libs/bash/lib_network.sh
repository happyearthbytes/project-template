#!/usr/bin/env bash

_is_network_connected ()
{
  nc -zw1 google.com 443
  RVAL=$?
  [ "$RVAL" == "0" ]
}
