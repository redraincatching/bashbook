#!/bin/bash
id=$1
trap 'rm "$id"_pipe' EXIT #trap ctrl+c

if [ $# -ne 1 ]; then
	echo "error: this script requires one id as a parameter"
	exit 1
fi 

	
#check if the id exists
if ! ./checkIDs.sh "$id" ; then
	./createUser.sh "$id" 
	#if not the new user will be created
fi


if ! [ -e server ]; then	#if server isn't running
	./server.sh &
	sleep 1			#wait for the server to make its own pipe
	echo "started server"
fi

mkfifo "$id"_pipe #make the users pipe

echo $id login > ./server	#login to the server
read ret < "$id"_pipe		#get the login response
echo $ret

while true; do
	read -rp "enter a command followed by the arguments: " req
	echo "$id" "$req" > ./server
	read -r ret < "$id"_pipe	

	(echo "$ret" | grep "^nok:") > /dev/null #check if 
	error=$?
	(echo "$ret" | grep "^start of file") > /dev/null
	wall=$?

	if [ $error -eq 0 ];then
		output=$(echo "${ret//nok: /error: }")
		echo "$output"	
	elif [ "$ret" == "exited" ]; then
		echo "exiting..."
		exit 0
	elif [ $wall -eq 0 ]; then
		IFS='_' read -ra out <<< "$ret"
		
		# print all except first and last lines
		length=${#out[@]}
		for (( i=1; i<length-1; i++ )); do			
			printf '%s\n' "${out[$i]}"	
		done
	else
		output=$(echo "${ret//ok: /}")
		echo "$output"
	fi

done
