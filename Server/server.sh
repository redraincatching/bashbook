#! /bin/bash

mkfifo Server/server

echo "Reading from pipe" >Server/liam

while true; do
	read id request friendID other <Server/server #get a command
	case $request in #check what the command is and ensure validity for that command, then run the appropriate script
		add)
			if ! [ "$friendID" = '' ]; then 
				./add_friend.sh "$id" "$friendID"
				#check not null
			else
				echo "Specify the friend ID"
			fi
			;;
		post)
			if ! { [ "$friendID" = '' ] || [ "$other" = '' ]; }; then
				./post_messages.sh "$id" "$friendID" "$other"
				#check if neither friend nor message are empty 
			else
				echo "Enter the friend ID followed by the message in quotes"
			fi
			;;
		display)
			if ! [ "$friendID" = '' ]; then
				./display_wall.sh "$friendID"
			else
				echo "Enter the friend ID"
			fi
			;;
		exit)
			rm $id
			echo "exited"
			exit 0
			;;
		*)
			echo "Only valid commands are add [friend ID], post [friend ID] [message], display [friend ID] or exit" > /dev/null
			;;
	esac
done
