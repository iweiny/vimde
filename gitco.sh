#!/bin/bash
#
# simple script to run a "smart checkout"
#

vimde_home=${HOME}/.vimde

branch=$1

echo "Awesome git checker outer..."

# See if the branch exists
git rev-parse --verify --quiet refs/heads/$branch
rc=$?
if [ "$rc" == "0" ]; then
	git checkout $branch
else
	echo "Branch '$branch' does not exist:"
	echo -n "Enter new branch name to checkout: "
	read branch_name
	echo -n "     Create new branch '$branch_name' (y/n)? "
	read ch
	if [ "$ch" == "y" ]; then
		git checkout -b $branch_name $branch
	fi
fi

exit 0

