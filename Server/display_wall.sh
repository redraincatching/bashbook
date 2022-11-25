#! /bin/bash

retId=$1
id=$2

if [ $# -ne 2 ]; then
	exit 1	#incorrect no. of args
fi

./checkIDs.sh "$id" > /dev/null
check=$? #get the exit code from the user check

if [ $check -eq 0 ]; then
	IFS='_'

	input="start of file"
	#append the contents of  the wall to the input array line by line
	mapfile -tO "${#input[@]}" input < "$id"/wall.txt
	input+=("end of file")

	echo "${input[*]}" > "$retId"_pipe	#concat by IFS and echo output

	exit 0
elif [ $check -eq 2 ]; then
	exit 2	#user doesn't exist
fi
