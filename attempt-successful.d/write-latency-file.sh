#!/usr/bin/env bash

SOURCE=$1
LATENCY=$2

[[ -f $XDG_CONFIG_HOME/netstatusd/config ]] && \
  source $XDG_CONFIG_HOME/netstatusd/config

FORMATTED=""

case "$SOURCE" in
  "secondary")
    FORMATTED="s:$LATENCY"
    ;;

  "walled_garden")
    FORMATTED="w:$LATENCY"
    ;;

  *)
    FORMATTED="$LATENCY"
    ;;
esac


echo "$FORMATTED" > $DATA_DIR/latency
