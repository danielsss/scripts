#!/bin/bash

# Setup volume quickly on platform raspiberry

VOLUME_PERCENT=$1
COMMAND_AMIXER=$(command -v amixer)

if ! [ -x $COMMAND_AMIXER ];
then
  echo "command amixer is not found"
  exit 1
fi;

if [ -n "$VOLUME_PERCENT" ] && [ "$VOLUME_PERCENT" == "$VOLUME_PERCENT" ] 2>/dev/null;
then
  exec $COMMAND_AMIXER set PCM -- "${VOLUME_PERCENT}%"
else
  echo "need a number as volume value"
fi;