#!/usr/bin/env bash

set -e                              # fail fast

function can_run_file() {
  local file=$1
  echo $file
  test -x $1 && which $(head -n 1 $file | cut -d' ' -f2)
}

function warn_cannot_run() {
  local file=$1
  echo "# WARNING -- $file cannot be ran" >&2
}

function main() {
  find * -type f -name hello |
  while read line
  do
    can_run_file $line || {
      warn_cannot_run $line
      continue
    }
    time $line 2>&1
    echo
  done
}

main
