#! /bin/bash
user=$1
./checkIDs.sh $user
# running the command, then checking the exit code
check=$?

#check if the number of arguments is correct
if [ $# -ne 1 ]; then
        echo "nok: incorrect number of arguments"
        exit 1
elif [ $check -eq 0 ] ; then	#if the user already exists
        echo "nok: user already exists" 
        exit 2
elif [ $check -eq 2 ]; then	#set up the user with
        mkdir $user			#a directory
	touch $user/friends.txt		#a friends file
	touch $user/wall.txt		#a wall file
	echo $user > $user/friends.txt	#add themselves to the friends so they can post on their own wall
        echo "ok: user created"	#inform success
        exit 0
fi
