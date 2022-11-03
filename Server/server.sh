#! /bin/bash

echo -e "Welcome to BashBook\n"
#get the user id - only the first word entered will be used
read -p "Enter your id (no spaces): " -a id #passed to an array using space delimiters
./checkIDs.sh ${id[0]} #check if the id exists
if [ $? -ne 0 ]; then
	./createUser.sh ${id[0]} #if not the new user will be created
fi

while true; do
	read -p "Enter a command: " request friendID other #get a command
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
			exit 0
			;;
		*)
			echo "Only valid commands are add [friend ID], post [friend ID] [message], display [friend ID] or exit"
			;;
	esac
done
