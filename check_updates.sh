#!/bin/sh

TOKEN="PLACE_TOKEN_HERE"
ROOM="PLACE_ROOM_NAME_HERE"
TO="@all"
HOST=`hostname`

UPDATES=`apt-get update >/dev/null && aptitude -F%p --disable-columns search ~U | awk 'ORS=",+"' | sed 's/,+$/\n/'`

MESSAGE="${TO}: Something went wrong..."

if [ -z "$UPDATES" ]; then
MESSAGE="${TO}:+All+packages+is+updated+(fuckyeah)"
else
MESSAGE="${TO}:+Time+to+update+some+packages:+$UPDATES"
fi

curl "https://api.hipchat.com/v1/rooms/message?auth_token=${TOKEN}&room_id=${ROOM}&from=${HOST}&message=${MESSAGE}&message_format=text&notify=1&color=red" >/dev/null 2>/dev/null
