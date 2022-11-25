#! /bin/bash

sender="$1"
receiver="$2"
message="$3"

./checkIDs.sh $sender $receiver
check=$?

if [ $check -eq 2 ]; then	
	exit 1 #sender doesn't exist
elif [ $check -eq 3 ]; then
	exit 2 #receiver doesn't exist
elif [ $check -eq 0 ]; then
	./checkFriends.sh $sender $receiver > /dev/null
	friends=$?

	if [ $friends -ne 0 ];then
		exit 3 #users are not friends
	else 
		./acquire.sh $receiver/wall.txt "$receiver"walllock.txt
		echo "$sender: $message" >> ./$receiver/wall.txt
		./release.sh "$receiver"walllock.txt
		exit 0
	fi
fi
