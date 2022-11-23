#!/bin/bash
id=$1

trap "rm Server/$id" SIGINT #trap ctrl+c

if [ $# -ne 1 ]; then
	echo "error: this script requires one id as a parameter"
	exit 1
else
	if ! [ -f Server/server ]; then
		./Server/server.sh &
		echo "started server"
	fi
	mkfifo Server/$id
fi

echo "welcome to bashbook"

while true; do
	read -p "enter a command followed by the arguments: " req
	echo $id $req > ./Server/server
	read ret < Server/$id
	 
	grep "^nok:" > /dev/null #check if 
	error=$?		
	if [ $error -eq 1 ];then
		output=$(echo $ret | sed "s/nok: /error: /")
		echo $output
	else 
		output=$(echo $ret | sed "s/ok: //")
		echo $output
	fi	
done	
