#!/usr/bin/env bash

# if no argument is passed by the user
# the current working directory is used
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
		if [[ ! -d "$ITEM" ]]
		then
			echo "$DEPTH$ITEM";
			continue;
		fi
		if [[
			# not a sym link
			! -L "$ITEM" &&

			# can open
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
