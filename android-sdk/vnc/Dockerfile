# ====================================================================== #
# Android SDK Docker Image (VNC enabled)
# ====================================================================== #

# Base image
# ---------------------------------------------------------------------- #
FROM thyrlian/android-sdk:latest

# Author
# ---------------------------------------------------------------------- #
LABEL maintainer="thyrlian@gmail.com"

# install and configure VNC server
ENV USER=root
ENV DISPLAY=:1
EXPOSE 5901
ADD vncpass.sh /tmp/
ADD vncserver_daemon.sh /usr/local/bin/
ADD watchdog.sh /usr/local/bin/
ADD supervisord_vncserver.conf /etc/supervisor/conf.d/
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xfce4 xfce4-goodies xfonts-base dbus-x11 tightvncserver expect xauth && \
    touch /root/.Xauthority && chmod 600 /root/.Xauthority && \
    xauth generate :1 . trusted && \
    chmod +x /usr/local/bin/vncserver_daemon.sh && \
    chmod +x /tmp/vncpass.sh; sync && \
    /tmp/vncpass.sh && \
    rm /tmp/vncpass.sh && \
    apt-get remove -y expect && apt-get autoremove -y && \
    FILE_SSH_ENV="/root/.ssh/environment" && \
    echo "DISPLAY=:1" >> $FILE_SSH_ENV
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
