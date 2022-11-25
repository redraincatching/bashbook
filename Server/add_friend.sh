#! /bin/bash

id=$1
friend=$2

./checkIDs.sh "$id" "$friend" #check the files
check=$?	#check what the exit code was	

if [ $check -eq 0 ]; then
	./acquire.sh server.sh friendslocklock.txt #only one person can acquire lock to friend files at a time
	./acquire.sh "$id"/friends.txt "$id"friendslock.txt
	if ! [ $id == $friend ]; then
		./acquire.sh "$friend"/friends.txt "$friend"friendslock.txt
	fi
	./release.sh friendslocklock.txt
	./checkFriends.sh "$id" "$friend"
	friends=$?
	if [ $friends -eq 1 ]; then
		echo "$friend" >> "$id"/friends.txt	#add friend to friends.txt
		echo "$id" >> "$friend"/friends.txt	#add self to friend's friends.txt
		#friendship is symmetric
		./release.sh "$id"friendslock.txt
		./release.sh "$friend"friendslock.txt
		exit 0	#exit ok
	else
		./release.sh "$id"friendslock.txt
		./release.sh "$friend"friendslock.txt
		exit 1	#friend already added
	fi
elif [ $check -eq 2 ]; then
	exit 2 #user doesn't exist
elif [ $check -eq 3 ]; then
	exit 3 #friend doesn't exist
fi
