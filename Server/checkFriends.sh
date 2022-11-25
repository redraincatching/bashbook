#! /bin/bash
user1=$1
user2=$2

./checkIDs.sh "$user1" "$user2" > /dev/null
check=$?

if [ $check -ne 0 ];then
	exit 1	#first check that all users exist
fi

grep "^$user1$" "$user2"/friends.txt > /dev/null
exists=$?	
#search user2's friends for user1 
#note: friendship is symmetrical
if [ $exists -eq 1 ]; then
	exit 1	#not friends
else
	exit 0	#friends
fi
