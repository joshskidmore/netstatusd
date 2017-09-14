#!/usr/bin/env bash

[[ -f $XDG_CONFIG_HOME/netstatusd/config ]] && \
  source $XDG_CONFIG_HOME/netstatusd/config

curl -s -o $DATA_DIR/geoip-data.json http://pry.sh
