#!/usr/bin/env bash

set -o errexit
set -o pipefail

# -----------------------------------------------------------------------------
# Helper functions start with _ and aren't listed in this script's help menu.
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

function setup {
    echo "Installing python environment via poetry."
    poetry install --no-root
}

function build {
    echo "Building pages."
    poetry run python render.py
}

function serve {
    build
    echo "Serving pages locally."
    poetry run python -m http.server -b 127.0.0.1 -d output/
}

# -----------------------------------------------------------------------------

function help {
  printf "%s <task> [args]\n\nTasks:\n" "${0}"

  compgen -A function | grep -v "^_" | cat -n

  printf "\nExtended help:\n  Each task has comments for general usage\n"
}

TIMEFORMAT=$'\nTask completed in %3lR'
time "${@:-help}"
