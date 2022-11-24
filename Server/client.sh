#!/bin/bash
id=$1
trap "rm "$id"_pipe" EXIT #trap ctrl+c

if [ $# -ne 1 ]; then
	echo "error: this script requires one id as a parameter"
	exit 1
fi 

	
./checkIDs.sh $id > /dev/null #check if the id exists
if [ $? -ne 0 ]; then
	./createUser.sh $id #if not the new user will be created
fi


if ! [ -e server ]; then	#if server isn't running
	./server.sh &
	echo "started server"
fi

mkfifo "$id"_pipe

echo "welcome to bashbook $id"

while true; do
	read -p "enter a command followed by the arguments: " req
	echo $id $req > ./server
	read ret < "$id"_pipe	

	(echo "$ret" | grep "^nok:") > /dev/null #check if 
	error=$?
	(echo "$ret" | grep "^start of file") > /dev/null
	wall=$?

	if [ $error -eq 0 ];then
		output=$(echo $ret | sed "s/nok: /error: /")
		echo $output	
	elif [ "$ret" == "exited" ]; then
		echo "exiting..."
		exit 0
	elif [ $wall -eq 0 ]; then
		echo "got here at least"
		
		echo $ret
		#if [ "$i" -ne 0 || "$i" -ne "${#array[@]}" ];then
		#	echo "$i"
		#fi
	else
		output=$(echo $ret | sed "s/ok: //")
		echo $output
	fi

done
