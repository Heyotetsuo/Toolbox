#!/bin/bash

# retrieve raw content from the in-focus tweet
source="$( curl "$1" | egrep 'permalink-inner permalink-tweet-container ThreadedConversation ThreadedConversation--permalinkTweetWithAncestors' -A 1000 )";

# get handle from url
handle="$(
	echo "$1" |
	sed -E 's/.+?twitter.com\///' |
	sed -E 's/\/.*//'
)";

# check if "verified" badge exists
verified="$(
	echo "$source" |
	grep -o -m 1 "Verified account"
)";

# get display name
name="$(
	echo "$source" |
	egrep -o -m 1 'data-name=".+?"' |
	sed 's/data-name=//' |
	sed 's/ data-user.*//' |
	tr -d '"'
)";

# get body of tweet
body="$(
	echo "$source" |
	egrep -o "TweetTextSize TweetTextSize--jumbo js-tweet-text tweet-text.+?</p>" |
	grep -zo ">.*<" |
	tr -d '>' |
	tr -d '<'
)";

# get date of tweet
date="$(
	echo "$source" |
	egrep -o -m 1 "tweet-timestamp js-permalink js-nav js-tooltip.+?data-conversation" |
	grep -zo '=.*?'
)";

# for debugging
# echo source: "$source";

echo handle is: "$handle";
echo verified is: "$verified";
echo name is: "$name";
echo body is: "$body";
echo date is: "$date";
