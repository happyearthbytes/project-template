#!/bin/bash

# Input file

LASTTIME=0

# cmake --build /build --target clean
rm /build/*

while [ true ]; do
  FILETIME=$(stat /src/*mine.cpp --format=%Y)
  if [ "$LASTTIME" -ne "${FILETIME}" ]; then
    echo "===="
    LASTTIME=${FILETIME}
    cmake -B /build -S /src && cmake --build /build
    echo "=="
    /build/leet_code
    echo "===="
  fi
  echo -n "."
  sleep 1;
done
