#! /bin/bash
user=$1
if [ $# -ne 1]; then
	echo "nok: incorrect number of arguments"
	exit 1
elif [ $(./checkIDs.sh user) -eq 0]; then
	$(mkdir user)
	echo "ok: user created"
	exit 0
else 
	echo "nok: user already exists"
	exit 2
