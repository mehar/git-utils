#!/bin/bash

set -e # Exit on Error

source "$(dirname $0)/github3.sh"

function validate_args() {
	if [ $# -eq 0 ]
	then
		>&2 echo "Usage $(basename $0) branch" # >&2 is echo to stderr
		exit ${ERR_CODE_SCRIPT_INVALID_ARGS}
	fi
}

validate_args $*
setup_worktree $*