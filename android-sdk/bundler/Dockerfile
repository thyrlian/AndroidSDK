# ====================================================================== #
# Android SDK Docker Image (Bundler enabled)
# ====================================================================== #

# Base image
# ---------------------------------------------------------------------- #
FROM thyrlian/android-sdk:latest

# Authors
# ---------------------------------------------------------------------- #
LABEL maintainer "anggablokj6@gmail.com, thyrlian@gmail.com"

# Linux Update
# Install Ruby Dev
# Gem Install Bundler
# Install Build Essential
RUN apt-get -y update && apt-get install -y bundler && \ 
	apt-get install -y ruby-dev && gem install bundler