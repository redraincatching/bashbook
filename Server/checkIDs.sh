#! /bin/bash

if [ $# -eq 0 ]; then
	echo "nok: too few arguments called on ID check"
	exit 1 #exits with code 1 if there are not enough arguments
else
	index=2
	for id in "$@"; do
		if ! [ -d "$id" ]; then
			exit $index #exits with code of the failed id if an id does not exist
		else
			index=$((index + 1))
		fi
	done
fi
echo "ok: All IDs exist"
exit 0 #exits with code 0 if all the passed ids were found
