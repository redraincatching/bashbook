#! /bin/bash
trap "rm server" EXIT

mkfifo server

while true; do
	read id request friendID other < server #get a command
	case $request in #check what the command is and ensure validity for that command, then run the appropriate script
		add)
			if ! [ "$friendID" = '' ]; then 
				./add_friend.sh "$id" "$friendID"
				#check not null
				echo "ok: friend $friendID added" > "$id"_pipe 
			else
				echo "nok: specify the friend ID" > "$id"_pipe
			fi
			;;
		post)
			while ! ln -s "$id" "$id"_ln 2>/dev/null
				do
					sleep 1
				done

				if ! { [ "$friendID" = '' ] || [ "$other" = '' ]; }; then
					./post_messages.sh "$id" "$friendID" "$other"
					#check if neither friend nor message are empty 
					echo "ok: message posted" > "$id"_pipe
				else
					echo "nok: enter the friend ID followed by the message in quotes" > "$id"_pipe
				fi

			rm "$id"_ln
			;;
		display)
			if ! [ "$friendID" = '' ]; then
				./display_wall.sh "$friendID"
			else
				echo "nok: enter the friend ID" > "$id"_pipe
			fi
			;;
		exit)
			echo "exited" > "$id"_pipe
			exit 0
			;;
		*)
			echo "only valid commands are add [friend ID], post [friend ID] [message], display [friend ID] or exit" > "$id"_pipe
			;;
	esac
done
