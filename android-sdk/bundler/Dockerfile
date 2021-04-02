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
RUN echo apt-get update && apt-get install -y ruby-dev && gem install bundler && apt-get install -y build-essential