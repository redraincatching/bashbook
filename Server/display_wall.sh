#! /bin/bash

retId=$1
id=$2

if [ $# -ne 2 ]; then
	exit 1	#incorrect no. of args
fi

./checkIDs.sh $id > /dev/null
check=$? #get the exit code from the user check

if [ $check -eq 0 ]; then
	#input=("start of file")
	echo "here now"

	#readarray input < "$id"_wall.txt

	echo "and further"

	#concat with delimiters
	#for i in "${input[@]}"
	#do
	#	output+="$i"
	#done
	output="hi"
	echo $output > "$retId"_pipe
	exit 0
elif [ $check -eq 2 ]; then
	exit 2	#user doesn't exist
fi
