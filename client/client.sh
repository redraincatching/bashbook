#!/bin/bash
id=$1

if [ $# -ne 1 ]; then
	echo "error: this script requires one id as a parameter"
	exit 1
fi

echo -e "welcome to bashbook" #should look at changing server reads

while true; do
	read -p "enter a command: " req -a args
	case $req in
		#switch case for requests
		#useful if we need different arg checks for each
		add)
			#TODO: pipe to server
			;;
		post)
			;;
		display)
			;;
		exit)
			exit 0
			;;
		*)
			echo "error message"
			;;
	esac
done	
