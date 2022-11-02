#! /bin/bash

echo -e "Welcome to BashBook\nEnter your id:"
read id
./checkIDs.sh $id
if [ $? -ne 0 ]; then
	./createUser.sh $id
fi

while true; do
	echo "Enter a command"
	read request
	case $request in
		add)
			echo "Enter your friends ID"
			read friend
			./add_friend.sh $id $friend
			;;
		post)
			echo "Enter your friends ID"
			read friend
			echo "Enter your message"
			read message
			./post_messages.sh $id $friend $message
			;;
		display)
			echo "Enter your friends ID"
			read friend
			./display_wall.sh $id $friend
			;;
		exit)
			exit 0
			;;
		*)
			echo "Only valid commands are add, post, display or exit"
			;;
	esac
done
