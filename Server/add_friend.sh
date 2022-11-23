#! /bin/bash

id=$1
friend=$2

./checkIDs.sh $id $friend #check the files
check=$?	#check what the exit code was

./checkFriends.sh $id $friend #check if friends
friends=$?	

if [ $check -eq 0 ]; then
	if [ $friends -eq 1 ]; then
		echo $friend >> $id/friends.txt	#add friend to friends.txt
		echo $id >> $friend/friends.txt	#add self to friend's friends.txt
		#friendship is symmetric
		exit 0	#exit ok
	else
		exit 1	#friend already added
	fi
elif [ $check -eq 2 ]; then
	exit 2 #user doesn't exist
elif [ $check -eq 3 ]; then
	exit 3 #friend doesn't exist
fi
