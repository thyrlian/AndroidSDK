# ====================================================================== #
# Android SDK Docker Image
# ====================================================================== #

# Base image
# ---------------------------------------------------------------------- #
FROM ubuntu:latest

# Author
# ---------------------------------------------------------------------- #
MAINTAINER Jing Li <thyrlian@gmail.com>

# support multiarch: i386 architecture
# install Java
# install essential tools
# install Qt
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y libncurses5:i386 libc6:i386 libstdc++6:i386 lib32gcc1 lib32ncurses5 lib32z1 zlib1g:i386 && \
    apt-get install -y --no-install-recommends openjdk-8-jdk && \
    apt-get install -y git wget zip && \
    apt-get install -y qt5-default

# download and install Gradle
ENV GRADLE_VERSION 3.2.1
RUN cd /opt && \
    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle*.zip && \
    ls -d */ | sed 's/\/*$//g' | xargs -I{} mv {} gradle && \
    rm gradle*.zip

# download and install Android SDK
RUN mkdir -p /opt/android-sdk && cd /opt/android-sdk && \
    wget -q $(wget -q -O- 'https://developer.android.com/sdk' | \
    grep -o "\"https://.*android.*tools.*linux.*\"" | sed "s/\"//g") && \
    unzip tools_*-linux*.zip && \
    rm tools_*-linux*.zip

# set the environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV GRADLE_HOME /opt/gradle
ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${GRADLE_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin

# accept the license agreements of the SDK components
RUN export ANDROID_LICENSES="$ANDROID_HOME/licenses" && \
    [ -d $ANDROID_LICENSES ] || mkdir $ANDROID_LICENSES && \
    [ -f $ANDROID_LICENSES/android-sdk-license ] || echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > $ANDROID_LICENSES/android-sdk-license && \
    [ -f $ANDROID_LICENSES/android-sdk-preview-license ] || echo 84831b9409646a918e30573bab4c9c91346d8abd > $ANDROID_LICENSES/android-sdk-preview-license && \
    [ -f $ANDROID_LICENSES/intel-android-extra-license ] || echo d975f751698a77b662f1254ddbeed3901e976f5a > $ANDROID_LICENSES/intel-android-extra-license && \
    unset ANDROID_LICENSES

# install and configure SSH server
ADD banner.net /etc/
ADD authorized_keys /tmp/
EXPOSE 22
RUN apt-get install -y openssh-server && \
    echo "Banner /etc/banner.net" >> /etc/ssh/sshd_config && \
    ssh-keygen -q -N "" -f /root/.ssh/id_rsa && \
    touch /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys && \
    for file in /tmp/*.pub; do echo "\n" >> /root/.ssh/authorized_keys && cat $file >> /root/.ssh/authorized_keys && echo "\n" >> /root/.ssh/authorized_keys; done && \
    rm /tmp/*.pub && \
    locale-gen en en_US en_US.UTF-8

CMD ["/bin/bash", "-c", "service ssh start; while true; do sleep 3600; done"]
