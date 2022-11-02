#! /bin/bash
user1=$1
user2=$2

./checkIDs.sh $user1 $user2
check=$?

if [ $check -ne 0 ];then
	exit 1
fi

grep $user1 $user2/friends.txt > /dev/null
exists=$?
if [ $exists -eq 1 ]; then
	echo "nok: not friends"
	exit 1
else
	echo "ok: friends"
	exit 0
fi
