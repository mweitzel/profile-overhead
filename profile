#!/usr/bin/env bash

set -e

function get_command_from_shabang() {
  local file=$1
  head -n 1 $file | grep -E '^#!/' | cut -d' ' -f2
}

function can_run_file() {
  local file=$1
  test -x $file && which -s $(get_command_from_shabang $file)
}

function warn_cannot_run() {
  local file=$1
  echo "# WARNING -- $file cannot be ran"
  echo "# $(get_command_from_shabang $file) not found"
}

function main() {
  find * -type f -name hello |
  while read file
  do
    can_run_file $file || {
      warn_cannot_run $file
      continue
    }
    {
      echo "Running $file with $(which $(get_command_from_shabang $file))"
      time $file
    } 2>&1 | sed 's/^/# /'
    echo
  done
}

main
