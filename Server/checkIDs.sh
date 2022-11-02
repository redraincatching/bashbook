#! /bin/bash

id1=$1
id2=$2

if [ $# -gt 2 ]; then
	echo "nok: too many arguments called on id check"
	exit 1	#exits with code 1 if there are too many arguments
elif ! [ -d /id1 ]; then
	echo "nok: id does not exist"
	exit 2	#exits with code 2 if the first id does not exist
elif [ $# -ne 1 ] && ! [ -d /id2 ]; then
	echo "nok: second user does not exist"
	exit 3	#exits with code 3 if the second id does not exist and there was a second argument passed
fi
echo "ok: user(s) exist"
exit 0
