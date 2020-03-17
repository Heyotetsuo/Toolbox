#!/usr/bin/env bash

if [ -z "$1" ];
then
	echo 'Not enough arguments.';
	echo 'Usage: ./thesaurus.sh [word]';
	exit;
fi;

word="$1";
data="$(
	curl 'https://www.thesaurus.com/browse/'"$word"'?s=t' 2>/dev/null |
	grep 'INITIAL_STATE.*' |
	sed 's/.* = //; s/;<\/script>//; s/undefined/"NULL"/g'
)";
jqResult="$( 
	jq '.searchData.relatedWordsApiData.data[].synonyms |
	sort_by(.similarity) | reverse[] |
	"\(.term),\(.similarity)"' <<< "$data" |
	tr -d '"'
)";
width="$( wc -L <<< "$jqResult" )";

while read line;
do
	values="$( tr ',' '\n' <<< "$line" )";
	while read val;
	do
		printf "%-""$width""s" "$val";
	done <<< "$values";
	echo;
done <<< "$jqResult";
