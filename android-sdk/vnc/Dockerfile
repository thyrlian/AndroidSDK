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
ADD vnc-pass.sh /tmp/
ADD vncserver-daemon.sh /usr/local/bin/
ADD watchdog.sh /usr/local/bin/
ADD supervisord-vncserver.conf /etc/supervisor/conf.d/
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xfce4 xfce4-goodies xfonts-base dbus-x11 tightvncserver expect xauth && \
    touch /root/.Xauthority && chmod 600 /root/.Xauthority && \
    xauth generate :1 . trusted && \
    chmod +x /usr/local/bin/vncserver-daemon.sh && \
    chmod +x /tmp/vnc-pass.sh; sync && \
    /tmp/vnc-pass.sh && \
    rm /tmp/vnc-pass.sh && \
    apt-get remove -y expect && apt-get autoremove -y && \
    FILE_SSH_ENV="/root/.ssh/environment" && \
    echo "DISPLAY=:1" >> $FILE_SSH_ENV
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
