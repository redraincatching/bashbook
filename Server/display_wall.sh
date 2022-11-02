#! /bin/bash

id=$1
./checkIDs.sh $id
check=$? #get the exit code from the user check

if [ $check -eq 0 ]; then
	echo "start of file"
	cat $id/wall.txt
	echo "end of file"
elif [ $check -eq 2 ]; then
	echo "nok: user $id does not exist"
fi
