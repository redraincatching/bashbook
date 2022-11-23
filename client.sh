#!/bin/bash
id=$1

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

echo -e "welcome to bashbook" #should look at changing server reads

while true; do
	read -p "enter a command followed by the arguments: " req
	echo $id $req > ./Server/server
	read ret <Server/$id
	echo $ret
done	
