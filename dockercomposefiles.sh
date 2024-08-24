#!/bin/bash
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    ${SCRIPT_NAME} [-hv] COMMAND ...
#%
#% DESCRIPTION
#%    This script serves as a wrapper for Docker Compose commands.
#%    It assists users of the "dockercompose" repository in selecting
#%    a specific software and level, automatically executing the
#%    necessary commands and managing the corresponding files.
#%
#% OPTIONS
#%    -h, --help                    Print this help
#%    -v, --version                 Print script information
#%
#% COMMANDS
#%    run
#%    pull
#%    config
#%    up
#%    down
#%    build
#%    logs
#%    ps
#%    restart
#%    stop
#%    rm
#%
#% EXAMPLES
#%    ${SCRIPT_NAME} pull
#%    ${SCRIPT_NAME} run
#%    ${SCRIPT_NAME} --help
#%
#================================================================
#- IMPLEMENTATION
#-    version         ${SCRIPT_NAME} 0.0.1
#-    author          Alberto Castañeiras
#-
#================================================================
# END_OF_HEADER
#================================================================

#== needed variables ==#
SCRIPT_HEADSIZE=$(head -200 ${0} |grep -n "^# END_OF_HEADER" | cut -f1 -d:)
SCRIPT_NAME="$(basename ${0})"
VALID_PARAMS=("run" "pull" "config" "up" "down" "build" "logs" "ps" "restart" "stop" "rm")
COMMAND=
DCF_FOLDER=
DCF_LEVEL=
DCF_FILES=

#== logger functions ==#
info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
error() { printf "%b[error]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; exit 1; }

#== usage functions ==#
usage() { printf "Usage: "; head -${SCRIPT_HEADSIZE:-99} ${0} | grep -e "^#+" | sed -e "s/^#+[ ]*//g" -e "s/\${SCRIPT_NAME}/${SCRIPT_NAME}/g" ; }
usagefull() { head -${SCRIPT_HEADSIZE:-99} ${0} | grep -e "^#[%+-]" | sed -e "s/^#[%+-]//g" -e "s/\${SCRIPT_NAME}/${SCRIPT_NAME}/g" ; }
scriptinfo() { head -${SCRIPT_HEADSIZE:-99} ${0} | grep -e "^#-" | sed -e "s/^#-//g" -e "s/\${SCRIPT_NAME}/${SCRIPT_NAME}/g"; }

#== script functions ==#
validate_command() {
  local command_to_validate="$1"
  local found=0

  for valid_command in "${VALID_PARAMS[@]}"; do
    if [[ "$valid_command" == "$command_to_validate" ]]; then
      found=1
      break
    fi
  done

  if [[ $found -eq 0 ]]; then
    error "unknown command: "$command_to_validate""
  fi
}

select_folder() {
  DCF_FOLDER=$(find . -type f -name 'compose.yml' -exec dirname {} \; | sed 's|./||' | fzf)
}

select_level() {
  DCF_LEVEL=$(find "${DCF_FOLDER}" -maxdepth 1 -name 'compose*.yml' | sed 's|.*/compose|compose|' | sed 's|\.yml||' | fzf)
}

process_files() {
	if [ "${DCF_LEVEL}" = "compose" ]; then
		DCF_FILES="-f ${DCF_FOLDER}/compose.yml";
	elif [ "${DCF_LEVEL}" = "compose.local" ]; then
		DCF_FILES="-f ${DCF_FOLDER}/compose.yml -f ${DCF_FOLDER}/compose.local.yml";
	elif [ "${DCF_LEVEL}" = "compose.traefik" ]; then
		DCF_FILES="-f ${DCF_FOLDER}/compose.yml -f ${DCF_FOLDER}/compose.traefik.yml";
	fi
}

process_command() {
	case "$COMMAND" in
    run)
      docker compose $DCF_FILES run
      ;;
    pull)
      docker compose $DCF_FILES pull
      ;;
    config)
      docker compose $DCF_FILES config
      ;;
    up)
      docker compose $DCF_FILES up -d
      ;;
    down)
      docker compose $DCF_FILES down -v
      ;;
    build)
      docker compose $DCF_FILES build
      ;;
    logs)
      docker compose $DCF_FILES logs
      ;;
    ps)
      docker compose $DCF_FILES ps
      ;;
    restart)
      docker compose $DCF_FILES restart
      ;;
    stop)
      docker compose $DCF_FILES stop
      ;;
    rm)
      docker compose $DCF_FILES rm
      ;;
  esac
}


main() {
  if [ $# -eq 0 ]; then
    usagefull
    exit 1
  fi

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        usagefull
        exit 0
        ;;
      -v|--version)
        scriptinfo
        exit 0
        ;;
      -*)
        error "unknown option: $1"
        ;;
      *)
        COMMAND="$1"
        validate_command "$COMMAND"
        select_folder
        if [ -n "$DCF_FOLDER" ]; then
          select_level
          if [ -n "$DCF_LEVEL" ]; then
            process_files
            process_command
            exit 0
          fi
        fi
        break
        ;;
    esac
  done
}
main "$@"
