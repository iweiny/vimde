#!/bin/bash
#
# simple script to run a "smart checkout"
#

vimde_home=${HOME}/.vimde

begin=$1
end=$2
output_dir=$3


if [ "$begin" != "$end" ]; then
	cover="--cover-letter"
fi

git merge-base --is-ancestor $begin $end
rc=$?
if [ "$rc" != "0" ]; then
	# problem out of order commits specified.
	# try the opposite
	git merge-base --is-ancestor $end $begin
	rc=$?
	if [ "$rc" != "0" ]; then
		echo "ERROR: $begin -> $end is not valid"
		exit 1
	fi
	echo "WARN: swapping $begin /  $end"
	tmp=$begin
	begin=$end
	end=$tmp
fi


# See if the branch exists
echo -n "Special --subject-prefix ? : "
read subject
if [ "$subject" != "" ]; then
	subject="--subject-prefix='$subject'"
fi

echo "format-patch $begin -> $end"
git format-patch $cover $subject $begin^..$end
mv *.patch $output_dir

echo -n "Edit files (y/n)? "
read ch
if [ "$ch" == "y" ]; then
	vim $output_dir/*.patch
fi

exit 0

