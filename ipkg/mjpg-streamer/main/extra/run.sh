#!/bin/sh

PREFIX=/usr/local
PLUGINS=${PREFIX}/lib/mjpg-streamer
source /etc/default/mjpg-streamer

# Intended to be ran as 'mjpg-streamer-1', et al
i=${0: -1}

if [ -z "${PIDFILE[$i]}" ]; then
  echo "Camera $i not configured in /etc/default/mjpg-streamer"
  exit 1
fi

echo "Starting mjpg-streamer (camera $i)"

FPS="${FPS[$i]}"
RES="${RESOLUTION[$i]}"
PORT="${PORT[$i]}"
INPUT="${INPUT[$i]} -f $FPS -r $RES"
OUTPUT="${OUTPUT[$i]} -p ${PORT}"

exec ${PREFIX}/bin/mjpg_streamer -i "${PLUGINS}/${INPUT}" -o "${PLUGINS}/${OUTPUT}"
