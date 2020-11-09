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
# https://cloud.google.com/sdk/docs/install#deb
# disable update checker for installation
# change JSON for futures updates
ENV GCLOUD_SDK_CONFIG /usr/lib/google-cloud-sdk/lib/googlecloudsdk/core/config.json
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get install -y apt-transport-https ca-certificates gnupg && \
    wget -qO- https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && \
    apt-get install -y google-cloud-sdk && \
    gcloud config set --installation component_manager/disable_update_check true && \
    gcloud config set --installation core/disable_usage_reporting true && \
    sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' $GCLOUD_SDK_CONFIG && \
    sed -i -- 's/\"disable_usage_reporting\": false/\"disable_usage_reporting\": true/g' $GCLOUD_SDK_CONFIG
