#!/bin/bash

if [ -f /tmp/java_home.sh ]; then
  source /tmp/java_home.sh
fi

exec "$@"