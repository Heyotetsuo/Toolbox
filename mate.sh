#!/usr/bin/env bash

url="https://www.mateheads.com/collections/featured-products/products/club-mate-1\?variant\=6645714883";

while true;
do
	result="$(
		curl "$url" 2>/dev/null |
		grep -i "sold_out : \"Sold Out\""
	)";
	if [ -z "$result" ];
	then
		date '+%H:%M:%S';
		echo "Still sold out...";
		sleep 10;
	else
		echo "OMG THEY HAVE SOME!! GET IT!!";
		open "$url";
		exit;
	fi;
done;
