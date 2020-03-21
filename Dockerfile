FROM golang:latest

# Update packages
RUN apt-get -y update && apt-get -y dist-upgrade && \
    apt-get -y install curl gnupg build-essential git less nano

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install Google Cloud SDK
RUN curl https://sdk.cloud.google.com > install.sh
RUN bash install.sh --disable-prompts
ENV PATH=${PATH}:/root/google-cloud-sdk/bin:/usr/local/go/bin
RUN gcloud components update && gcloud components install app-engine-go && \
    gcloud components install cloud-datastore-emulator
RUN rm install.sh

# Install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN . .nvm/nvm.sh && nvm install v13 && npm -g config set user root && npm i -g yarn firebase-tools
