#! /bin/bash

id=$1
friend=$2

./checkIDs.sh $id $friend #check the files
check=$?	#check what the exit code was

./checkFriends.sh $id $friend	#check if friends
friends=$?	

if [ $check -eq 0 ]; then
	if [ $friends -eq 1 ]; then
		echo $friend >> $id/friends.txt	#add friend to friends.txt
		echo $id >> $friend/friends.txt	#add self to friend's friends.txt
		#friendship is symmetric
		echo "ok: friend added"
	else
		echo "nok: friend already added"
		exit 1
	fi
elif [ $check -eq 2 ]; then
	echo "nok: user $id does not exist"
elif [ $check -eq 3 ]; then
	echo "nok: $friend does not exist"
fi
exit 0
