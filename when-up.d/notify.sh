#!/usr/bin/env bash

INTERVAL_COUNT=$3
FAILED_ATTEMPT_COUNT=$4

[[ -f $XDG_CONFIG_HOME/netstatusd/config ]] && \
  source $XDG_CONFIG_HOME/netstatusd/config

[[ $INTERVAL_COUNT != 1 ]] && \
  notify-send "[netstatusd] Internet connectivity has been restored after $((FAILED_ATTEMPT_COUNT/INTERVAL)) seconds."
