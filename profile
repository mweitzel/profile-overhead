#!/usr/bin/env bash

set -e                              # fail fast

find * -type f -name hello |
while read line
do
  echo -n "$line - "
  time $line
  echo
done 2>&1
