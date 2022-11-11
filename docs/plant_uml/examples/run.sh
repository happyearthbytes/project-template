#!/usr/bin/env bash
PLANTUML=plantuml

java -jar ${PLANTUML} -x "*.txt" -r src -o ~/ -tpng