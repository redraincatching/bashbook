#! /bin/bash

retId=$1
id=$2

if [ $# -ne 2 ]; then
	exit 1	#incorrect no. of args
fi

./checkIDs.sh $id > /dev/null
check=$? #get the exit code from the user check

if [ $check -eq 0 ]; then
	echo "start_of_file" > "$retId"_pipe
	output="$(cat "$id"/wall.txt)"
	echo "$output" > "$retId"_pipe
	echo "end_of_file" > "$retId"_pipe
	exit 0
elif [ $check -eq 2 ]; then
	exit 2	#user doesn't exist
fi
