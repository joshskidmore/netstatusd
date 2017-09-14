#!/usr/bin/env bash

[[ -f $XDG_CONFIG_HOME/netstatusd/config ]] && \
  source $XDG_CONFIG_HOME/netstatusd/config

[[ -f $DATA_DIR/geoip-data.json ]] && \
  rm $DATA_DIR/geoip-data.json
