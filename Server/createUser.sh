#! /bin/bash
user=$1
./acquire.sh "$user" "$user"lock
./checkIDs.sh $user
# running the command, then checking the exit code
check=$?

#check if the number of arguments is correct
if [ $# -ne 1 ]; then
	./release.sh "$user"lock
        exit 1
elif [ $check -eq 0 ] ; then	#if the user already exists 
        ./release.sh "$user"lock
	exit 2
elif [ $check -eq 2 ]; then	#set up the user with
        mkdir $user			#a directory
	touch $user/friends.txt		#a friends file
	touch $user/wall.txt		#a wall file
	echo $user > $user/friends.txt	#add themselves to the friends so they can post on their own wall
        ./release.sh "$user"lock
	exit 0
fi
