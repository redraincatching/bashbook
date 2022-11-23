#! /bin/bash

id=$1

if [ $# -ne 1 ]; then
	exit 1	#incorrect no. of args
fi

./checkIDs.sh $id > /dev/null
check=$? #get the exit code from the user check

if [ $check -eq 0 ]; then
	#TODO: change it to string concat and pass to pipe
	echo "start of file"
	cat $id/wall.txt
	echo "end of file"
	exit 0
elif [ $check -eq 2 ]; then
	exit 2	#user doesn't exist
fi
