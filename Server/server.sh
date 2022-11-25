#! /bin/bash
trap "rm server" EXIT

mkfifo server	#make the pipe
sleep 1		#wait for the user to enter a command

count=0		#number of users on the server

while true; do
	read id request friendID other < server #get a command
	case $request in #check what the command is and ensure validity for that command, then run the appropriate script
		add)
			if ! [ "$friendID" = '' ]; then 
				./add_friend.sh "$id" "$friendID"
				check=$?

				if [ $check -eq 1 ]; then
			 		echo "nok: friend already added" > "$id"_pipe
				elif [ $check -eq 3 ]; then
					echo "nok: user $friendID doesn't exist" > "$id"_pipe
				else		
					echo "ok: friend $friendID added" > "$id"_pipe
				fi	
			else
				echo "nok: specify the friend ID" > "$id"_pipe
			fi
			;;
		post)
				if ! { [ "$friendID" = '' ] || [ "$other" = '' ]; }; then
					./post_messages.sh "$id" "$friendID" "$other"
					check=$?

					
				        if [ $check -eq 2 ]; then
				 	       echo "nok: receiver $friendID does not exist"
			       		else
			 			echo "ok: message posted" > "$id"_pipe
					fi
				else
					echo "nok: enter the friend ID followed by the message in quotes" > "$id"_pipe
				fi
			;;
		display)
			if ! [ "$friendID" = '' ]; then
				./display_wall.sh "$id" "$friendID"
				check=$?
				
				if [ $check -eq 2 ]; then
					echo "nok: user $friendID does not exist" > "$id"_pipe
				fi
			else
                        	echo "nok: enter the friend ID" > "$id"_pipe
                        fi

			;;
		login)
			((count++))	#record the new user
			echo "Welcome to BashBook $id" > "$id"_pipe	#send a response
			;;
		exit)
			((count--))	#record that a user has left
			echo "exited" > "$id"_pipe	#tell the user to exit
			if [ $count -le 0 ]; then	#if there are no users left
				exit 0			#exit
			fi
			;;
		*)
			echo "only valid commands are add [friend ID], post [friend ID] [message], display [friend ID] or exit" > "$id"_pipe
			;;
	esac
done
