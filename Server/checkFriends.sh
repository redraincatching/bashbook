#! /bin/bash
user1=$1
user2=$2

./checkIDs.sh $user1 $user2
check=$?

if [ $check -ne 0 ];then
	exit 1	#first check that all users exist
fi

grep "^$user1$" "$user2"/friends.txt > /dev/null
exists=$?	
#search user2's friends for user1 
#note: friendship is symmetrical
if [ $exists -eq 1 ]; then
	echo "nok: not friends" >> ./log.txt
	exit 1
else
	echo "ok: friends" ./log.txt
	exit 0
fi
