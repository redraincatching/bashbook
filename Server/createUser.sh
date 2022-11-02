#! /bin/bash
user=$1
./checkIDs.sh $user
# running the command, then checking the exit code
check=$?

if [ $# -ne 1 ]; then
        echo "nok: incorrect number of arguments"
        exit 1
elif [ $check -eq 0 ] ; then
        echo "nok: user already exists"
        exit 2
elif [ $check -eq 2 ]; then
        mkdir $user
        echo "ok: user created"
        exit 0
fi
