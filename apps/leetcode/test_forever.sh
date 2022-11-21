#!/bin/bash

# Input file

LASTTIME=0

# cmake --build /build --target clean
if false ; then
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

else
  FILE=$1
  while sleep 1; do
    # FILETIME=$(stat "${FILE}" --format=%Y)
    FILETIME=$(stat -f %c "${FILE}") # Mac
    if [ "$LASTTIME" -ne "${FILETIME}" ]; then
      LASTTIME=${FILETIME}
      ./"${FILE}"
    fi
    echo -n "."
  done
fi