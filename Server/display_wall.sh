#! /bin/bash

id=$1

if [ $# -ne 1 ]; then
	echo "nok: please only enter one user id"
	exit 1
fi

./checkIDs.sh $id
check=$? #get the exit code from the user check

if [ $check -eq 0 ]; then
	echo "start of file"
	cat $id/wall.txt
	echo "end of file"
	exit 0
elif [ $check -eq 2 ]; then
	echo "nok: user $id does not exist"
	exit 2
fi
