#! /bin/bash

id=$1
friend=$2

./checkIDs.sh $id $friend #check the files
check=$?	#check what the exit code was

if [ $check -eq 0 ]; then
	grep $friend $id/friends.txt > /dev/null
	exists=$?
	if [ $exists -eq 1 ]; then
		echo $friend >> $id/friends.txt
		echo $id >> $friend/friends.txt
		echo "ok: friend added"
	else
		echo "friend already added"
		exit 1
	fi
elif [ $check -eq 2 ]; then
	echo "nok: user $id does not exist"
elif [ $check -eq 3 ]; then
	echo "nok: $friend does not exist"
fi
exit 0
