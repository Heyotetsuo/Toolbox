#!/usr/bin/env bash

# - - - - - - - - - - - - -
# File: tree.sh
# Version: 1.0
# Author: Immanuel Morales
# Date: 6/11/2019
# - - - - - - - - - - - - -

# Outputs a recursive listing of all files in a directory.
# The only argument taken is the directory path.
# If no argument is given, the Current Working Directory will be used.

if [[ $1 ]]
then
	TARGET="$1";
else
	TARGET="$PWD";
fi


# recursively lists files
# uses tabs for depth to show
function LIST ()
{
	cd "$1";
	DEPTH="$2";

	# additional verbosity
	# echo "$DEPTH$PWD";

	for ITEM in *;
	do
		# not a directory
		if [[
			# if its not a directory
			! -d "$ITEM"
		]]
		then
			echo "$DEPTH$ITEM";
			continue;
		fi
		if [[
			# if its not a symbolic link
			! -L "$ITEM" &&
			
			# if its a directory
			-d "$ITEM" &&
			
			# if were allowed to open it
			-x "$ITEM"
		]]
		then
			# add a slash
			echo "$DEPTH$ITEM/";

			# add a tab
			DEPTH2=$DEPTH$'\t';

			# recursive LIST call 
			# needs a subshell
			# cause `local` wont
			# work recursively
			(LIST "$ITEM" "$DEPTH2");
		fi
	done;

	exit 0;
}

# removes "*" from empty directories
shopt -s nullglob;

# allow for CTRL+C to interrupt process
trap "exit" SIGINT SIGTERM;

# if you enclose this in a subshell
# include the trap
LIST "$TARGET" "";
