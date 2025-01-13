#!/bin/bash
check_variable() {
    if [ -n "${!1}" ]; then
        echo "$1 is set."
    else
        echo "🗣️  $1 is not set."
        exit 1
    fi
}
