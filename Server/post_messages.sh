#! /bin/bash

sender="$1"
receiver="$2"
message="$3"

./checkIDs.sh $sender $receiver
check=$?

if [ $check -eq 2 ]; then
	echo "nok: sender $sender does not exist"
	exit 1 #just exit if either user doesn't exist
elif [ $check -eq 3 ]; then
	echo "nok: receiver $receiver does not exist"
	exit 1
elif [ $check -eq 0 ]; then
	./checkFriends.sh $sender $receiver
	friends=$?

	if [ $friends -ne 0 ];then
		echo "users $sender and $receiver are not friends"
		exit 2
	else 
		echo "$sender: $message" >> ./$receiver/wall.txt
		echo "message posted"
		exit 0
	fi
fi
