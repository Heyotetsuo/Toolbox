<<<<<<< HEAD
#!/usr/bin/env bash
=======
#!/bin/bash

# - - - - - - - - - - - - -
# File: tree.sh
# Version: 1.0
# Author: Immanuel Morales
# Date: 6/11/2019
# - - - - - - - - - - - - -

# Outputs a recursive listing of all files in a directory.
# The only argument taken is the directory path.
# If no argument is given, the Current Working Directory will be used.
>>>>>>> f67536c1e44fda647fb364c91b0c0b3b3f0e9f40

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
<<<<<<< HEAD
		# not a directory
		if [[ ! -d "$ITEM" ]]
=======
		if [[
			# if its a directory
			-d "$ITEM"
		]]
>>>>>>> f67536c1e44fda647fb364c91b0c0b3b3f0e9f40
		then
			echo "$DEPTH$ITEM";
			continue;
		fi
		if [[
<<<<<<< HEAD
			# not a sym link
			! -L "$ITEM" &&

			# can open
=======
			# if its not a symbolic link
			! -L "$ITEM" &&
			
			# if its a directory
			-d "$ITEM" &&
			
			# if were allowed to open it
>>>>>>> f67536c1e44fda647fb364c91b0c0b3b3f0e9f40
			-x "$ITEM"
		]]
		then
			# add a slash
			echo "$DEPTH$ITEM/";

			# add a tab
			DEPTH2=$DEPTH$'\t';

<<<<<<< HEAD
			# recursive LIST call 
			# needs a subshell
			# cause `local` wont
			# work recursively
			(LIST "$ITEM" "$DEPTH2");
=======
			# recursive call to LIST
			# needs its own subshell
			# because the `local` builtin
			# doesnt work recursively
			( LIST "$ITEM" "$NEWDEPTH" );
>>>>>>> f67536c1e44fda647fb364c91b0c0b3b3f0e9f40
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
