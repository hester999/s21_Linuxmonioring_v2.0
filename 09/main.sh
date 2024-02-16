#!/bin/bash

main () {
  bash install.sh
  source info.sh
  while true; do
    get_info
    sleep 3
  done
}
main ${@}
