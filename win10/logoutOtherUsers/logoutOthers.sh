#!/usr/bin/env bash

if [ -z "$1" ];
then
	echo 'Not enough arguments.';
	echo 'Usage: ./logoutOthers.sh [username]';
	exit;
else
	uname="$( echo -n "$1" | tr '[:upper:]' '[:lower:]' )";
fi;

scanResult="$(
	cmd.exe /c query user |
	grep -v "$uname" |
	grep -v SESSIONNAME
)";

while read line;
do
	session="$(
		echo -n "$line" |
		egrep -o '\s\s\s*.*' |
		egrep -o '^\s*[0-9]*' |
		tr -d ' '
	)";
	name="$(
		echo -n "$line" |
		sed 's/\s\s\s*.*//g' |
		tr -d ' \n'
	)";

	echo "logging off $name in session $session";
	cmd.exe /c 'logoff '"$session";
done <<< "$scanResult";
