#!/bin/bash

set -e

ERR_CODE_SCRIPT_INVALID_ARGS=-1001
ERR_CODE_NOT_A_GIT_REPO=-1002

function clone_my_fork_bare() { # setup worktree
	git_repo_name="${GIT_REPO_NAME:=$1}"
	git_username=${GIT_USERNAME:=$(whoami)}  # If variable not set or null, set it to default.
	git_branch_default=${GIT_DEFAULT_BRANCH:=master}

	mkdir -p ${git_repo_name} && pushd ${git_repo_name}

	git clone --bare "https://github_host/${git_username}/${git_repo_name}.git"
	pushd "${git_repo_name}.git"
	
	git remote add upstream "https://github_host/upstream_project/${git_repo_name}.git"
	git fetch upstream # sanity check upstream
	
	popd && popd
}

function setup_worktree() {
	exit_if_not_a_git_repo

	local branch_name="$1"

	set +e
	git ls-remote --exit-code --heads origin "${branch_name}" >/dev/null
	local is_new_branch=false
	if [ "$?" == "2" ]	
	then
		echo "branch ${branch_name} doesn't exist"
		is_new_branch=true
	fi
	set -e

	if [ "${is_new_branch}" == "true" ]
	then
		git worktree add -b ${branch_name} ../${branch_name}
	else
		git worktree add ../${branch_name} ${branch_name}
	fi
}

function exit_if_not_a_git_repo() {
	git rev-parse

	if [ "$?" != 0 ]
	then
		exit ${ERR_CODE_NOT_A_GIT_REPO}
	fi
}
