#!/usr/bin/env bash

optspec=":-:"
while getopts "$optspec" optchar; do
  case "${optchar}" in
    -)
      case "${OPTARG}" in
        *)
          val=${OPTARG#*=}
          opt=${OPTARG%=$val}
          eval ${opt}=${val}
          ;;
      esac;;
    *)
      if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
          ERROR "-${OPTARG}" "Non-option argument"
      fi
      ;;
  esac
done
