# git-utils
Git/GitHub utility scripts

These utilities maintain the repository and worktrees in the following format
```
- git-repo # Directory
	|
	-- git-repo.git # Bare git repo
	|
	-- <branch-name> # worktree for each branch
```

clone_my_fork.sh <repo_name>
worktree_add.sh <branch_name>