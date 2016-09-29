#!/bin/bash
#
# simple script to run a shell with git commands
#

vimde_home=${HOME}/.vimde

log_opts="--pretty=oneline --decorate --abbrev-commit -n 200"

head=$2

if [ $head == "" ]; then
	# find the head of the branch we are possibly rebasing
	head=`git branch | grep "*" | grep rebasing | sed -e "s/.* rebasing \(.*\))/\1/"`
fi

pushd $1
git log $log_opts $head | vim -s ./vimde/s.gvimrc -S $vimde_home/vimde.git.cmds -n -R -
popd

exit 0

