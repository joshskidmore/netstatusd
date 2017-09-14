#!/usr/bin/env bash

INTERVAL_COUNT=$3

[[ $INTERVAL_COUNT != 1 ]] && \
  notify-send "[netstatusd] Internet connectivity has been lost."
