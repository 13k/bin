#!/bin/sh

file=""

function noname {
	echo -e "\rIs something wrong? Are you upset?"
	echo "Try some yoga, go see somebody, go date somebody!"
	echo "Are you going to delete me? Nice! I don't like this poor script life."
	echo "By the way, your file was saved to: $file"
	exit 1
}

if [ -n "$1" ]; then
	TYPE="$1"
else
	TYPE="jpg"
fi

case $1 in
	[jJ][pP][gG]|[pP][nN][gG]);;
	*)
		echo "usage: $0 [jpg|png]"
		exit
		;;
esac

for ((i=5; i>0; i--)); do
	echo -ne "\rTaking screenshot in ... $i"
	sleep 1
done

for ((i=0; i<5; i++)); do
	file=`tempfile -s ".$TYPE"` && break
done

if [ $? -eq 5 ]; then
	echo "Could not create a temporary file [5 retries failed]"
	exit 2
fi

import -w root $file || exit 1

name=""

trap noname SIGINT

while [ -z "$name" ]; do
	echo -en "\rEnter a file name (no ext suffix): "
	read name
done

echo

mv -f $file "$name.$TYPE"
echo "Screenshot saved in: $name.$TYPE"
