#!/bin/bash
id=$1
trap "rm Server/$id" EXIT #trap ctrl+c

if [ $# -ne 1 ]; then
	echo "error: this script requires one id as a parameter"
	exit 1
fi 

	
./checkIDs.sh $id #check if the id exists
if [ $? -ne 0 ]; then
	./Server/createUser.sh $id #if not the new user will be created
fi


if ! [ -e Server/server ]; then	#if server isn't running
	./Server/server.sh &
	echo "started server"
fi

mkfifo Server/$id

echo "welcome to bashbook $id"

while true; do
	read -p "enter a command followed by the arguments: " req
	echo $id $req > ./Server/server
	read ret < Server/$id
	 
	(echo $ret | grep "^nok:") > /dev/null #check if 
	error=$?
	if [ "$ret" = "exited" ];then
		echo "exiting..."
		exit 0
	fi

	if [ $error -eq 1 ];then
		output=$(echo $ret | sed "s/'nok: '/'error: '/")
		echo $output
	else 
		output=$(echo $ret | sed "s/'ok: '//")
		echo $output
	fi	
done	
