FROM ubuntu:latest

# Install Google Cloud SDK
RUN apt-get -y update && apt-get -y dist-upgrade && \
    apt-get -y install lsb-release curl gnupg build-essential git
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get -y update && apt-get -y install google-cloud-sdk-app-engine-go google-cloud-sdk-datastore-emulator

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get -y install nodejs

# Getting Go
RUN apt-get -y install golang-go

# Installing necessary npm packages
RUN npm -g config set user root
RUN npm -g i gulp polymer-cli
