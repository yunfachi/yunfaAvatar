#!/usr/bin/env bash

reset="\e[0m"
endl="$reset\n"

text="\e[38;5;255m"
info="\e[38;5;228m"
response="\e[38;5;81m"
error="\e[38;5;196m"
delimiter="\e[38;5;0m"

SPACE() {
  printf "\n" >&2;
}

INFO() { if [ "${show_info}" == "true" ]; then
  printf "$info[INFO]$text ${1^}$endl" >&2; fi
}

RESPONSE() { if [ "${show_response}" == "true" ]; then
  printf "$response[RESPONSE]$delimiter ${1^^} :$text %s$endl" "${2}" >&2; fi
}

ERROR() { if [ "${show_error}" == "true" ]; then
  printf "$error[ERROR]$delimiter ${1^^} :$text ${2^}$endl" >&2; fi
}
