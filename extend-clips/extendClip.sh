#!/usr/bin/env bash

cd "$( dirname "$0" )";

# set file name
if [ -z "$1" ];
then
	echo 'Not Enough Arguments';
	echo 'Usage: ./.extend.sh [file]';
	exit;
else
	f="$1";
fi;

# set new file name
newf="$( sed 's/\.mov/ Long.mov/' <<< "$f" )";

# set loop inpoint
if [ ! -z "$2" ];
then
	i="$2";
else
	i=1;
fi;

# update first line of .list.txt
sed -i '' "1 s/^.*$/file '""$f""'/" .list.txt;

mkdir .tmp 2>/dev/null;

# update loop.mov using pcm to prevent audio artifacts
ffmpeg -y -i "$f" -ss "$i" -c:v copy -c:a pcm_s16le -af volume=0 .tmp/Loop.mov;

# recompress audio to prevent audio artifacts
ffmpeg -f concat -safe 0 -i .list.txt -c:v copy ".tmp/$newf";
