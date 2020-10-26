# ====================================================================== #
# Android SDK Docker Image (Firebase Test Lab enabled)
# ====================================================================== #

# Base image
# ---------------------------------------------------------------------- #
FROM thyrlian/android-sdk:latest

# Authors
# ---------------------------------------------------------------------- #
LABEL maintainer "jaime.toca.munoz@gmail.com, thyrlian@gmail.com"

# download Google Cloud SDK and dependencies needed
# disable update checker for installation
# change JSON for futures updates
ARG GCLOUD_SDK_CONFIG=/usr/lib/google-cloud-sdk/lib/googlecloudsdk/core/config.json
RUN apt-get install -y apt-transport-https && \
    apt-get install -y ca-certificates && \
    apt-get install -y gnupg && \
    apt-get install -y curl && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && \
    apt-get update -y && \
    apt-get install google-cloud-sdk -y && \
    /usr/bin/gcloud config set --installation component_manager/disable_update_check true && \
    /usr/bin/gcloud config set --installation core/disable_usage_reporting true && \
    sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' $GCLOUD_SDK_CONFIG && \
    sed -i -- 's/\"disable_usage_reporting\": false/\"disable_usage_reporting\": true/g' $GCLOUD_SDK_CONFIG
