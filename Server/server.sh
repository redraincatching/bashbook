#! /bin/bash

echo -e "Welcome to BashBook\n"
read -p "Enter your id (no spaces): " -a id 
./checkIDs.sh ${id[0]}
if [ $? -ne 0 ]; then
	./createUser.sh ${id[0]}
fi

while true; do
	read -p "Enter a command: " request friendID other
	case $request in
		add)
			if ! [ "$friendID" = '' ]; then 
				./add_friend.sh "$id" "$friendID"
			else
				echo "Specify the friend ID"
			fi
			;;
		post)
			if ! [ "$friendID" = '' ] || [ "$other" = '' ]; then
				./post_messages.sh "$id" "$friendID" "$other"
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
