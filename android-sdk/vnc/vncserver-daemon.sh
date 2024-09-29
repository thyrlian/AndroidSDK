#!/bin/bash

# Start VNC server
vncserver :1 -geometry 1280x800 -depth 24 -fp /usr/share/fonts/X11/misc/

# Get the PID of the VNC server
vnc_pid=$(pgrep -f "Xtightvnc :1")

if [ -z "$vnc_pid" ]; then
  echo "Failed to start VNC server."
  exit 1
fi

# Monitor the VNC server process
echo "VNC server started with PID $vnc_pid. Monitoring..."
while kill -0 $vnc_pid 2> /dev/null; do
  sleep 10
done

# If we reach here, the VNC server has stopped
echo "VNC server process has stopped."
exit 1
