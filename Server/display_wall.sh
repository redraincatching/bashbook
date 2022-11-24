#! /bin/bash

retId=$1
id=$2

if [ $# -ne 2 ]; then
	exit 1	#incorrect no. of args
fi

./checkIDs.sh $id > /dev/null
check=$? #get the exit code from the user check

if [ $check -eq 0 ]; then
	mapfile -t input < "$id"/wall.txt
	
	output=("start of file_")

	for i in "${input[@]}"; do
		output+="$i"_
	done

	output+="end of file"
	echo $output > "$retId"_pipe

	exit 0
elif [ $check -eq 2 ]; then
	exit 2	#user doesn't exist
fi
