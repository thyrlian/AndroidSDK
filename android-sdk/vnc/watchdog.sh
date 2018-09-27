#!/bin/bash

log_file=/var/log/supervisord/watchdog-stdout.log

function clean_up {
  echo "--------------------------------------------------" >> $log_file
  echo "Removing lock files..." >> $log_file
  rm -fv /tmp/.X*-lock >> $log_file
  rm -fv /tmp/.X11-unix/* >> $log_file
  echo "All lock files are removed!" >> $log_file
  echo "--------------------------------------------------" >> $log_file
  exit 0
}

trap clean_up SIGTERM

while true; do
  sleep 1
done
