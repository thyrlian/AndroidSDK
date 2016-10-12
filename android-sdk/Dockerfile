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
RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y libncurses5:i386 libc6:i386 libstdc++6:i386 lib32gcc1 lib32ncurses5 lib32z1 zlib1g:i386


# install wget
RUN apt-get install -y wget


# install Java
RUN apt-get install -y --no-install-recommends openjdk-8-jdk


# download and install Android SDK
WORKDIR /opt
RUN wget -q $(wget -q -O- 'https://developer.android.com/sdk' | \
    grep -o "\"https://.*android-sdk.*linux.*\"" | sed "s/\"//g") \
    && tar -xzf android-sdk*linux*.tgz \
    && rm android-sdk*linux*.tgz


# set the environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools


# set the working directory
WORKDIR $ANDROID_HOME
