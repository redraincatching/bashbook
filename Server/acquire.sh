#! /bin/bash

if [ -z "$1" ]; then
	echo "Usage $1 mutex-name" >&1
	exit 1
else
	while ! ln "$1" "$2" 2> /dev/null; do
		echo "$1 Locked"
		sleep 1
	done

	exit 0
fi

