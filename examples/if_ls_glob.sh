#!/bin/bash

set -eux

main() {
  if ls *.txt >/dev/null 2>&1; then
    printf *.txt
  fi
}

main "$@"
