#!/usr/bin/env bash

[[ -f $XDG_CONFIG_HOME/netstatusd/config ]] && \
  source $XDG_CONFIG_HOME/netstatusd/config


rm $DATA_DIR/*