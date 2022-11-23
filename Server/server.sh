#! /bin/bash
trap "rm Server/server" EXIT

mkfifo Server/server

while true; do
	read id request friendID other < Server/server #get a command
	case $request in #check what the command is and ensure validity for that command, then run the appropriate script
		add)
			if ! [ "$friendID" = '' ]; then 
				./Server/add_friend.sh "$id" "$friendID"
				#check not null
				echo "ok: friend $friendID added" > Server/$id 
			else
				echo "nok: specify the friend ID" > Server/$id
			fi
			;;
		post)
			while ! ln -s "$id" "$id"_ln 2>/dev/null
				do
					sleep 1
				done

				if ! { [ "$friendID" = '' ] || [ "$other" = '' ]; }; then
					./Server/post_messages.sh "$id" "$friendID" "$other"
					#check if neither friend nor message are empty 
					echo "ok: message posted" > Server/$id
				else
					echo "nok: enter the friend ID followed by the message in quotes" > Server/$id
				fi

			rm "$id"_ln
			;;
		display)
			if ! [ "$friendID" = '' ]; then
				./Server/display_wall.sh "$friendID"
			else
				echo "nok: enter the friend ID" > Server/$id
			fi
			;;
		exit)
			echo "exited" > Server/$id
			exit 0
			;;
		*)
			echo "only valid commands are add [friend ID], post [friend ID] [message], display [friend ID] or exit" > Server/$id
			;;
	esac
done
